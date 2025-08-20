import 'package:dio/dio.dart';
import '../../domain/repositories/quickconnect_repository.dart';
import '../../entities/quickconnect_request.dart';
import '../../entities/quickconnect_response.dart';
import '../datasources/quickconnect_api.dart';
import '../../../core/network/network_config.dart';

class QuickConnectRepositoryImpl implements QuickConnectRepository {
  final QuickConnectApi _api;

  QuickConnectRepositoryImpl() : _api = QuickConnectApi(NetworkConfig.createDio());

  @override
  Future<QuickConnectResponse> getServerInfo({
    required String serverId,
    bool getCaFingerprints = true,
    String id = 'dsm_https',
    String command = 'get_server_info',
    String version = '1',
  }) async {
    final request = QuickConnectRequest(
      getCaFingerprints: getCaFingerprints,
      id: id,
      serverId: serverId,
      command: command,
      version: version,
    );

    try {
      return await _api.getServerInfo(request);
    } on DioException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    }
  }
}
