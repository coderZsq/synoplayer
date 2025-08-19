import 'package:dartz/dartz.dart';

import '../entities/quickconnect_entity.dart';
import '../repositories/quickconnect_repository.dart';
import '../usecases/enhanced_smart_login_usecase.dart';
import '../usecases/connection_management_usecase.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';

/// QuickConnect 服务适配器
/// 
/// 将现有的 QuickConnect 服务逻辑桥接到新的 Clean Architecture
/// 提供向后兼容的接口，同时利用新的架构优势
class QuickConnectServiceAdapter {
  const QuickConnectServiceAdapter({
    required this.repository,
    required this.enhancedSmartLoginUseCase,
    required this.connectionManagementUseCase,
  });

  final QuickConnectRepository repository;
  final EnhancedSmartLoginUseCase enhancedSmartLoginUseCase;
  final ConnectionManagementUseCase connectionManagementUseCase;
  
  static const String _tag = 'QuickConnectServiceAdapter';

  // ==================== 地址解析 ====================
  
  /// 解析 QuickConnect ID 获取可用地址
  Future<String?> resolveAddress(String quickConnectId) async {
    try {
      AppLogger.info('解析 QuickConnect 地址: $quickConnectId', tag: _tag);
      
      final result = await repository.resolveAddress(quickConnectId);
      
      return result.fold(
        (failure) {
          AppLogger.warning('地址解析失败: ${failure.message}', tag: _tag);
          return null;
        },
        (serverInfo) {
          AppLogger.success('地址解析成功: ${serverInfo.externalDomain}', tag: _tag);
          return serverInfo.externalDomain;
        },
      );
    } catch (e) {
      AppLogger.error('地址解析异常: $e', tag: _tag);
      return null;
    }
  }

  /// 获取所有可用地址的详细信息
  Future<List<Map<String, dynamic>>> getAllAddressesWithDetails(String quickConnectId) async {
    try {
      AppLogger.info('获取所有地址详细信息: $quickConnectId', tag: _tag);
      
      final result = await repository.resolveAddress(quickConnectId);
      
      return result.fold(
        (failure) {
          AppLogger.warning('获取地址详细信息失败: ${failure.message}', tag: _tag);
          return [];
        },
        (serverInfo) {
          final addressInfo = {
            'url': serverInfo.externalDomain,
            'type': 'primary',
            'priority': 1,
            'port': serverInfo.port,
            'protocol': serverInfo.protocol,
            'isOnline': serverInfo.isOnline,
          };
          
          AppLogger.success('获取地址详细信息成功', tag: _tag);
          return [addressInfo];
        },
      );
    } catch (e) {
      AppLogger.error('获取地址详细信息异常: $e', tag: _tag);
      return [];
    }
  }

  // ==================== 认证登录 ====================
  
