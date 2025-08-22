import '../../entities/auth_login/auth_login_response.dart';
import '../repositories/quick_connect_repository.dart';
import '../../../core/error/exceptions.dart';

class LoginUseCase {
  final QuickConnectRepository repository;

  LoginUseCase(this.repository);

  bool? isConnected;

  Future<LoginData> call({
    required String quickConnectId,
    required String username,
    required String password,
    required String? otpCode,
  }) async {
    try {
      // 如果已经连接，直接尝试登录
      if (isConnected == true) {
        return await _attemptLogin(username, password, otpCode);
      }
      
      // 获取服务器信息并建立连接
      await _establishConnection(quickConnectId);
      
      // 连接成功后尝试登录
      return await _attemptLogin(username, password, otpCode);
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw ServerException('登录过程发生未知错误: ${e.toString()}');
    }
  }
  
  /// 尝试登录并返回 LoginData
  Future<LoginData> _attemptLogin(String username, String password, String? otpCode) async {
    final res = await repository.authLogin(account: username, passwd: password, otp_code: otpCode);
    
    // 检查是否需要二次验证
    if (res.needOtp) {
      throw BusinessException('请输入二次验证码');
    }
    
    // 检查登录是否成功
    if (!res.isLoginSuccess) {
      throw BusinessException('登录失败，请检查用户名和密码');
    }
    
    // 检查数据是否为空
    if (res.data == null) {
      throw BusinessException('登录失败，请稍后重试');
    }
    
    return res.data!;
  }
  
  /// 建立与服务器的连接
  Future<void> _establishConnection(String quickConnectId) async {
    final r1 = await repository.getServerInfo(serverID: quickConnectId);
    
    final sites = r1.sites;
    if (sites == null || sites.isEmpty) {
      throw BusinessException('未找到可用的连接站点');
    }
    
    final site = sites.first;
    try {
      final r2 = await repository.getServerInfo(
        serverID: quickConnectId,
        site: site,
      );
      
      final relayDn = r2.service?.relay_dn;
      final relayPort = r2.service?.relay_port;
      
      if (relayDn == null || relayPort == null) {
        throw BusinessException('无法获取服务器连接信息');
      }
      
      isConnected = await repository.queryApiInfo(relayDn: relayDn, relayPort: relayPort);
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw ServerException('连接到站点失败: ${e.toString()}');
    }
  }
}
