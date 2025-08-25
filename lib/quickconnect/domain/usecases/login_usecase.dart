import '../../entities/auth_login/auth_login_response.dart';
import '../repositories/quick_connect_repository.dart';
import '../services/connection_manager.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/result.dart';

class LoginUseCase {
  final QuickConnectRepository repository;
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
      print('🔍 LoginUseCase: 认证失败 - ${authResult.error.message}');
      return Failure(authResult.error);
    }
    
    final res = authResult.value;
    print('🔍 LoginUseCase: 认证响应 - success: ${res.success}, needOtp: ${res.needOtp}, sid: ${res.data?.sid}');
    
    // 检查是否需要二次验证
    if (res.needOtp) {
      print('🔍 LoginUseCase: 需要二次验证');
      return Failure(BusinessException('请输入二次验证码'));
    }
    
    // 检查登录是否成功
    if (!res.isLoginSuccess) {
      print('🔍 LoginUseCase: 登录失败 - isLoginSuccess: ${res.isLoginSuccess}');
      return Failure(BusinessException('登录失败，请检查用户名和密码'));
    }
    
    // 检查数据是否为空
    if (res.data == null) {
      print('🔍 LoginUseCase: 登录数据为空');
      return Failure(BusinessException('登录失败，请稍后重试'));
    }
    
    print('🔍 LoginUseCase: 登录成功 - sid: ${res.data!.sid}');
    return Success(res.data!);
  }
}