  /// 登录群晖 Auth API 获取 SID
  Future<Map<String, dynamic>> login({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.info('开始登录: $baseUrl', tag: _tag);
      
      final result = await repository.login(
        address: baseUrl,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      return result.fold(
        (failure) {
          AppLogger.warning('登录失败: ${failure.message}', tag: _tag);
          return {
            'success': false,
            'error': failure.message,
            'sid': null,
          };
        },
        (loginResult) {
          if (loginResult.isSuccess) {
            AppLogger.success('登录成功', tag: _tag);
            return {
              'success': true,
              'error': null,
              'sid': loginResult.sid,
              'redirectUrl': loginResult.redirectUrl,
            };
          } else {
            AppLogger.warning('登录失败: ${loginResult.errorMessage}', tag: _tag);
            return {
              'success': false,
              'error': loginResult.errorMessage,
              'sid': null,
            };
          }
        },
      );
    } catch (e) {
      AppLogger.error('登录异常: $e', tag: _tag);
      return {
        'success': false,
        'error': '登录异常: $e',
        'sid': null,
      };
    }
  }

  /// 使用指定地址进行 OTP 登录
  Future<Map<String, dynamic>> loginWithOTPAtAddress({
    required String baseUrl,
    required String username,
    required String password,
    required String otpCode,
  }) async {
    try {
      AppLogger.info('开始 OTP 登录: $baseUrl', tag: _tag);
      
      final result = await repository.login(
        address: baseUrl,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      return result.fold(
        (failure) {
          AppLogger.warning('OTP 登录失败: ${failure.message}', tag: _tag);
          return {
            'success': false,
            'error': failure.message,
            'sid': null,
          };
        },
        (loginResult) {
          if (loginResult.isSuccess) {
            AppLogger.success('OTP 登录成功', tag: _tag);
            return {
              'success': true,
              'error': null,
              'sid': loginResult.sid,
              'redirectUrl': loginResult.redirectUrl,
            };
          } else {
            AppLogger.warning('OTP 登录失败: ${loginResult.errorMessage}', tag: _tag);
            return {
              'success': false,
              'error': loginResult.errorMessage,
              'sid': null,
            };
          }
        },
      );
    } catch (e) {
      AppLogger.error('OTP 登录异常: $e', tag: _tag);
      return {
        'success': false,
        'error': 'OTP 登录异常: $e',
        'sid': null,
      };
    }
  }

  // ==================== 连接测试 ====================
  
  /// 测试连接是否可用
  Future<Map<String, dynamic>> testConnection(String baseUrl) async {
    try {
      AppLogger.info('测试连接: $baseUrl', tag: _tag);
      
      final result = await repository.testConnection(baseUrl);
      
      return result.fold(
        (failure) {
          AppLogger.warning('连接测试失败: ${failure.message}', tag: _tag);
          return {
            'isConnected': false,
            'error': failure.message,
            'responseTime': 0,
          };
        },
        (connectionStatus) {
          AppLogger.success('连接测试完成: ${connectionStatus.isConnected ? '成功' : '失败'}', tag: _tag);
          return {
            'isConnected': connectionStatus.isConnected,
            'error': connectionStatus.errorMessage,
            'responseTime': connectionStatus.responseTime,
          };
        },
      );
    } catch (e) {
      AppLogger.error('连接测试异常: $e', tag: _tag);
      return {
        'isConnected': false,
        'error': '连接测试异常: $e',
        'responseTime': 0,
      };
    }
  }

  /// 批量测试连接
  Future<List<Map<String, dynamic>>> testMultipleConnections(List<String> urls) async {
    try {
      AppLogger.info('批量测试连接: ${urls.length} 个地址', tag: _tag);
      
      final result = await connectionManagementUseCase.testMultipleConnections(
        addresses: urls,
      );
      
      return result.fold(
        (failure) {
          AppLogger.warning('批量连接测试失败: ${failure.message}', tag: _tag);
          return [];
        },
        (connectionStatuses) {
          final results = connectionStatuses.map((status) => {
            'isConnected': status.isConnected,
            'error': status.errorMessage,
            'responseTime': status.responseTime,
          }).toList();
          
          AppLogger.success('批量连接测试完成', tag: _tag);
          return results;
        },
      );
    } catch (e) {
      AppLogger.error('批量连接测试异常: $e', tag: _tag);
      return [];
    }
  }

  /// 测试连接并返回最佳地址
  Future<String?> findBestConnection(List<String> urls) async {
    try {
      AppLogger.info('寻找最佳连接: ${urls.length} 个地址', tag: _tag);
      
      final result = await connectionManagementUseCase.findBestConnection(
        addresses: urls,
      );
      
      return result.fold(
        (failure) {
          AppLogger.warning('寻找最佳连接失败: ${failure.message}', tag: _tag);
          return null;
        },
        (bestAddress) {
          AppLogger.success('找到最佳连接: $bestAddress', tag: _tag);
          return bestAddress;
        },
      );
    } catch (e) {
      AppLogger.error('寻找最佳连接异常: $e', tag: _tag);
      return null;
    }
  }

  /// 获取所有可用的连接地址
  Future<List<String>> getAllAvailableAddresses(String quickConnectId) async {
    try {
      AppLogger.info('获取所有可用连接地址: $quickConnectId', tag: _tag);
      
      final result = await repository.resolveAddress(quickConnectId);
      
      return result.fold(
        (failure) {
          AppLogger.warning('获取可用连接地址失败: ${failure.message}', tag: _tag);
          return [];
        },
        (serverInfo) {
          final addresses = <String>[];
          if (serverInfo.isOnline) {
            addresses.add(serverInfo.externalDomain);
          }
          
          AppLogger.success('获取可用连接地址成功: ${addresses.length} 个', tag: _tag);
          return addresses;
        },
      );
    } catch (e) {
      AppLogger.error('获取可用连接地址异常: $e', tag: _tag);
      return [];
    }
  }

  /// 获取所有可用的连接地址详细信息
  Future<List<Map<String, dynamic>>> getAllAvailableAddressesWithDetails(String quickConnectId) async {
    try {
      AppLogger.info('获取所有可用连接地址详细信息: $quickConnectId', tag: _tag);
      
      final result = await repository.resolveAddress(quickConnectId);
      
      return result.fold(
        (failure) {
          AppLogger.warning('获取可用连接地址详细信息失败: ${failure.message}', tag: _tag);
          return [];
        },
        (serverInfo) {
          final addresses = <Map<String, dynamic>>[];
          if (serverInfo.isOnline) {
            addresses.add({
              'url': serverInfo.externalDomain,
              'type': 'primary',
              'priority': 1,
              'port': serverInfo.port,
              'protocol': serverInfo.protocol,
              'isOnline': serverInfo.isOnline,
            });
          }
          
          AppLogger.success('获取可用连接地址详细信息成功: ${addresses.length} 个', tag: _tag);
          return addresses;
        },
      );
    } catch (e) {
      AppLogger.error('获取可用连接地址详细信息异常: $e', tag: _tag);
      return [];
    }
  }

  // ==================== 智能登录 ====================
  
  /// 智能登录 - 自动尝试所有可用地址
  Future<Map<String, dynamic>> smartLogin({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.info('开始智能登录: $quickConnectId', tag: _tag);
      
      final result = await enhancedSmartLoginUseCase.execute(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      return result.fold(
        (failure) {
          AppLogger.warning('智能登录失败: ${failure.message}', tag: _tag);
          return {
            'success': false,
            'error': failure.message,
            'sid': null,
          };
        },
        (loginResult) {
          if (loginResult.isSuccess) {
            AppLogger.success('智能登录成功', tag: _tag);
            return {
              'success': true,
              'error': null,
              'sid': loginResult.sid,
              'redirectUrl': loginResult.redirectUrl,
            };
          } else {
            AppLogger.warning('智能登录失败: ${loginResult.errorMessage}', tag: _tag);
            return {
              'success': false,
              'error': loginResult.errorMessage,
              'sid': null,
            };
          }
        },
      );
    } catch (e) {
      AppLogger.error('智能登录异常: $e', tag: _tag);
      return {
        'success': false,
        'error': '智能登录异常: $e',
        'sid': null,
      };
    }
  }

  /// 智能登录并返回详细结果
  Future<Map<String, dynamic>> smartLoginWithDetails({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.info('开始智能登录（详细模式）: $quickConnectId', tag: _tag);
      
      // 使用增强的智能登录用例
      final result = await enhancedSmartLoginUseCase.executeWithMultipleAddresses(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      return result.fold(
        (failure) {
          AppLogger.warning('智能登录（详细模式）失败: ${failure.message}', tag: _tag);
          return {
            'success': false,
            'error': failure.message,
            'details': null,
          };
        },
        (loginResult) {
          if (loginResult.isSuccess) {
            AppLogger.success('智能登录（详细模式）成功', tag: _tag);
            return {
              'success': true,
              'error': null,
              'details': {
                'sid': loginResult.sid,
                'redirectUrl': loginResult.redirectUrl,
                'timestamp': DateTime.now().toIso8601String(),
              },
            };
          } else {
            AppLogger.warning('智能登录（详细模式）失败: ${loginResult.errorMessage}', tag: _tag);
            return {
              'success': false,
              'error': loginResult.errorMessage,
              'details': null,
            };
          }
        },
      );
    } catch (e) {
      AppLogger.error('智能登录（详细模式）异常: $e', tag: _tag);
      return {
        'success': false,
        'error': '智能登录（详细模式）异常: $e',
        'details': null,
      };
    }
  }

  // ==================== 完整连接流程 ====================
  
  /// 完整的连接流程，包含地址解析、连接测试和登录
  Future<Map<String, dynamic>> performFullConnection({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.info('开始完整连接流程: $quickConnectId', tag: _tag);
      
      final result = await connectionManagementUseCase.performFullConnection(
        quickConnectId: quickConnectId,
      );
      
      return result.fold(
        (failure) {
          AppLogger.warning('完整连接流程失败: ${failure.message}', tag: _tag);
          return {
            'success': false,
            'error': failure.message,
            'quickConnectId': quickConnectId,
          };
        },
        (fullResult) {
          AppLogger.success('完整连接流程执行完成', tag: _tag);
          return {
            'success': true,
            'error': null,
            'quickConnectId': quickConnectId,
            'result': fullResult,
          };
        },
      );
    } catch (e) {
      AppLogger.error('完整连接流程异常: $e', tag: _tag);
      return {
        'success': false,
        'error': '完整连接流程异常: $e',
        'quickConnectId': quickConnectId,
      };
    }
  }

  /// 获取服务状态信息
  Map<String, dynamic> getServiceInfo() {
    return {
      'serviceName': 'QuickConnect Service Adapter',
      'version': '3.0.0',
      'architecture': 'Clean Architecture',
      'features': [
        'Address Resolution',
        'Connection Testing', 
        'Smart Login',
        'Authentication',
        'Network Layer Integration',
        'Retry Logic',
        'Connection Monitoring',
        'Performance Statistics',
      ],
      'networkLayer': 'Dio-based',
      'dependencyInjection': 'Riverpod',
      'stateManagement': 'Riverpod',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
