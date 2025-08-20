import '../../entities/quickconnect_response.dart';

abstract class QuickConnectRepository {
  Future<QuickConnectResponse> getServerInfo({
    required String serverId,
    bool getCaFingerprints,
    String id,
    String command,
    String version,
  });
}
