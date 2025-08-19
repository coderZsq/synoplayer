import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/error/failures.dart';
import '../models/quickconnect_model.dart';

/// QuickConnect 本地数据源接口
abstract class QuickConnectLocalDataSource {
  /// 缓存服务器信息
  Future<Either<Failure, bool>> cacheServerInfo(QuickConnectServerInfoModel serverInfo);
  
  /// 获取缓存的服务器信息
  Future<Either<Failure, QuickConnectServerInfoModel?>> getCachedServerInfo(String quickConnectId);
  
  /// 缓存用户凭据
  Future<Either<Failure, bool>> cacheCredentials(LoginRequestModel credentials);
  
  /// 获取缓存的用户凭据
  Future<Either<Failure, LoginRequestModel?>> getCachedCredentials(String username);
  
  /// 缓存连接状态
  Future<Either<Failure, bool>> cacheConnectionStatus(QuickConnectConnectionStatusModel status);
  
  /// 获取缓存的连接状态
  Future<Either<Failure, QuickConnectConnectionStatusModel?>> getCachedConnectionStatus(String address);
  
  /// 缓存性能统计
  Future<Either<Failure, bool>> cachePerformanceStats(Map<String, dynamic> stats);
  
  /// 获取缓存的性能统计
  Future<Either<Failure, Map<String, dynamic>?>> getCachedPerformanceStats();
  
  /// 清除过期的缓存数据
  Future<Either<Failure, bool>> cleanupExpiredCache();
  
  /// 清除所有缓存数据
  Future<Either<Failure, bool>> clearAllCache();
  
  /// 获取缓存统计信息
  Future<Either<Failure, Map<String, dynamic>>> getCacheStats();
}

