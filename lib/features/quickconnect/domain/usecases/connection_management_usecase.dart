import 'package:dartz/dartz.dart';

import '../entities/quickconnect_entity.dart';
import '../repositories/quickconnect_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';

/// 连接管理用例
/// 
/// 集成现有的连接测试和地址管理逻辑
/// 包含批量连接测试、最佳连接选择、连接统计等功能
class ConnectionManagementUseCase {
  const ConnectionManagementUseCase(this._repository);

  final QuickConnectRepository _repository;
  static const String _tag = 'ConnectionManagementUseCase';

  /// 批量测试多个连接
  /// 
  /// [addresses] 要测试的地址列表
  /// [timeout] 连接超时时间
  /// 
  /// Returns: 成功时返回连接测试结果列表，失败时返回错误
  Future<Either<Failure, List<QuickConnectConnectionStatus>>> testMultipleConnections({
    required List<String> addresses,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      AppLogger.info('开始批量测试 ${addresses.length} 个连接', tag: _tag);
      
      final results = <QuickConnectConnectionStatus>[];
      
      for (int i = 0; i < addresses.length; i++) {
        final address = addresses[i];
        AppLogger.info('测试连接 ${i + 1}/${addresses.length}: $address', tag: _tag);
        
        final result = await _repository.testConnection(address);
        
        result.fold(
          (failure) {
            AppLogger.warning('连接测试失败: $address - ${failure.message}', tag: _tag);
            results.add(QuickConnectConnectionStatus(
              isConnected: false,
              responseTime: 0,
              errorMessage: failure.message,
              serverInfo: null,
            ));
          },
          (connectionStatus) {
            AppLogger.success('连接测试成功: $address', tag: _tag);
            results.add(connectionStatus);
          },
        );
      }
      
      AppLogger.info('批量连接测试完成，成功: ${results.where((r) => r.isConnected).length}/${results.length}', tag: _tag);
      return Right(results);
    } catch (e) {
      AppLogger.error('批量连接测试异常: $e', tag: _tag);
      return Left(ServerFailure('批量连接测试异常: $e'));
    }
  }

  /// 找到最佳连接
  /// 
  /// [addresses] 要测试的地址列表
  /// [timeout] 连接超时时间
  /// 
  /// Returns: 成功时返回最佳连接地址，失败时返回错误
  Future<Either<Failure, String?>> findBestConnection({
    required List<String> addresses,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      AppLogger.info('开始寻找最佳连接', tag: _tag);
      
      final connectionResults = await testMultipleConnections(
        addresses: addresses,
        timeout: timeout,
      );
      
      return connectionResults.fold(
        (failure) => Left(failure),
        (results) {
          // 过滤成功的连接
          final successfulConnections = results.where((r) => r.isConnected).toList();
          
          if (successfulConnections.isEmpty) {
            AppLogger.warning('没有找到可用的连接', tag: _tag);
            return const Right(null);
          }
          
          // 按响应时间排序，选择最快的连接
          successfulConnections.sort((a, b) => a.responseTime.compareTo(b.responseTime));
          
          final bestConnection = successfulConnections.first;
          AppLogger.success('找到最佳连接，响应时间: ${bestConnection.responseTime}ms', tag: _tag);
          
          // 这里需要从结果中提取地址信息
          // 由于 QuickConnectConnectionStatus 没有地址字段，我们需要修改实体或使用其他方式
          return const Right(null); // 暂时返回 null，需要进一步设计
        },
      );
    } catch (e) {
      AppLogger.error('寻找最佳连接异常: $e', tag: _tag);
      return Left(ServerFailure('寻找最佳连接异常: $e'));
    }
  }

  /// 获取连接统计信息
  /// 
  /// [connectionResults] 连接测试结果列表
  /// 
  /// Returns: 成功时返回连接统计信息，失败时返回错误
  Either<Failure, Map<String, dynamic>> getConnectionStats(
    List<QuickConnectConnectionStatus> connectionResults,
  ) {
    try {
      final totalConnections = connectionResults.length;
      final successfulConnections = connectionResults.where((r) => r.isConnected).length;
      final failedConnections = totalConnections - successfulConnections;
      
      // 计算平均响应时间
      final successfulResults = connectionResults.where((r) => r.isConnected).toList();
      final averageResponseTime = successfulResults.isNotEmpty
          ? successfulResults.map((r) => r.responseTime).reduce((a, b) => a + b) / successfulResults.length
          : 0.0;
      
      // 找到最快和最慢的连接
      final responseTimes = successfulResults.map((r) => r.responseTime).toList();
      final fastestResponse = responseTimes.isNotEmpty ? responseTimes.reduce((a, b) => a < b ? a : b) : 0;
      final slowestResponse = responseTimes.isNotEmpty ? responseTimes.reduce((a, b) => a > b ? a : b) : 0;
      
      final stats = {
        'totalConnections': totalConnections,
        'successfulConnections': successfulConnections,
        'failedConnections': failedConnections,
        'successRate': totalConnections > 0 ? (successfulConnections / totalConnections * 100).toStringAsFixed(2) : '0.00',
        'averageResponseTime': averageResponseTime.toStringAsFixed(2),
        'fastestResponse': fastestResponse,
        'slowestResponse': slowestResponse,
        'timestamp': DateTime.now().toIso8601String(),
      };
      
      AppLogger.info('连接统计信息: $stats', tag: _tag);
      return Right(stats);
    } catch (e) {
      AppLogger.error('生成连接统计异常: $e', tag: _tag);
      return Left(ServerFailure('生成连接统计异常: $e'));
    }
  }

