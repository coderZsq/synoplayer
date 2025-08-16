import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../core/network/index.dart';
import '../../../core/utils/logger.dart';
import '../../../core/config/retrofit_migration_config.dart';
import '../../../core/network/performance_monitor.dart';
import '../constants/quickconnect_constants.dart';
import '../models/quickconnect_models.dart';
import '../models/login_result.dart';
import '../utils/serialization_helper.dart';
import 'quickconnect_api_interface.dart';
import 'quickconnect_retrofit_api.dart';

/// QuickConnect API 适配器
/// 
/// 这个适配器可以选择使用旧的实现或新的 Retrofit 实现
/// 通过配置开关控制，确保平滑过渡
class QuickConnectApiAdapter implements QuickConnectApiInterface {
  QuickConnectApiAdapter({
    required this.apiClient,
    required this.retrofitApi,
  });
  
  final ApiClient apiClient;
  final QuickConnectRetrofitApi retrofitApi;
  static const String _tag = 'QuickConnectApiAdapter';

  // ==================== 地址解析 API ====================
  
  @override
  Future<TunnelResponse?> requestTunnel(String quickConnectId) async {
    try {
      // 首先尝试使用 Retrofit 实现
      final shouldUseRetrofit = await RetrofitMigrationConfig.shouldUseRetrofitForFeature('tunnel');
      
      if (shouldUseRetrofit) {
        AppLogger.info('尝试使用 Retrofit 实现隧道请求', tag: _tag);
        try {
          final result = await _requestTunnelWithRetrofit(quickConnectId);
          if (result != null) {
            AppLogger.success('Retrofit 隧道请求成功', tag: _tag);
            return result;
          }
        } catch (e) {
          AppLogger.warning('Retrofit 隧道请求失败，降级到旧实现: $e', tag: _tag);
        }
      }
      
      // 降级到旧实现
      AppLogger.info('使用旧实现发送隧道请求', tag: _tag);
      return await _requestTunnelWithLegacy(quickConnectId);
      
    } catch (e) {
      AppLogger.error('隧道请求完全失败: $e', tag: _tag);
      return null;
    }
  }
  
  /// 使用 Retrofit 实现隧道请求
  Future<TunnelResponse?> _requestTunnelWithRetrofit(String quickConnectId) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      AppLogger.network('使用 Retrofit 发送隧道请求: $quickConnectId', tag: _tag);
      
      final requestBody = {
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetTunnel,
        "version": QuickConnectConstants.apiVersion1
      };

      final response = await retrofitApi.requestTunnel(requestBody);
      stopwatch.stop();
      
      AppLogger.success('Retrofit 隧道请求成功', tag: _tag);
      
      // 记录性能数据
      NetworkPerformanceMonitor.recordPerformance(
        featureName: 'tunnel',
        implementation: 'retrofit',
        duration: stopwatch.elapsed,
        isSuccess: true,
        metadata: {'quickConnectId': quickConnectId},
      );
      
