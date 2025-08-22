import '../../entities/auth_login/auth_login_response.dart';
import '../repositories/quick_connect_repository.dart';
import '../../../core/error/exceptions.dart';

class LoginUseCase {
  final QuickConnectRepository repository;

  LoginUseCase(this.repository);

  bool? isConnected;

  Future<AuthLoginResponse?> call({
    required String quickConnectId,
    required String username,
    required String password,
    required String? otpCode,
  }) async {
    try {
      if (isConnected == true) {
        return await repository.authLogin(account: username, passwd: password, otp_code: otpCode);
      }
      
      final r1 = await repository.getServerInfo(
        serverID: quickConnectId,
      );
      
      final sites = r1.sites;
      if (sites != null && sites.isNotEmpty) {
        final site = sites.first;
        try {
          final r2 = await repository.getServerInfo(
            serverID: quickConnectId,
            site: site,
          );
          final relayDn = r2.service?.relay_dn;
          final relayPort = r2.service?.relay_port;
          if (relayDn != null && relayPort != null) {
            isConnected = await repository.queryApiInfo(relayDn: relayDn, relayPort: relayPort);
            return await repository.authLogin(account: username, passwd: password, otp_code: otpCode);
          }
          throw BusinessException('无法获取服务器连接信息');
        } catch (e) {
          if (e is AppException) {
            rethrow;
          }
          throw ServerException('连接到站点失败: ${e.toString()}');
        }
      }
      throw BusinessException('未找到可用的连接站点');
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw ServerException('登录过程发生未知错误: ${e.toString()}');
    }
  }
}
