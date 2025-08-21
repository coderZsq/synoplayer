import '../../entities/get_server_info_response.dart';
import '../repositories/quick_connect_repository.dart';

class LoginUseCase {
  final QuickConnectRepository repository;

  LoginUseCase(this.repository);

  Future<GetServerInfoResponse> call({
    required String quickConnectId,
    required String username,
    required String password,
    required String? optCode,
  }) async {
    // 先调用global API获取基本信息
    final firstResponse = await repository.getServerInfo(
      serverID: quickConnectId,
    );
    
    final sites = firstResponse.sites;
    if (sites != null && sites.isNotEmpty) {
      final site = sites.first;
      try {
        // 如果有sites，则用第一个site再次调用获取详细信息
        final secondResponse = await repository.getServerInfo(
          serverID: quickConnectId,
          site: site,
        );
        final relayDn = secondResponse.service?.relay_dn;
        final relayPort = secondResponse.service?.relay_port;
        if (relayDn != null && relayPort != null) {
          await repository.queryApiInfo(relayDn: relayDn, relayPort: relayPort);
        }
        return secondResponse;
      } catch (e) {
        // 如果第二次调用失败，返回第一次的结果
        return firstResponse;
      }
    }
    
    return firstResponse;
  }
}
