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
  /// [serverUrl] 服务器地址
  /// 
  /// Returns: 成功时返回连接状态，失败时返回错误
  Future<Either<Failure, QuickConnectConnectionStatus>> testConnection(
    String serverUrl,
  );

  /// 登录到服务器
  /// 
  /// [serverUrl] 服务器地址
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> login({
    required String serverUrl,
    required String username,
    required String password,
    String? otpCode,
  });

  /// 智能登录（自动选择最佳登录方式）
  /// 
  /// [serverUrl] 服务器地址
  /// [username] 用户名
  /// [password] 密码
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> smartLogin({
    required String serverUrl,
    required String username,
    required String password,
  });

  /// 验证登录状态
  /// 
  /// [serverUrl] 服务器地址
  /// [sid] 会话ID
  /// 
  /// Returns: 成功时返回验证结果，失败时返回错误
  Future<Either<Failure, bool>> validateSession({
    required String serverUrl,
    required String sid,
  });

  /// 注销登录
  /// 
  /// [serverUrl] 服务器地址
  /// [sid] 会话ID
  /// 
  /// Returns: 成功时返回注销结果，失败时返回错误
  Future<Either<Failure, bool>> logout({
    required String serverUrl,
    required String sid,
  });

  /// 获取连接历史记录
  /// 
  /// Returns: 成功时返回连接历史，失败时返回错误
  Future<Either<Failure, List<QuickConnectServerInfo>>> getConnectionHistory();

  /// 保存连接历史记录
  /// 
  /// [serverInfo] 服务器信息
  /// 
  /// Returns: 成功时返回保存结果，失败时返回错误
  Future<Either<Failure, bool>> saveConnectionHistory(
    QuickConnectServerInfo serverInfo,
  );

  /// 清除连接历史记录
  /// 
  /// Returns: 成功时返回清除结果，失败时返回错误
  Future<Either<Failure, bool>> clearConnectionHistory();

  /// 检查网络连接状态
  /// 
  /// Returns: 成功时返回连接状态，失败时返回错误
  Future<Either<Failure, bool>> checkNetworkConnectivity();

  /// 获取性能统计信息
  /// 
  /// Returns: 成功时返回性能统计，失败时返回错误
  Future<Either<Failure, Map<String, dynamic>>> getPerformanceStats();
}
