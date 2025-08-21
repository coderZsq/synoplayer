import '../../entities/get_server_info_response.dart';

abstract class QuickConnectRepository {
  Future<GetServerInfoResponse> getServerInfo({
    required String serverID,
    String? site,
  });

  Future<void> queryApiInfo({
    required String relayDn,
    required int relayPort
  });
}
