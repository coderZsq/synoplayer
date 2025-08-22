import 'package:dio/dio.dart';
import '../../domain/repositories/quick_connect_repository.dart';
import '../../entities/auth_login/auth_login_request.dart';
import '../../entities/auth_login/auth_login_response.dart';
import '../../entities/get_server_info/get_server_info_request.dart';
import '../../entities/get_server_info/get_server_info_response.dart';
import '../../entities/query_api_info/query_api_info_request.dart';
import '../datasources/quick_connect_api.dart';
import '../datasources/quick_connect_api_info.dart';
import '../../../core/network/api_factory.dart';

class QuickConnectRepositoryImpl implements QuickConnectRepository {
  final ApiFactory _apiFactory;
  late QuickConnectApi _api;

  QuickConnectRepositoryImpl(this._apiFactory);

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
      final baseUrl = site != null ? 'https://$site' : 'https://global.quickconnect.to';
      final api = _apiFactory.createQuickConnectApi(baseUrl);
      return await api.getServerInfo(request: request);
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
    final baseUrl = 'https://$relayDn:$relayPort';
    _api = _apiFactory.createQuickConnectApi(baseUrl);
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
