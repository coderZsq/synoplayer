import 'models/login_result.dart';
import './models/quickconnect_models.dart';
import '../../core/utils/logger.dart';
import 'auth_service.dart';
import 'connection_service.dart';

/// QuickConnect 智能登录服务
class QuickConnectSmartLoginService {
  QuickConnectSmartLoginService(this._connectionService, this._authService);
  
  final QuickConnectConnectionService _connectionService;
  final QuickConnectAuthService _authService;
  static const String _tag = 'SmartLoginService';

  /// 智能登录 - 自动尝试所有可用地址
  Future<LoginResult> smartLogin({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.userAction('开始智能登录流程', tag: _tag);
      AppLogger.info('QuickConnect ID: $quickConnectId', tag: _tag);
      AppLogger.info('用户名: $username', tag: _tag);
      
      // 获取所有可用地址详细信息
      final addresses = await _connectionService.getAllAvailableAddressesWithDetails(quickConnectId);
      
      if (addresses.isEmpty) {
        return LoginResult.failure(errorMessage: '未找到可用的连接地址');
      }
      
      AppLogger.info('找到 ${addresses.length} 个可用地址，开始智能连接测试', tag: _tag);
      
      // 依次尝试每个地址
      for (int i = 0; i < addresses.length; i++) {
        final addressInfo = addresses[i];
        AppLogger.info('\n🔄 尝试地址 ${i + 1}/${addresses.length}: ${addressInfo.url}', tag: _tag);
        AppLogger.info('地址类型: ${addressInfo.type.description} (优先级: ${addressInfo.priority})', tag: _tag);
        
        try {
          // 测试连接
          final connectionResult = await _connectionService.testConnection(addressInfo.url);
          
          if (connectionResult.isConnected) {
            AppLogger.success('连接测试成功，响应时间: ${connectionResult.responseTime.inMilliseconds}ms', tag: _tag);
          } else {
            AppLogger.warning('连接测试失败: ${connectionResult.error}', tag: _tag);
            AppLogger.info('继续尝试下一个地址', tag: _tag);
            continue;
          }
          
          // 尝试登录
          final result = await _authService.login(
            baseUrl: addressInfo.url,
            username: username,
            password: password,
            otpCode: otpCode,
          );
          
          if (result.isSuccess) {
            AppLogger.success('登录成功！使用地址: ${addressInfo.url}', tag: _tag);
            AppLogger.info('地址类型: ${addressInfo.type.description}', tag: _tag);
            return result;
          } else if (result.requireOTP) {
            AppLogger.warning('需要二次验证，地址可用: ${addressInfo.url}', tag: _tag);
            AppLogger.info('地址类型: ${addressInfo.type.description}', tag: _tag);
            AppLogger.info('停止尝试其他地址，请先完成二次验证', tag: _tag);
            // 返回一个特殊的结果，包含可用的地址信息
            return LoginResult.requireOTPWithAddress(
              errorMessage: '需要输入二次验证码',
              availableAddress: addressInfo.url,
            );
          } else {
            AppLogger.error('登录失败: ${result.errorMessage}', tag: _tag);
            AppLogger.info('尝试下一个地址', tag: _tag);
          }
          
        } catch (e) {
          AppLogger.error('地址 ${addressInfo.url} 发生异常: $e', tag: _tag);
          continue;
        }
      }
      
      AppLogger.error('所有地址都尝试失败', tag: _tag);
      return LoginResult.failure(errorMessage: '所有可用地址都无法成功登录');
      
    } catch (e) {
      AppLogger.error('智能登录过程中发生异常: $e', tag: _tag);
      return LoginResult.failure(errorMessage: '智能登录异常: $e');
    }
  }

