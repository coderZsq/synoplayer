import '../../entities/auth_login/auth_login_response.dart';
import '../../../../base/error/exceptions.dart';
import '../../../../base/error/result.dart';
import '../../../../base/utils/logger.dart';
import '../repositories/login_repository.dart';
import '../services/connection_manager.dart';

class LoginUseCase {
  final LoginRepository repository;
  final ConnectionManager connectionManager;

  LoginUseCase(this.repository, this.connectionManager);

  Future<Result<LoginData>> call({
    required String quickConnectId,
    required String username,
    required String password,
    required String? otpCode,
  }) async {
    try {
      // 如果已经连接，直接尝试登录
      if (connectionManager.connected) {
        return await _attemptLogin(username, password, otpCode);
      }
      
      // 获取服务器信息并建立连接
      final connectionResult = await connectionManager.establishConnection(quickConnectId);
      if (connectionResult.isFailure) {
        return Failure(connectionResult.error);
      }
      
      // 连接成功后尝试登录
      return await _attemptLogin(username, password, otpCode);
    } catch (e) {
      if (e is AppException) {
        return Failure(e);
      }
      return Failure(ServerException('登录过程发生未知错误: ${e.toString()}'));
    }
  }
  
  /// 尝试登录并返回 LoginData
  Future<Result<LoginData>> _attemptLogin(String username, String password, String? otpCode) async {
    final authResult = await repository.authLogin(account: username, passwd: password, otp_code: otpCode);
    
    if (authResult.isFailure) {
      Logger.info('认证失败 - ${authResult.error.message}', tag: 'LoginUseCase');
      return Failure(authResult.error);
    }
    
    final res = authResult.value;
    Logger.info('认证响应 - success: ${res.success}, needOtp: ${res.needOtp}, sid: ${res.data?.sid}', tag: 'LoginUseCase');
    
    // 检查是否需要二次验证
    if (res.needOtp) {
      Logger.info('需要二次验证', tag: 'LoginUseCase');
      return Failure(BusinessException('请输入二次验证码'));
    }
    
    // 检查登录是否成功
    if (!res.isLoginSuccess) {
      Logger.info('登录失败 - isLoginSuccess: ${res.isLoginSuccess}', tag: 'LoginUseCase');
      return Failure(BusinessException('登录失败，请检查用户名和密码'));
    }
    
    // 检查数据是否为空
    if (res.data == null) {
      Logger.info('登录数据为空', tag: 'LoginUseCase');
      return Failure(BusinessException('登录失败，请稍后重试'));
    }
    
    Logger.info('登录成功 - sid: ${res.data!.sid}', tag: 'LoginUseCase');
    return Success(res.data!);
  }
}
