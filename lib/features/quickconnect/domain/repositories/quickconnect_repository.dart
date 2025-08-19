import 'package:dartz/dartz.dart';

import '../entities/quickconnect_entity.dart';
import '../../../../core/error/failures.dart';

/// QuickConnect 仓库接口
/// 
/// 定义所有 QuickConnect 相关的数据操作
/// 这是领域层的抽象，不包含具体实现
abstract class QuickConnectRepository {
  /// 解析 QuickConnect ID 获取服务器信息
  /// 
  /// [quickConnectId] QuickConnect ID
  /// 
  /// Returns: 成功时返回服务器信息，失败时返回错误
  Future<Either<Failure, QuickConnectServerInfo>> resolveAddress(
    String quickConnectId,
  );

  /// 获取服务器详细信息
  /// 
  /// [quickConnectId] QuickConnect ID
  /// 
  /// Returns: 成功时返回服务器信息，失败时返回错误
  Future<Either<Failure, QuickConnectServerInfo>> getServerInfo(
    String quickConnectId,
  );

  /// 测试与服务器的连接
  /// 
  /// [address] 服务器地址
  /// [port] 服务器端口（可选）
  /// 
  /// Returns: 成功时返回连接状态，失败时返回错误
  Future<Either<Failure, QuickConnectConnectionStatus>> testConnection(
    String address, {
    int? port,
  });

  /// 登录到服务器
  /// 
  /// [address] 服务器地址
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// [rememberMe] 是否记住登录凭据
  /// [port] 服务器端口（可选）
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> login({
    required String address,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
    int? port,
  });

  /// 智能登录（自动选择最佳登录方式）
  /// 
  /// [quickConnectId] QuickConnect ID
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// [rememberMe] 是否记住登录凭据
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> smartLogin({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
  });

  /// 获取性能统计信息
  /// 
  /// Returns: 成功时返回性能统计，失败时返回错误
  Future<Either<Failure, Map<String, dynamic>>> getPerformanceStats();

  /// 清理过期的缓存数据
  /// 
  /// Returns: 成功时返回清理结果，失败时返回错误
  Future<Either<Failure, bool>> cleanupExpiredCache();

  /// 获取缓存统计信息
  /// 
  /// Returns: 成功时返回缓存统计，失败时返回错误
  Future<Either<Failure, Map<String, dynamic>>> getCacheStats();
}
