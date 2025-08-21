import 'package:dio/dio.dart';
import '../../domain/repositories/get_server_info_repository.dart';
import '../../entities/get_server_info_request.dart';
import '../../entities/get_server_info_response.dart';
import '../datasources/get_server_info_api.dart';
import '../../../core/network/network_config.dart';

class GetServerInfoRepositoryImpl implements GetServerInfoRepository {
  @override
  Future<GetServerInfoResponse> getServerInfo({
    required String serverID,
    String id = 'dsm_https',
    String command = 'get_server_info',
    String? site,
  }) async {
    final request = GetServerInfoRequest(
      id: id,
      serverID: serverID,
      command: command,
    );

    try {
      final dio = NetworkConfig.createDio();
      if (site != null) {
        final api = GetServerInfoApi(dio, baseUrl: 'https://$site');
        return await api.getServerInfo(request);
      } else {
        final api = GetServerInfoApi(dio, baseUrl: 'https://global.quickconnect.to');
        return await api.getServerInfo(request);
      }
    } on DioException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    }
  }
}