  /// 执行完整的连接流程
  /// 
  /// [quickConnectId] QuickConnect ID
  /// [timeout] 连接超时时间
  /// 
  /// Returns: 成功时返回完整连接结果，失败时返回错误
  Future<Either<Failure, Map<String, dynamic>>> performFullConnection({
    required String quickConnectId,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      AppLogger.info('开始执行完整连接流程: $quickConnectId', tag: _tag);
      
      // 1. 解析地址
      final addressResult = await _repository.resolveAddress(quickConnectId);
      
      return addressResult.fold(
        (failure) => Left(failure),
        (serverInfo) async {
          AppLogger.success('地址解析成功: ${serverInfo.externalDomain}', tag: _tag);
          
          // 2. 测试连接
          final connectionResult = await _repository.testConnection(
            serverInfo.externalDomain,
            port: serverInfo.port,
          );
          
          return connectionResult.fold(
            (connectionFailure) => Left(connectionFailure),
            (connectionStatus) {
              // 3. 生成连接统计
              final stats = getConnectionStats([connectionStatus]);
              
              return stats.fold(
                (statsFailure) => Left(statsFailure),
                (connectionStats) {
                  // 4. 构建完整结果
                  final fullResult = {
                    'quickConnectId': quickConnectId,
                    'serverInfo': {
                      'externalDomain': serverInfo.externalDomain,
                      'internalIp': serverInfo.internalIp,
                      'port': serverInfo.port,
                      'protocol': serverInfo.protocol,
                      'isOnline': serverInfo.isOnline,
                    },
                    'connectionStatus': {
                      'isConnected': connectionStatus.isConnected,
                      'responseTime': connectionStatus.responseTime,
                      'errorMessage': connectionStatus.errorMessage,
                    },
                    'connectionStats': connectionStats,
                    'timestamp': DateTime.now().toIso8601String(),
                  };
                  
                  AppLogger.success('完整连接流程执行完成', tag: _tag);
                  return Right(fullResult);
                },
              );
            },
          );
        },
      );
    } catch (e) {
      AppLogger.error('完整连接流程异常: $e', tag: _tag);
      return Left(ServerFailure('完整连接流程异常: $e'));
    }
  }

  /// 监控连接状态
  /// 
  /// [address] 要监控的地址
  /// [port] 端口
  /// [interval] 监控间隔
  /// [maxChecks] 最大检查次数
  /// 
  /// Returns: 成功时返回监控结果流，失败时返回错误
  Stream<Either<Failure, QuickConnectConnectionStatus>> monitorConnection({
    required String address,
    int? port,
    Duration interval = const Duration(seconds: 30),
    int maxChecks = 10,
  }) async* {
    try {
      AppLogger.info('开始监控连接: $address', tag: _tag);
      
      int checkCount = 0;
      
      while (checkCount < maxChecks) {
        checkCount++;
        AppLogger.info('连接监控检查 ${checkCount}/$maxChecks: $address', tag: _tag);
        
        final result = await _repository.testConnection(address, port: port);
        
        yield result.fold(
          (failure) => Left(failure),
          (connectionStatus) => Right(connectionStatus),
        );
        
        if (checkCount < maxChecks) {
          await Future.delayed(interval);
        }
      }
      
      AppLogger.info('连接监控完成: $address', tag: _tag);
    } catch (e) {
      AppLogger.error('连接监控异常: $e', tag: _tag);
      yield Left(ServerFailure('连接监控异常: $e'));
    }
  }

  /// 验证连接配置
  /// 
  /// [address] 地址
  /// [port] 端口
  /// 
  /// Returns: 成功时返回验证结果，失败时返回错误
  Either<Failure, bool> validateConnectionConfig({
    required String address,
    int? port,
  }) {
    try {
      // 验证地址格式
      if (address.isEmpty) {
        return const Left(ValidationFailure('地址不能为空'));
      }
      
      // 验证端口范围
      if (port != null && (port < 1 || port > 65535)) {
        return const Left(ValidationFailure('端口必须在 1-65535 范围内'));
      }
      
      // 验证地址格式（简单的 URL 格式验证）
      if (!_isValidAddress(address)) {
        return const Left(ValidationFailure('地址格式无效'));
      }
      
      return const Right(true);
    } catch (e) {
      return Left(ValidationFailure('连接配置验证异常: $e'));
    }
  }

  /// 验证地址格式
  bool _isValidAddress(String address) {
    try {
      // 检查是否是有效的 URL 或 IP 地址
      if (address.contains('://')) {
        final uri = Uri.parse(address);
        return uri.hasScheme && uri.hasAuthority;
      } else {
        // 检查是否是有效的 IP 地址或域名
        return address.isNotEmpty && address.length <= 255;
      }
    } catch (e) {
      return false;
    }
  }
}