/// QuickConnect 本地数据源实现
class QuickConnectLocalDataSourceImpl implements QuickConnectLocalDataSource {
  QuickConnectLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.secureStorage,
  });

  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;

  // 缓存键前缀
  static const String _serverInfoPrefix = 'server_info_';
  static const String _credentialsPrefix = 'credentials_';
  static const String _connectionStatusPrefix = 'connection_status_';
  static const String _performanceStatsKey = 'performance_stats';
  static const String _cacheStatsKey = 'cache_stats';
  
  // 缓存过期时间
  static const Duration _serverInfoExpiry = Duration(hours: 24);
  static const Duration _credentialsExpiry = Duration(days: 30);
  static const Duration _connectionStatusExpiry = Duration(hours: 1);
  static const Duration _performanceStatsExpiry = Duration(hours: 6);

  @override
  Future<Either<Failure, bool>> cacheServerInfo(QuickConnectServerInfoModel serverInfo) async {
    try {
      final key = '$_serverInfoPrefix${serverInfo.id}';
      final data = {
        'data': serverInfo.toJson(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'expiry': DateTime.now().add(_serverInfoExpiry).millisecondsSinceEpoch,
      };
      
      final success = await sharedPreferences.setString(key, jsonEncode(data));
      
      if (success) {
        await _updateCacheStats('server_info', 1);
      }
      
      return Right(success);
    } catch (e) {
      return Left(CacheFailure('缓存服务器信息失败: $e'));
    }
  }

  @override
  Future<Either<Failure, QuickConnectServerInfoModel?>> getCachedServerInfo(String quickConnectId) async {
    try {
      final key = '$_serverInfoPrefix$quickConnectId';
      final cachedData = sharedPreferences.getString(key);
      
      if (cachedData == null) {
        return const Right(null);
      }
      
      final data = jsonDecode(cachedData) as Map<String, dynamic>;
      final expiry = data['expiry'] as int;
      
      // 检查是否过期
      if (DateTime.now().millisecondsSinceEpoch > expiry) {
        await sharedPreferences.remove(key);
        await _updateCacheStats('server_info', -1);
        return const Right(null);
      }
      
      final serverInfo = QuickConnectServerInfoModel.fromJson(data['data']);
      return Right(serverInfo);
    } catch (e) {
      return Left(CacheFailure('获取缓存的服务器信息失败: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> cacheCredentials(LoginRequestModel credentials) async {
    try {
      final key = '$_credentialsPrefix${credentials.username}';
      final data = {
        'username': credentials.username,
        'password': credentials.password,
        'otpCode': credentials.otpCode,
        'rememberMe': credentials.rememberMe,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'expiry': DateTime.now().add(_credentialsExpiry).millisecondsSinceEpoch,
      };
      
      // 敏感信息使用安全存储
      await secureStorage.write(
        key: key,
        value: jsonEncode(data),
      );
      
      await _updateCacheStats('credentials', 1);
      
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure('缓存用户凭据失败: $e'));
    }
  }

  @override
  Future<Either<Failure, LoginRequestModel?>> getCachedCredentials(String username) async {
    try {
      final key = '$_credentialsPrefix$username';
      final cachedData = await secureStorage.read(key: key);
      
      if (cachedData == null) {
        return const Right(null);
      }
      
      final data = jsonDecode(cachedData) as Map<String, dynamic>;
      final expiry = data['expiry'] as int;
      
      // 检查是否过期
      if (DateTime.now().millisecondsSinceEpoch > expiry) {
        await secureStorage.delete(key: key);
        await _updateCacheStats('credentials', -1);
        return const Right(null);
      }
      
      final credentials = LoginRequestModel(
        username: data['username'],
        password: data['password'],
        otpCode: data['otpCode'],
        rememberMe: data['rememberMe'] ?? false,
      );
      
      return Right(credentials);
    } catch (e) {
      return Left(CacheFailure('获取缓存的用户凭据失败: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> cacheConnectionStatus(QuickConnectConnectionStatusModel status) async {
    try {
      final key = '$_connectionStatusPrefix${status.serverInfo?.id ?? 'unknown'}';
      final data = {
        'data': status.toJson(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'expiry': DateTime.now().add(_connectionStatusExpiry).millisecondsSinceEpoch,
      };
      
      final success = await sharedPreferences.setString(key, jsonEncode(data));
      
      if (success) {
        await _updateCacheStats('connection_status', 1);
      }
      
      return Right(success);
    } catch (e) {
      return Left(CacheFailure('缓存连接状态失败: $e'));
    }
  }

  @override
  Future<Either<Failure, QuickConnectConnectionStatusModel?>> getCachedConnectionStatus(String address) async {
    try {
      final key = '$_connectionStatusPrefix$address';
      final cachedData = sharedPreferences.getString(key);
      
      if (cachedData == null) {
        return const Right(null);
      }
      
      final data = jsonDecode(cachedData) as Map<String, dynamic>;
      final expiry = data['expiry'] as int;
      
      // 检查是否过期
      if (DateTime.now().millisecondsSinceEpoch > expiry) {
        await sharedPreferences.remove(key);
        await _updateCacheStats('connection_status', -1);
        return const Right(null);
      }
      
      final status = QuickConnectConnectionStatusModel.fromJson(data['data']);
      return Right(status);
    } catch (e) {
      return Left(CacheFailure('获取缓存的连接状态失败: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> cachePerformanceStats(Map<String, dynamic> stats) async {
    try {
      final data = {
        'stats': stats,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'expiry': DateTime.now().add(_performanceStatsExpiry).millisecondsSinceEpoch,
      };
      
      final success = await sharedPreferences.setString(
        _performanceStatsKey,
        jsonEncode(data),
      );
      
      return Right(success);
    } catch (e) {
      return Left(CacheFailure('缓存性能统计失败: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> getCachedPerformanceStats() async {
    try {
      final cachedData = sharedPreferences.getString(_performanceStatsKey);
      
      if (cachedData == null) {
        return const Right(null);
      }
      
      final data = jsonDecode(cachedData) as Map<String, dynamic>;
      final expiry = data['expiry'] as int;
      
      // 检查是否过期
      if (DateTime.now().millisecondsSinceEpoch > expiry) {
        await sharedPreferences.remove(_performanceStatsKey);
        return const Right(null);
      }
      
      return Right(data['stats'] as Map<String, dynamic>);
    } catch (e) {
      return Left(CacheFailure('获取缓存的性能统计失败: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> cleanupExpiredCache() async {
    try {
      final keys = sharedPreferences.getKeys();
      int cleanedCount = 0;
      
      for (final key in keys) {
        if (key.startsWith(_serverInfoPrefix) ||
            key.startsWith(_connectionStatusPrefix) ||
            key == _performanceStatsKey) {
          
          final cachedData = sharedPreferences.getString(key);
          if (cachedData != null) {
            try {
              final data = jsonDecode(cachedData) as Map<String, dynamic>;
              final expiry = data['expiry'] as int;
              
              if (DateTime.now().millisecondsSinceEpoch > expiry) {
                await sharedPreferences.remove(key);
                cleanedCount++;
              }
            } catch (e) {
              // 数据格式错误，删除无效缓存
              await sharedPreferences.remove(key);
              cleanedCount++;
            }
          }
        }
      }
      
      // 清理安全存储中的过期凭据
      final allKeys = await secureStorage.readAll();
      for (final entry in allKeys.entries) {
        if (entry.key.startsWith(_credentialsPrefix)) {
          try {
            final data = jsonDecode(entry.value) as Map<String, dynamic>;
            final expiry = data['expiry'] as int;
            
            if (DateTime.now().millisecondsSinceEpoch > expiry) {
              await secureStorage.delete(key: entry.key);
              cleanedCount++;
            }
          } catch (e) {
            // 数据格式错误，删除无效缓存
            await secureStorage.delete(key: entry.key);
            cleanedCount++;
          }
        }
      }
      
      await _updateCacheStats('cleanup', -cleanedCount);
      return Right(true);
    } catch (e) {
      return Left(CacheFailure('清理过期缓存失败: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> clearAllCache() async {
    try {
      // 清理 SharedPreferences 缓存
      final keys = sharedPreferences.getKeys();
      for (final key in keys) {
        if (key.startsWith(_serverInfoPrefix) ||
            key.startsWith(_connectionStatusPrefix) ||
            key == _performanceStatsKey ||
            key == _cacheStatsKey) {
          await sharedPreferences.remove(key);
        }
      }
      
      // 清理安全存储中的凭据
      final allKeys = await secureStorage.readAll();
      for (final entry in allKeys.entries) {
        if (entry.key.startsWith(_credentialsPrefix)) {
          await secureStorage.delete(key: entry.key);
        }
      }
      
      // 重置缓存统计
      await _updateCacheStats('reset', 0);
      
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure('清除所有缓存失败: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCacheStats() async {
    try {
      final cachedStats = sharedPreferences.getString(_cacheStatsKey);
      if (cachedStats != null) {
        final data = jsonDecode(cachedStats) as Map<String, dynamic>;
        return Right(data);
      }
      
      // 返回默认统计
      return Right({
        'server_info': 0,
        'credentials': 0,
        'connection_status': 0,
        'last_cleanup': null,
        'total_cleanups': 0,
      });
    } catch (e) {
      return Left(CacheFailure('获取缓存统计失败: $e'));
    }
  }

  /// 更新缓存统计信息
  Future<void> _updateCacheStats(String type, int change) async {
    try {
      final currentStats = await getCacheStats();
      currentStats.fold(
        (failure) => null,
        (stats) async {
          final newStats = Map<String, dynamic>.from(stats);
          
          if (type == 'reset') {
            newStats['server_info'] = 0;
            newStats['credentials'] = 0;
            newStats['connection_status'] = 0;
            newStats['last_cleanup'] = DateTime.now().toIso8601String();
            newStats['total_cleanups'] = (newStats['total_cleanups'] ?? 0) + 1;
          } else if (type == 'cleanup') {
            newStats['last_cleanup'] = DateTime.now().toIso8601String();
            newStats['total_cleanups'] = (newStats['total_cleanups'] ?? 0) + 1;
          } else {
            final currentCount = (newStats[type] ?? 0) as int;
            newStats[type] = currentCount + change;
            if (newStats[type] < 0) newStats[type] = 0;
          }
          
          await sharedPreferences.setString(_cacheStatsKey, jsonEncode(newStats));
        },
      );
    } catch (e) {
      // 忽略统计更新失败
    }
  }
}
