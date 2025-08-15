import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../core/network/index.dart';
import '../../../core/utils/logger.dart';
import '../constants/quickconnect_constants.dart';
import '../models/quickconnect_models.dart';
import '../models/login_result.dart';
import '../utils/serialization_helper.dart';
import 'quickconnect_api_interface.dart';

/// QuickConnect API 实现类
/// 
/// 实现具体的 HTTP 请求逻辑，使用统一的网络层
class QuickConnectApiImpl implements QuickConnectApiInterface {
  QuickConnectApiImpl(this._apiClient);
  
  final ApiClient _apiClient;
  static const String _tag = 'QuickConnectApiImpl';

  // ==================== 地址解析 API 实现 ====================
  
  @override
  Future<TunnelResponse?> requestTunnel(String quickConnectId) async {
    try {
      AppLogger.network('发送隧道请求: $quickConnectId', tag: _tag);
      
      final tunnelUrl = Uri.parse(QuickConnectConstants.tunnelServiceUrl);
      final requestBody = jsonEncode({
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetTunnel,
        "version": QuickConnectConstants.apiVersion1
      });

      AppLogger.network('隧道请求体: $requestBody', tag: _tag);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
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
          AppLogger.success('隧道请求成功', tag: _tag);
          return SerializationHelper.safeFromMap(
            data,
            TunnelResponse.fromJson,
          );
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('隧道请求失败: $message', tag: _tag);
          return null;
        },
      );
    } catch (e) {
      AppLogger.error('隧道请求异常: $e', tag: _tag);
      return null;
    }
  }
  
  @override
  Future<ServerInfoResponse?> requestServerInfo(String quickConnectId) async {
    try {
      AppLogger.network('发送服务器信息请求: $quickConnectId', tag: _tag);
      
      final serverInfoUrl = Uri.parse(QuickConnectConstants.serverInfoUrl);
      final requestBody = jsonEncode({
        "get_ca_fingerprints": true,
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetServerInfo,
        "version": QuickConnectConstants.apiVersion1
      });

      AppLogger.network('服务器信息请求体: $requestBody', tag: _tag);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
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
          AppLogger.success('服务器信息请求成功', tag: _tag);
          AppLogger.debug('原始响应数据: $data', tag: _tag);
          
          return SerializationHelper.safeFromMap(
            data,
            ServerInfoResponse.fromJson,
          );
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('服务器信息请求失败: $message', tag: _tag);
          return null;
        },
      );
    } catch (e) {
      AppLogger.error('服务器信息请求异常: $e', tag: _tag);
      return null;
    }
  }

  // ==================== 认证登录 API 实现 ====================
  
  @override
  Future<LoginResult> requestLogin({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.userAction('发送登录请求', tag: _tag);
      AppLogger.info('登录URL: $baseUrl', tag: _tag);
      AppLogger.info('用户名: $username', tag: _tag);
      AppLogger.info('包含OTP: ${otpCode != null && otpCode.isNotEmpty}', tag: _tag);

      // 1. 输入验证
      if (username.trim().isEmpty || password.trim().isEmpty) {
        AppLogger.error('用户名或密码不能为空', tag: _tag);
        return LoginResult.failure(errorMessage: '用户名或密码不能为空');
      }

      // 2. 构建登录参数
      final params = _buildLoginParams(username, password, otpCode);
      AppLogger.network('登录请求参数: ${params.toString()}', tag: _tag);

      // 3. 发送登录请求
      final url = '$baseUrl/webapi/auth.cgi';
      final response = await _apiClient.post<Map<String, dynamic>>(
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
          AppLogger.error('登录请求失败: $message', tag: _tag);
          return LoginResult.failure(errorMessage: message);
        },
      );
      
    } catch (e) {
      AppLogger.error('登录请求异常: $e', tag: _tag);
      return LoginResult.failure(errorMessage: '登录异常: $e');
    }
  }

  // ==================== 连接测试 API 实现 ====================
  
  @override
  Future<ConnectionTestResult> testConnection(String baseUrl) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      AppLogger.info('测试连接: $baseUrl', tag: _tag);
      
      final url = '$baseUrl/webapi/query.cgi';
      final queryParams = {
        'api': 'SYNO.API.Info',
        'version': '1',
        'method': 'query',
        'query': 'SYNO.API.Auth',
      };
      
      final response = await _apiClient.get<Map<String, dynamic>>(
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
          AppLogger.success('连接测试成功: $baseUrl', tag: _tag);
          return ConnectionTestResult.success(
            baseUrl, 
            statusCode, 
            stopwatch.elapsed
          );
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('连接测试失败: $baseUrl - $message', tag: _tag);
          return ConnectionTestResult.failure(
            baseUrl, 
            message, 
            stopwatch.elapsed
          );
        },
      );
    } catch (e) {
      stopwatch.stop();
      AppLogger.error('连接测试异常: $baseUrl - $e', tag: _tag);
      return ConnectionTestResult.failure(
        baseUrl, 
        '连接异常: $e', 
        stopwatch.elapsed
      );
    }
  }

  // ==================== 批量操作 API 实现 ====================
  
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