      return response;
    } catch (e) {
      stopwatch.stop();
      AppLogger.error('Retrofit 隧道请求失败: $e', tag: _tag);
      
      // 记录性能数据
      NetworkPerformanceMonitor.recordPerformance(
        featureName: 'tunnel',
        implementation: 'retrofit',
        duration: stopwatch.elapsed,
        isSuccess: false,
        errorMessage: e.toString(),
        metadata: {'quickConnectId': quickConnectId},
      );
      
      // 降级到旧实现
      AppLogger.info('降级到旧实现', tag: _tag);
      return _requestTunnelWithLegacy(quickConnectId);
    }
  }
  
  /// 使用旧实现隧道请求
  Future<TunnelResponse?> _requestTunnelWithLegacy(String quickConnectId) async {
    try {
      AppLogger.network('使用旧实现发送隧道请求: $quickConnectId', tag: _tag);
      
      final tunnelUrl = Uri.parse(QuickConnectConstants.tunnelServiceUrl);
      final requestBody = {
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetTunnel,
        "version": QuickConnectConstants.apiVersion1
      };

      final response = await apiClient.post<Map<String, dynamic>>(
        tunnelUrl.toString(),
        data: requestBody,
        options: Options(
          headers: QuickConnectConstants.defaultHeaders,
          sendTimeout: QuickConnectConstants.tunnelTimeout,
          receiveTimeout: QuickConnectConstants.tunnelTimeout,
        ),
        fromJson: _parseJsonResponse,
      );

      return response.when(
        success: (data, statusCode, message, extra) {
          AppLogger.success('旧实现隧道请求成功', tag: _tag);
          return SerializationHelper.safeFromMap(
            data,
            TunnelResponse.fromJson,
          );
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('旧实现隧道请求失败: $message', tag: _tag);
          return null;
        },
      );
    } catch (e) {
      AppLogger.error('旧实现隧道请求异常: $e', tag: _tag);
      return null;
    }
  }

  @override
  Future<ServerInfoResponse?> requestServerInfo(String quickConnectId) async {
    try {
      // 首先尝试使用 Retrofit 实现
      final shouldUseRetrofit = await RetrofitMigrationConfig.shouldUseRetrofitForFeature('serverInfo');
      
      if (shouldUseRetrofit) {
        AppLogger.info('尝试使用 Retrofit 实现服务器信息请求', tag: _tag);
        try {
          final result = await _requestServerInfoWithRetrofit(quickConnectId);
          if (result != null) {
            AppLogger.success('Retrofit 服务器信息请求成功', tag: _tag);
            return result;
          }
        } catch (e) {
          AppLogger.warning('Retrofit 服务器信息请求失败，降级到旧实现: $e', tag: _tag);
        }
      }
      
      // 降级到旧实现
      AppLogger.info('使用旧实现发送服务器信息请求', tag: _tag);
      return await _requestServerInfoWithLegacy(quickConnectId);
      
    } catch (e) {
      AppLogger.error('服务器信息请求完全失败: $e', tag: _tag);
      return null;
    }
  }
  
  /// 使用 Retrofit 实现服务器信息请求
  Future<ServerInfoResponse?> _requestServerInfoWithRetrofit(String quickConnectId) async {
    try {
      AppLogger.network('使用 Retrofit 发送服务器信息请求: $quickConnectId', tag: _tag);
      
      final requestBody = {
        "get_ca_fingerprints": true,
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetServerInfo,
        "version": QuickConnectConstants.apiVersion1
      };

      final response = await retrofitApi.requestServerInfo(requestBody);
      AppLogger.success('Retrofit 服务器信息请求成功', tag: _tag);
      
      return response;
    } catch (e) {
      AppLogger.error('Retrofit 服务器信息请求失败: $e', tag: _tag);
      // 降级到旧实现
      AppLogger.info('降级到旧实现', tag: _tag);
      return _requestServerInfoWithLegacy(quickConnectId);
    }
  }
  
  /// 使用旧实现服务器信息请求
  Future<ServerInfoResponse?> _requestServerInfoWithLegacy(String quickConnectId) async {
    try {
      AppLogger.network('使用旧实现发送服务器信息请求: $quickConnectId', tag: _tag);
      
      final serverInfoUrl = Uri.parse(QuickConnectConstants.serverInfoUrl);
      final requestBody = {
        "get_ca_fingerprints": true,
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetServerInfo,
        "version": QuickConnectConstants.apiVersion1
      };

      final response = await apiClient.post<Map<String, dynamic>>(
        serverInfoUrl.toString(),
        data: requestBody,
        options: Options(
          headers: QuickConnectConstants.defaultHeaders,
          sendTimeout: QuickConnectConstants.serverInfoTimeout,
          receiveTimeout: QuickConnectConstants.serverInfoTimeout,
        ),
        fromJson: _parseJsonResponse,
      );

      return response.when(
        success: (data, statusCode, message, extra) {
          AppLogger.success('旧实现服务器信息请求成功', tag: _tag);
          return SerializationHelper.safeFromMap(
            data,
            ServerInfoResponse.fromJson,
          );
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('旧实现服务器信息请求失败: $message', tag: _tag);
          return null;
        },
      );
    } catch (e) {
      AppLogger.error('旧实现服务器信息请求异常: $e', tag: _tag);
      return null;
    }
  }

  @override
  Future<QuickConnectServerInfoResponse?> requestQuickConnectServerInfo({
    required String quickConnectId,
    bool getCaFingerprints = true,
  }) async {
    try {
      // 首先尝试使用 Retrofit 实现
      final shouldUseRetrofit = await RetrofitMigrationConfig.shouldUseRetrofitForFeature('serverInfo');
      
      if (shouldUseRetrofit) {
        AppLogger.info('尝试使用 Retrofit 实现 QuickConnect 全球服务器信息请求', tag: _tag);
        try {
          final result = await _requestQuickConnectServerInfoWithRetrofit(
            quickConnectId: quickConnectId,
            getCaFingerprints: getCaFingerprints,
          );
          if (result != null) {
            AppLogger.success('Retrofit 全球服务器信息请求成功', tag: _tag);
            return result;
          }
        } catch (e) {
          AppLogger.warning('Retrofit 全球服务器信息请求失败，降级到旧实现: $e', tag: _tag);
        }
      }
      
      // 降级到旧实现
      AppLogger.info('使用旧实现发送 QuickConnect 全球服务器信息请求', tag: _tag);
      return await _requestQuickConnectServerInfoWithLegacy(
        quickConnectId: quickConnectId,
        getCaFingerprints: getCaFingerprints,
      );
      
    } catch (e) {
      AppLogger.error('QuickConnect 全球服务器信息请求完全失败: $e', tag: _tag);
      return null;
    }
  }
  
  /// 使用 Retrofit 实现 QuickConnect 服务器信息请求
  Future<QuickConnectServerInfoResponse?> _requestQuickConnectServerInfoWithRetrofit({
    required String quickConnectId,
    bool getCaFingerprints = true,
  }) async {
    try {
      AppLogger.network('使用 Retrofit 发送 QuickConnect 全球服务器信息请求: $quickConnectId', tag: _tag);
      
      final requestBody = {
        "get_ca_fingerprints": getCaFingerprints,
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetServerInfo,
        "version": QuickConnectConstants.apiVersion1
      };

      final response = await retrofitApi.requestQuickConnectServerInfo(requestBody);
      AppLogger.success('Retrofit 全球服务器信息请求成功', tag: _tag);
      
      return response;
    } catch (e) {
      AppLogger.error('Retrofit 全球服务器信息请求失败: $e', tag: _tag);
      // 降级到旧实现
      AppLogger.info('降级到旧实现', tag: _tag);
      return _requestQuickConnectServerInfoWithLegacy(
        quickConnectId: quickConnectId,
        getCaFingerprints: getCaFingerprints,
      );
    }
  }
  
  /// 使用旧实现 QuickConnect 服务器信息请求
  Future<QuickConnectServerInfoResponse?> _requestQuickConnectServerInfoWithLegacy({
    required String quickConnectId,
    bool getCaFingerprints = true,
  }) async {
    try {
      AppLogger.network('使用旧实现发送 QuickConnect 全球服务器信息请求: $quickConnectId', tag: _tag);
      
      // 使用全球 QuickConnect 服务 URL (基于抓包分析)
      const globalServiceUrl = 'https://global.quickconnect.to/Serv.php';
      
      final requestBody = {
        "get_ca_fingerprints": getCaFingerprints,
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetServerInfo,
        "version": QuickConnectConstants.apiVersion1
      };

      final response = await apiClient.post<Map<String, dynamic>>(
        globalServiceUrl,
        data: requestBody,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
            'Accept': '*/*',
            'User-Agent': 'DSfile/12 CFNetwork/3826.600.41 Darwin/24.6.0',
            'Accept-Language': 'en-US,en;q=0.9',
            'Accept-Encoding': 'gzip, deflate, br',
          },
          sendTimeout: QuickConnectConstants.serverInfoTimeout,
          receiveTimeout: QuickConnectConstants.serverInfoTimeout,
        ),
        fromJson: _parseJsonResponse,
      );

      return response.when(
        success: (data, statusCode, message, extra) {
          AppLogger.success('旧实现全球服务器信息请求成功', tag: _tag);
          
          try {
            final serverInfoResponse = QuickConnectServerInfoResponse.fromJson(data);
            return serverInfoResponse;
          } catch (parseError) {
            AppLogger.error('解析全球服务器信息响应失败: $parseError', tag: _tag);
            return null;
          }
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('旧实现全球服务器信息请求失败: $message', tag: _tag);
          return null;
        },
      );
    } catch (e) {
      AppLogger.error('旧实现全球服务器信息请求异常: $e', tag: _tag);
      return null;
    }
  }

  // ==================== 认证登录 API ====================
  
  @override
  Future<LoginResult> requestLogin({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      // 首先尝试使用 Retrofit 实现
      final shouldUseRetrofit = await RetrofitMigrationConfig.shouldUseRetrofitForFeature('login');
      
      if (shouldUseRetrofit) {
        AppLogger.info('尝试使用 Retrofit 实现登录请求', tag: _tag);
        try {
          final result = await _requestLoginWithRetrofit(
            baseUrl: baseUrl,
            username: username,
            password: password,
            otpCode: otpCode,
          );
          if (result.isSuccess || result.requireOTP) {
            AppLogger.success('Retrofit 登录请求成功', tag: _tag);
            return result;
          }
        } catch (e) {
          AppLogger.warning('Retrofit 登录请求失败，降级到旧实现: $e', tag: _tag);
        }
      }
      
      // 降级到旧实现
      AppLogger.info('使用旧实现发送登录请求', tag: _tag);
      return await _requestLoginWithLegacy(
        baseUrl: baseUrl,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
    } catch (e) {
      AppLogger.error('登录请求完全失败: $e', tag: _tag);
      return LoginResult.failure(errorMessage: '登录异常: $e');
    }
  }
  
  /// 使用 Retrofit 实现登录请求
  Future<LoginResult> _requestLoginWithRetrofit({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.userAction('使用 Retrofit 发送登录请求', tag: _tag);
      
      // 输入验证
      if (username.trim().isEmpty || password.trim().isEmpty) {
        AppLogger.error('用户名或密码不能为空', tag: _tag);
        return LoginResult.failure(errorMessage: '用户名或密码不能为空');
      }

      // 为登录请求创建新的 Retrofit 实例，设置正确的 baseUrl
      // 从现有的 retrofitApi 中获取 Dio 实例
      final dio = (retrofitApi as dynamic)._dio as Dio;
      final loginRetrofitApi = QuickConnectRetrofitApi(
        dio,
        baseUrl: baseUrl,
      );

      final response = await loginRetrofitApi.requestLogin(
        'SYNO.API.Auth',
        QuickConnectConstants.apiVersion3.toString(),
        'login',
        username.trim(),
        password.trim(),
        QuickConnectConstants.sessionFileStation,
        QuickConnectConstants.formatSid,
        otpCode?.trim(),
      );

      return _handleLoginResponse(response.data);
      
    } catch (e) {
      AppLogger.error('Retrofit 登录请求异常: $e', tag: _tag);
      // 降级到旧实现
      AppLogger.info('降级到旧实现', tag: _tag);
      return _requestLoginWithLegacy(
        baseUrl: baseUrl,
        username: username,
        password: password,
        otpCode: otpCode,
      );
    }
  }
  
  /// 使用旧实现登录请求
  Future<LoginResult> _requestLoginWithLegacy({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.userAction('使用旧实现发送登录请求', tag: _tag);
      
      // 输入验证
      if (username.trim().isEmpty || password.trim().isEmpty) {
        AppLogger.error('用户名或密码不能为空', tag: _tag);
        return LoginResult.failure(errorMessage: '用户名或密码不能为空');
      }

      // 构建登录参数
      final params = _buildLoginParams(username, password, otpCode);
      AppLogger.network('登录请求参数: ${params.toString()}', tag: _tag);

      // 发送登录请求
      final url = '$baseUrl/webapi/auth.cgi';
      final response = await apiClient.post<Map<String, dynamic>>(
        url,
        data: params,
        options: Options(
          sendTimeout: QuickConnectConstants.loginTimeout,
          receiveTimeout: QuickConnectConstants.loginTimeout,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        fromJson: _parseJsonResponse,
      );

      return response.when(
        success: (data, statusCode, message, extra) {
          return _handleLoginResponse(data);
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('旧实现登录请求失败: $message', tag: _tag);
          return LoginResult.failure(errorMessage: message);
        },
      );
      
    } catch (e) {
      AppLogger.error('旧实现登录请求异常: $e', tag: _tag);
      return LoginResult.failure(errorMessage: '登录异常: $e');
    }
  }

  // ==================== 连接测试 API ====================
  
  @override
  Future<ConnectionTestResult> testConnection(String baseUrl) async {
    try {
      // 首先尝试使用 Retrofit 实现
      final shouldUseRetrofit = await RetrofitMigrationConfig.shouldUseRetrofitForFeature('connectionTest');
      
      if (shouldUseRetrofit) {
        AppLogger.info('尝试使用 Retrofit 实现连接测试', tag: _tag);
        try {
          final result = await _testConnectionWithRetrofit(baseUrl);
          if (result.isConnected) {
            AppLogger.success('Retrofit 连接测试成功', tag: _tag);
            return result;
          }
        } catch (e) {
          AppLogger.warning('Retrofit 连接测试失败，降级到旧实现: $e', tag: _tag);
        }
      }
      
      // 降级到旧实现
      AppLogger.info('使用旧实现测试连接', tag: _tag);
      return await _testConnectionWithLegacy(baseUrl);
      
    } catch (e) {
      AppLogger.error('连接测试完全失败: $e', tag: _tag);
      return ConnectionTestResult.failure(
        baseUrl, 
        '连接测试异常: $e', 
        Duration.zero
      );
    }
  }
  
  /// 使用 Retrofit 实现连接测试
  Future<ConnectionTestResult> _testConnectionWithRetrofit(String baseUrl) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      AppLogger.info('使用 Retrofit 测试连接: $baseUrl', tag: _tag);
      
      // 为连接测试创建新的 Retrofit 实例，设置正确的 baseUrl
      // 从现有的 retrofitApi 中获取 Dio 实例
      final dio = (retrofitApi as dynamic)._dio as Dio;
      final testRetrofitApi = QuickConnectRetrofitApi(
        dio,
        baseUrl: baseUrl,
      );
      
      await testRetrofitApi.testConnection(
        'SYNO.API.Info',
        '1',
        'query',
        'SYNO.API.Auth',
      );
      
      stopwatch.stop();
      AppLogger.success('Retrofit 连接测试成功: $baseUrl', tag: _tag);
      
      return ConnectionTestResult.success(
        baseUrl, 
        200, 
        stopwatch.elapsed
      );
    } on DioException catch (e) {
      stopwatch.stop();
      AppLogger.error('Retrofit 连接测试失败: $baseUrl - ${e.message}', tag: _tag);
      // 降级到旧实现
      AppLogger.info('降级到旧实现', tag: _tag);
      return _testConnectionWithLegacy(baseUrl);
    } catch (e) {
      stopwatch.stop();
      AppLogger.error('Retrofit 连接测试异常: $baseUrl - $e', tag: _tag);
      // 降级到旧实现
      AppLogger.info('降级到旧实现', tag: _tag);
      return _testConnectionWithLegacy(baseUrl);
    }
  }
  
  /// 使用旧实现连接测试
  Future<ConnectionTestResult> _testConnectionWithLegacy(String baseUrl) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      AppLogger.info('使用旧实现测试连接: $baseUrl', tag: _tag);
      
      final url = '$baseUrl/webapi/query.cgi';
      final queryParams = {
        'api': 'SYNO.API.Info',
        'version': '1',
        'method': 'query',
        'query': 'SYNO.API.Auth',
      };
      
      final response = await apiClient.get<Map<String, dynamic>>(
        url,
        queryParameters: queryParams,
        options: Options(
          receiveTimeout: QuickConnectConstants.connectionTestTimeout,
          sendTimeout: QuickConnectConstants.connectionTestTimeout,
        ),
        fromJson: _parseJsonResponse,
      );
      
      stopwatch.stop();
      
      return response.when(
        success: (data, statusCode, message, extra) {
          AppLogger.success('旧实现连接测试成功: $baseUrl', tag: _tag);
          return ConnectionTestResult.success(
            baseUrl, 
            statusCode, 
            stopwatch.elapsed
          );
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('旧实现连接测试失败: $baseUrl - $message', tag: _tag);
          return ConnectionTestResult.failure(
            baseUrl, 
            message, 
            stopwatch.elapsed
          );
        },
      );
    } catch (e) {
      stopwatch.stop();
      AppLogger.error('旧实现连接测试异常: $baseUrl - $e', tag: _tag);
      return ConnectionTestResult.failure(
        baseUrl, 
        '连接异常: $e', 
        stopwatch.elapsed
      );
    }
  }

  // ==================== 批量操作 API ====================
  
  @override
  Future<List<ConnectionTestResult>> testMultipleConnections(List<String> urls) async {
    try {
      AppLogger.info('批量测试连接，共 ${urls.length} 个地址', tag: _tag);
      
      final results = <ConnectionTestResult>[];
      
      for (final url in urls) {
        final result = await testConnection(url);
        results.add(result);
        
        if (result.isConnected) {
          AppLogger.info('连接成功: $url (${result.responseTime.inMilliseconds}ms)', tag: _tag);
        } else {
          AppLogger.warning('连接失败: $url - ${result.error}', tag: _tag);
        }
      }
      
      final successCount = results.where((r) => r.isConnected).length;
      AppLogger.info('批量测试完成: $successCount/${urls.length} 成功', tag: _tag);
      
      return results;
    } catch (e) {
      AppLogger.error('批量连接测试异常: $e', tag: _tag);
      return [];
    }
  }

  // ==================== 私有辅助方法 ====================
  
  /// 解析 JSON 响应
  Map<String, dynamic> _parseJsonResponse(dynamic data) {
    if (data is String) {
      return jsonDecode(data) as Map<String, dynamic>;
    } else {
      return data as Map<String, dynamic>;
    }
  }
  
  /// 构建登录请求参数
  Map<String, String> _buildLoginParams(String username, String password, String? otpCode) {
    final params = <String, String>{
      'api': 'SYNO.API.Auth',
      'version': QuickConnectConstants.apiVersion3.toString(),
      'method': 'login',
      'account': username.trim(),
      'passwd': password.trim(),
      'session': QuickConnectConstants.sessionFileStation,
      'format': QuickConnectConstants.formatSid,
    };

    if (otpCode != null && otpCode.isNotEmpty) {
      params['otp_code'] = otpCode.trim();
      AppLogger.info('包含OTP验证码', tag: _tag);
    }

    return params;
  }
  
  /// 处理登录响应
  LoginResult _handleLoginResponse(Map<String, dynamic> data) {
    try {
      if (data['success'] == true) {
        return _handleSuccessfulLogin(data);
      } else {
        return _handleFailedLogin(data);
      }
    } catch (e) {
      AppLogger.error('解析登录响应失败: $e', tag: _tag);
      return LoginResult.failure(errorMessage: '响应格式错误');
    }
  }
  
  /// 处理成功登录
  LoginResult _handleSuccessfulLogin(Map<String, dynamic> data) {
    final sid = data['data']['sid'];
    AppLogger.success('登录成功! SID: $sid', tag: _tag);
    return LoginResult.success(sid: sid);
  }
  
  /// 处理失败登录
  LoginResult _handleFailedLogin(Map<String, dynamic> data) {
    final errorCode = data['error']?['code'];
    final errorInfo = data['error']?['errors'];
    
    AppLogger.error('登录失败', tag: _tag);
    AppLogger.error('错误代码: $errorCode', tag: _tag);
    
    // 检查是否需要二次验证
    if (errorCode == 403 && errorInfo != null) {
      return _handleTwoFactorAuth(errorInfo);
    }
    
    // 其他错误情况
    final errorMsg = data['error']?['errors']?['passwd'] ?? '未知错误';
    return LoginResult.failure(errorMessage: '登录失败: $errorMsg');
  }
  
  /// 处理二次验证
  LoginResult _handleTwoFactorAuth(Map<String, dynamic> errorInfo) {
    final token = errorInfo['token'];
    final types = errorInfo['types'] as List<dynamic>?;
    
    if (token != null) {
      AppLogger.info('获取到验证令牌: ${token.substring(0, 20)}...', tag: _tag);
    }
    
    if (types != null && types.isNotEmpty) {
      final requiredTypes = types.map((t) => t['type']).toList();
      AppLogger.warning('需要二次验证类型: ${requiredTypes.join(', ')}', tag: _tag);
      
      if (requiredTypes.contains('otp') || requiredTypes.contains('authenticator')) {
        AppLogger.info('需要输入 OTP 验证码', tag: _tag);
        return LoginResult.requireOTP(errorMessage: '需要输入二次验证码 (OTP)');
      }
    }
    
    AppLogger.error('未知的二次验证要求', tag: _tag);
    return LoginResult.failure(errorMessage: '需要二次验证，但类型未知');
  }
}
