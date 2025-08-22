import 'package:dio/dio.dart';
import '../../domain/repositories/quick_connect_repository.dart';
import '../../entities/auth_login/auth_login_request.dart';
import '../../entities/auth_login/auth_login_response.dart';
import '../../entities/get_server_info/get_server_info_request.dart';
import '../../entities/get_server_info/get_server_info_response.dart';
import '../../../core/network/network_config.dart';
import '../../entities/query_api_info/query_api_info_request.dart';
import '../datasources/quick_connect_api.dart';
import '../datasources/quick_connect_api_info.dart';

class QuickConnectRepositoryImpl implements QuickConnectRepository {

  late QuickConnectApi _api;

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
        return await QuickConnectApi(dio, baseUrl: 'https://$site').getServerInfo(request: request);
      } else {
        return await QuickConnectApi(dio, baseUrl: 'https://global.quickconnect.to').getServerInfo(request: request);
      }
    } on DioException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<bool> queryApiInfo({
    required String relayDn,
    required int relayPort
  }) async {
    final apiInfo = QuickConnectApiInfo();
    final request = QueryApiInfoRequest(
      api: apiInfo.info,
      method: 'query',
      version: '1',
    );
    _api = QuickConnectApi(NetworkConfig.createDio(), baseUrl: 'https://$relayDn:$relayPort');
    apiInfo.apiInfo = await _api.queryApiInfo(
        api: request.api,
        method: request.method,
        version: request.version,
        request: request
    );
    return apiInfo.apiInfo?.success ?? false;
  }

  @override
  Future<AuthLoginResponse> authLogin({
    required String account,
    required String passwd,
    String? otp_code,
  }) {
    final apiInfo = QuickConnectApiInfo();
    final request = AuthLoginRequest(
      api: apiInfo.auth,
      method: 'login',
      account: account.trim(),
      passwd: passwd.trim(),
      session: 'FileStation',
      format: 'sid',
      otp_code: otp_code,
      version: apiInfo.authVersion,
    );
    return _api.authLogin(
        api: request.api,
        method: request.method,
        account: request.account,
        passwd: request.passwd,
        session: request.session,
        format: request.format,
        otp_code: otp_code,
        version: request.version,
        request: request
    );
  }
}
