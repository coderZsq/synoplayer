import 'package:dartz/dartz.dart';

import '../models/quickconnect_model.dart';
import '../../../../core/error/failures.dart';

/// QuickConnect 本地数据源接口
/// 
/// 定义与本地存储交互的数据操作
/// 包含缓存、本地数据库、SharedPreferences 等
abstract class QuickConnectLocalDataSource {
  /// 缓存服务器信息
  /// 
  /// [serverInfo] 服务器信息
  /// 
  /// Returns: 成功时返回缓存结果，失败时返回错误
  Future<Either<Failure, bool>> cacheServerInfo(
    QuickConnectServerInfoModel serverInfo,
  );

  /// 获取缓存的服务器信息
  /// 
  /// [quickConnectId] QuickConnect ID
  /// 
  /// Returns: 成功时返回服务器信息，失败时返回错误
  Future<Either<Failure, QuickConnectServerInfoModel?>> getCachedServerInfo(
    String quickConnectId,
  );

  /// 缓存连接历史
  /// 
  /// [serverInfo] 服务器信息
  /// 
  /// Returns: 成功时返回缓存结果，失败时返回错误
  Future<Either<Failure, bool>> cacheConnectionHistory(
    QuickConnectServerInfoModel serverInfo,
  );

  /// 获取连接历史
  /// 
  /// Returns: 成功时返回连接历史，失败时返回错误
  Future<Either<Failure, List<QuickConnectServerInfoModel>>> getConnectionHistory();

  /// 清除连接历史
  /// 
  /// Returns: 成功时返回清除结果，失败时返回错误
  Future<Either<Failure, bool>> clearConnectionHistory();

  /// 缓存登录凭据
  /// 
  /// [serverUrl] 服务器地址
  /// [username] 用户名
  /// [password] 密码（加密存储）
  /// [rememberMe] 是否记住我
  /// 
  /// Returns: 成功时返回缓存结果，失败时返回错误
  Future<Either<Failure, bool>> cacheCredentials({
    required String serverUrl,
    required String username,
    required String password,
    required bool rememberMe,
  });

  /// 获取缓存的登录凭据
  /// 
  /// [serverUrl] 服务器地址
  /// 
  /// Returns: 成功时返回凭据，失败时返回错误
  Future<Either<Failure, Map<String, String>?>> getCachedCredentials(
    String serverUrl,
  );

  /// 清除登录凭据
  /// 
  /// [serverUrl] 服务器地址
  /// 
  /// Returns: 成功时返回清除结果，失败时返回错误
  Future<Either<Failure, bool>> clearCredentials(String serverUrl);

  /// 缓存会话信息
  /// 
  /// [serverUrl] 服务器地址
  /// [sid] 会话ID
  /// [expiryTime] 过期时间
  /// 
  /// Returns: 成功时返回缓存结果，失败时返回错误
  Future<Either<Failure, bool>> cacheSession({
    required String serverUrl,
    required String sid,
    required DateTime expiryTime,
  });

  /// 获取缓存的会话信息
  /// 
  /// [serverUrl] 服务器地址
  /// 
  /// Returns: 成功时返回会话信息，失败时返回错误
  Future<Either<Failure, Map<String, dynamic>?>> getCachedSession(
    String serverUrl,
  );

  /// 清除会话信息
  /// 
  /// [serverUrl] 服务器地址
  /// 
  /// Returns: 成功时返回清除结果，失败时返回错误
  Future<Either<Failure, bool>> clearSession(String serverUrl);

  /// 缓存性能统计
  /// 
  /// [stats] 性能统计数据
  /// 
  /// Returns: 成功时返回缓存结果，失败时返回错误
  Future<Either<Failure, bool>> cachePerformanceStats(
    Map<String, dynamic> stats,
  );

  /// 获取缓存的性能统计
  /// 
  /// Returns: 成功时返回性能统计，失败时返回错误
  Future<Either<Failure, Map<String, dynamic>?>> getCachedPerformanceStats();

  /// 检查缓存是否过期
  /// 
  /// [cacheKey] 缓存键
  /// [maxAge] 最大缓存时间
  /// 
  /// Returns: 成功时返回是否过期，失败时返回错误
  Future<Either<Failure, bool>> isCacheExpired(
    String cacheKey,
    Duration maxAge,
  );

  /// 清理过期缓存
  /// 
  /// Returns: 成功时返回清理结果，失败时返回错误
  Future<Either<Failure, bool>> cleanupExpiredCache();
}
