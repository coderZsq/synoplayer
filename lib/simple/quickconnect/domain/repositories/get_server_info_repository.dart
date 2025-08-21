import '../../entities/get_server_info_response.dart';

abstract class GetServerInfoRepository {
  Future<GetServerInfoResponse> getServerInfo({
    required String serverID,
    String id,
    String command,
  });
}
