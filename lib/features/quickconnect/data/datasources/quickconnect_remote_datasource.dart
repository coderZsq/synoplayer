import 'package:dartz/dartz.dart';

import '../models/quickconnect_model.dart';
import '../../../../core/error/failures.dart';

/// QuickConnect 远程数据源接口
/// 
/// 定义与远程服务器交互的数据操作
/// 包含网络请求、API 调用等
abstract class QuickConnectRemoteDataSource {
  /// 请求隧道信息
  /// 
  /// [quickConnectId] QuickConnect ID
  /// 
  /// Returns: 成功时返回隧道响应，失败时返回错误
  Future<Either<Failure, TunnelResponseModel?>> requestTunnel(
    String quickConnectId,
  );

  /// 请求服务器信息
  /// 
  /// [quickConnectId] QuickConnect ID
  /// 
  /// Returns: 成功时返回服务器信息，失败时返回错误
  Future<Either<Failure, ServerInfoResponseModel?>> requestServerInfo(
    String quickConnectId,
  );

  /// 测试连接
  /// 
  /// [serverUrl] 服务器地址
  /// 
  /// Returns: 成功时返回连接状态，失败时返回错误
  Future<Either<Failure, QuickConnectConnectionStatusModel>> testConnection(
    String serverUrl,
  );

  /// 请求登录
  /// 
  /// [baseUrl] 基础URL
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// 
  /// Returns: 成功时返回登录响应，失败时返回错误
  Future<Either<Failure, LoginResponseModel>> requestLogin({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  });

  /// 验证会话
  /// 
  /// [baseUrl] 基础URL
  /// [sid] 会话ID
  /// 
  /// Returns: 成功时返回验证结果，失败时返回错误
  Future<Either<Failure, bool>> validateSession({
    required String baseUrl,
    required String sid,
  });

  /// 注销会话
  /// 
  /// [baseUrl] 基础URL
  /// [sid] 会话ID
  /// 
  /// Returns: 成功时返回注销结果，失败时返回错误
  Future<Either<Failure, bool>> logout({
    required String baseUrl,
    required String sid,
  });

  /// 获取性能统计
  /// 
  /// Returns: 成功时返回性能统计，失败时返回错误
  Future<Either<Failure, Map<String, dynamic>>> getPerformanceStats();
}
