import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../models/quickconnect_model.dart';

/// QuickConnect 远程数据源接口
abstract class QuickConnectRemoteDataSource {
  /// 请求隧道信息
  Future<Either<Failure, TunnelResponseModel?>> requestTunnel(String quickConnectId);
  
  /// 请求服务器信息
  Future<Either<Failure, ServerInfoResponseModel?>> requestServerInfo(String quickConnectId);
  
  /// 测试连接
  Future<Either<Failure, bool>> testConnection(String address, {int? port});
  
  /// 登录
  Future<Either<Failure, LoginResponseModel?>> login({
    required String address,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
    int? port,
  });
  
  /// 获取性能统计
  Future<Either<Failure, Map<String, dynamic>>> getPerformanceStats();
}

/// QuickConnect 远程数据源实现
class QuickConnectRemoteDataSourceImpl implements QuickConnectRemoteDataSource {
  QuickConnectRemoteDataSourceImpl({
    required this.dio,
    required this.networkInfo,
  });

  final Dio dio;
  final NetworkInfo networkInfo;

  // API 端点
  static const String _tunnelServiceUrl = 'https://global.quickconnect.to/Serv.php';
  static const String _serverInfoUrl = 'https://cnc.quickconnect.cn/Serv.php';
  
  // 请求头
  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'User-Agent': 'DSfile/12 CFNetwork/3826.600.41 Darwin/24.6.0',
    'Accept': '*/*',
    'Accept-Language': 'en-US,en;q=0.9',
    'Accept-Encoding': 'gzip, deflate, br',
  };
  
  // 超时时间
  static const Duration _tunnelTimeout = Duration(seconds: 30);
  static const Duration _serverInfoTimeout = Duration(seconds: 30);
  static const Duration _connectionTestTimeout = Duration(seconds: 10);
  static const Duration _loginTimeout = Duration(seconds: 30);
  
  // 命令类型
  static const String _commandGetTunnel = 'get_tunnel';
  static const String _commandGetServerInfo = 'get_server_info';
  
  // 服务ID
  static const String _serverIdDsmHttps = 'dsm_https';
  
  // API 版本
  static const int _apiVersion1 = 1;

  @override
  Future<Either<Failure, TunnelResponseModel?>> requestTunnel(String quickConnectId) async {
    try {
      // 检查网络连接
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      final requestBody = {
        "id": _serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": _commandGetTunnel,
        "version": _apiVersion1
      };

      final response = await dio.post<Map<String, dynamic>>(
        _tunnelServiceUrl,
        data: requestBody,
        options: Options(
          headers: _defaultHeaders,
          sendTimeout: _tunnelTimeout,
          receiveTimeout: _tunnelTimeout,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final tunnelResponse = TunnelResponseModel.fromJson(response.data!);
        return Right(tunnelResponse);
      } else {
        return const Left(ServerFailure('隧道请求失败'));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure('隧道请求异常: $e'));
    }
  }

  @override
  Future<Either<Failure, ServerInfoResponseModel?>> requestServerInfo(String quickConnectId) async {
    try {
      // 检查网络连接
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      final requestBody = {
        "get_ca_fingerprints": true,
        "id": _serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": _commandGetServerInfo,
        "version": _apiVersion1
      };

      final response = await dio.post<Map<String, dynamic>>(
        _serverInfoUrl,
        data: requestBody,
        options: Options(
          headers: _defaultHeaders,
          sendTimeout: _serverInfoTimeout,
          receiveTimeout: _serverInfoTimeout,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final serverInfoResponse = ServerInfoResponseModel.fromJson(response.data!);
        return Right(serverInfoResponse);
      } else {
        return const Left(ServerFailure('服务器信息请求失败'));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure('服务器信息请求异常: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> testConnection(String address, {int? port}) async {
    try {
      // 检查网络连接
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      final testPort = port ?? 5001;
      final testUrl = 'https://$address:$testPort/webapi/query.cgi?api=SYNO.API.Info&version=1&method=query&query=SYNO.API.Auth';
      
      final response = await dio.get(
        testUrl,
        options: Options(
          headers: _defaultHeaders,
          sendTimeout: _connectionTestTimeout,
          receiveTimeout: _connectionTestTimeout,
        ),
      );

      return Right(response.statusCode == 200);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Right(false); // 连接超时，返回 false 而不是错误
      }
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure('连接测试异常: $e'));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel?>> login({
    required String address,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
    int? port,
  }) async {
    try {
      // 检查网络连接
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      // 验证输入参数
      if (username.isEmpty || password.isEmpty) {
        return const Left(ValidationFailure('用户名或密码不能为空'));
      }

      final loginPort = port ?? 5001;
      final loginUrl = 'https://$address:$loginPort/webapi/auth.cgi';
      
      final params = <String, String>{
        'api': 'SYNO.API.Auth',
        'version': '3',
        'method': 'login',
        'account': username,
        'passwd': password,
        'session': 'FileStation',
        'format': 'sid',
      };

      if (otpCode != null && otpCode.isNotEmpty) {
        params['otp_code'] = otpCode;
      }

      if (rememberMe) {
        params['enable_syno_token'] = 'yes';
      }

      final response = await dio.post<Map<String, dynamic>>(
        loginUrl,
        queryParameters: params,
        options: Options(
          headers: _defaultHeaders,
          sendTimeout: _loginTimeout,
          receiveTimeout: _loginTimeout,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final loginResponse = LoginResponseModel.fromJson(response.data!);
        return Right(loginResponse);
      } else {
        return const Left(ServerFailure('登录请求失败'));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure('登录异常: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPerformanceStats() async {
    try {
      // 这里可以实现性能统计收集逻辑
      // 例如：请求响应时间、成功率、错误率等
      final stats = <String, dynamic>{
        'totalRequests': 0,
        'successfulRequests': 0,
        'failedRequests': 0,
        'averageResponseTime': 0.0,
        'lastUpdated': DateTime.now().toIso8601String(),
      };
      
      return Right(stats);
    } catch (e) {
      return Left(ServerFailure('获取性能统计失败: $e'));
    }
  }

  /// 处理 Dio 错误
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('请求超时');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const AuthFailure('认证失败');
        } else if (statusCode == 403) {
          return const PermissionFailure('权限不足');
        } else if (statusCode == 404) {
          return const NotFoundFailure('资源不存在');
        } else if (statusCode == 500) {
          return const ServerFailure('服务器内部错误');
        } else {
          return ServerFailure('HTTP 错误: $statusCode');
        }
      case DioExceptionType.cancel:
        return const NetworkFailure('请求被取消');
      case DioExceptionType.connectionError:
        return const NetworkFailure('连接错误');
      default:
        return NetworkFailure('网络错误: ${error.message}');
    }
  }
}
