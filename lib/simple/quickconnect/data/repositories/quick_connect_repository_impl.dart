import 'package:dio/dio.dart';
import '../../domain/repositories/quick_connect_repository.dart';
import '../../entities/get_server_info_request.dart';
import '../../entities/get_server_info_response.dart';
import '../../entities/query_api_info_request.dart';
import '../datasources/quick_connect_api.dart';
import '../../../core/network/network_config.dart';

class QuickConnectRepositoryImpl implements QuickConnectRepository {
  @override
  Future<GetServerInfoResponse> getServerInfo({
    required String serverID,
    String? site,
  }) async {
    final request = GetServerInfoRequest(
      serverID: serverID,
      id: 'dsm_https',
      command: 'get_server_info',
    );
    try {
      final dio = NetworkConfig.createDio();
      if (site != null) {
        return await QuickConnectApi(dio, baseUrl: 'https://$site').getServerInfo(request);
      } else {
        return await QuickConnectApi(dio, baseUrl: 'https://global.quickconnect.to').getServerInfo(request);
      }
    } on DioException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> queryApiInfo({
    required String relayDn,
    required int relayPort
  }) async {
    final request = QueryApiInfoRequest(
      api: 'SYNO.API.Info',
      method: 'query',
      version: '1',
    );
    final api = QuickConnectApi(NetworkConfig.createDio(), baseUrl: 'https://$relayDn:$relayPort');
    await api.queryApiInfo(request);
  }
}
