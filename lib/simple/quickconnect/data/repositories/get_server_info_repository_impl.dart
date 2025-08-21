import 'package:dio/dio.dart';
import '../../domain/repositories/get_server_info_repository.dart';
import '../../entities/get_server_info_request.dart';
import '../../entities/get_server_info_response.dart';
import '../datasources/get_server_info_api.dart';
import '../../../core/network/network_config.dart';

class GetServerInfoRepositoryImpl implements GetServerInfoRepository {
  final GetServerInfoApi _api;

  GetServerInfoRepositoryImpl() : _api = GetServerInfoApi(NetworkConfig.createDio(), baseUrl: 'https://global.quickconnect.to');

  @override
  Future<GetServerInfoResponse> getServerInfo({
    required String serverID,
    String id = 'dsm_https',
    String command = 'get_server_info',
  }) async {
    final request = GetServerInfoRequest(
      id: id,
      serverID: serverID,
      command: command,
    );

    try {
      return await _api.getServerInfo(request);
    } on DioException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    }
  }
}