  /// 智能登录并返回详细结果
  Future<SmartLoginResult> smartLoginWithDetails({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.userAction('开始智能登录流程（详细模式）', tag: _tag);
      
      // 获取所有可用地址详细信息
      final addresses = await _connectionService.getAllAvailableAddressesWithDetails(quickConnectId);
      
      if (addresses.isEmpty) {
        return SmartLoginResult.failure(
          error: '未找到可用的连接地址',
          attempts: [],
          stats: {},
        );
      }
      
      final loginAttempts = <LoginAttempt>[];
      String? bestAddress;
      LoginResult? bestResult;
      
      // 依次尝试每个地址
      for (int i = 0; i < addresses.length; i++) {
        final addressInfo = addresses[i];
        final attempt = LoginAttempt(
          address: addressInfo.url,
          addressType: addressInfo.type,
          priority: addressInfo.priority,
          attemptNumber: i + 1,
        );
        
        try {
          // 测试连接
          final connectionResult = await _connectionService.testConnection(addressInfo.url);
          final attemptWithConnection = attempt.copyWith(connectionResult: connectionResult);
          
          if (connectionResult.isConnected) {
            // 尝试登录
            final loginResult = await _authService.login(
              baseUrl: addressInfo.url,
              username: username,
              password: password,
              otpCode: otpCode,
            );
            
            final finalAttempt = attemptWithConnection.copyWith(loginResult: loginResult);
            
            if (loginResult.isSuccess) {
              bestAddress = addressInfo.url;
              bestResult = loginResult;
              AppLogger.success('登录成功！使用地址: ${addressInfo.url}', tag: _tag);
              loginAttempts.add(finalAttempt);
              break;
            } else if (loginResult.requireOTP) {
              bestAddress = addressInfo.url;
              bestResult = loginResult;
              AppLogger.warning('需要二次验证，地址可用: ${addressInfo.url}', tag: _tag);
              loginAttempts.add(finalAttempt);
              break;
            }
            
            loginAttempts.add(finalAttempt);
          } else {
            loginAttempts.add(attemptWithConnection);
          }
          
        } catch (e) {
          final attemptWithError = attempt.copyWith(error: e.toString());
          loginAttempts.add(attemptWithError);
          AppLogger.error('地址 ${addressInfo.url} 发生异常: $e', tag: _tag);
        }
        
      }
      
      // 生成统计信息
      final stats = _generateLoginStats(loginAttempts);
      
      if (bestResult != null) {
        return SmartLoginResult.success(
          loginResult: bestResult,
          bestAddress: bestAddress!,
          attempts: loginAttempts,
          stats: stats,
        );
      } else {
        return SmartLoginResult.failure(
          error: '所有可用地址都无法成功登录',
          attempts: loginAttempts,
          stats: stats,
        );
      }
      
    } catch (e) {
      AppLogger.error('智能登录过程中发生异常: $e', tag: _tag);
      return SmartLoginResult.failure(
        error: '智能登录异常: $e',
        attempts: [],
        stats: {},
      );
    }
  }

  /// 生成登录统计信息
  Map<String, dynamic> _generateLoginStats(List<LoginAttempt> attempts) {
    final total = attempts.length;
    final connected = attempts.where((a) => a.connectionResult?.isConnected == true).length;
    final loginSuccess = attempts.where((a) => a.loginResult?.isSuccess == true).length;
    final requireOTP = attempts.where((a) => a.loginResult?.requireOTP == true).length;
    
    final avgConnectionTime = attempts
        .where((a) => a.connectionResult?.isConnected == true)
        .map((a) => a.connectionResult!.responseTime.inMilliseconds)
        .toList();
    
    final avgTime = avgConnectionTime.isNotEmpty 
        ? avgConnectionTime.reduce((a, b) => a + b) / avgConnectionTime.length 
        : 0;
    
    return {
      'totalAttempts': total,
      'successfulConnections': connected,
      'successfulLogins': loginSuccess,
      'requireOTP': requireOTP,
      'connectionSuccessRate': total > 0 ? '${(connected / total * 100).toStringAsFixed(1)}%' : '0%',
      'loginSuccessRate': total > 0 ? '${(loginSuccess / total * 100).toStringAsFixed(1)}%' : '0%',
      'averageConnectionTime': '${avgTime.toStringAsFixed(0)}ms',
      'bestConnectionTime': avgConnectionTime.isNotEmpty 
          ? '${avgConnectionTime.reduce((a, b) => a < b ? a : b)}ms' 
          : 'N/A',
    };
  }
}
