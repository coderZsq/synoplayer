import 'package:dio/dio.dart';
import 'package:synoplayer/components/audio/entities/song_list_all/song_list_all_response.dart';
import '../../domain/repositories/quick_connect_repository.dart';
import '../../entities/auth_login/auth_login_request.dart';
import '../../entities/auth_login/auth_login_response.dart';
import '../../entities/get_server_info/get_server_info_request.dart';
import '../../entities/get_server_info/get_server_info_response.dart';
import '../../entities/query_api_info/query_api_info_request.dart';
import '../datasources/quick_connect_api.dart';
import '../datasources/quick_connect_api_info.dart';
import '../../../base/network/api_factory.dart';
import '../../../base/error/exceptions.dart';
import '../../../base/error/result.dart';

class QuickConnectRepositoryImpl implements QuickConnectRepository {
  final ApiFactory _apiFactory;
  late QuickConnectApi _api;

  QuickConnectRepositoryImpl(this._apiFactory);

  @override
  Future<Result<GetServerInfoResponse>> getServerInfo({
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
      final response = await api.getServerInfo(request: request);
      return Success(response);
    } on DioException catch (e) {
      return Failure(NetworkException.fromDio(e));
    } catch (e) {
      return Failure(ServerException('获取服务器信息失败: $e'));
    }
  }

  @override
  Future<Result<bool>> queryApiInfo({
    required String relayDn,
    required int relayPort
  }) async {
    try {
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
      final success = apiInfo.apiInfo?.success ?? false;
      return Success(success);
    } on DioException catch (e) {
      return Failure(NetworkException.fromDio(e));
    } catch (e) {
      return Failure(ServerException('查询API信息失败: $e'));
    }
  }

  @override
  Future<Result<AuthLoginResponse>> authLogin({
    required String account,
    required String passwd,
    String? otp_code,
  }) async {
    try {
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
      final response = await _api.authLogin(
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
      return Success(response);
    } on DioException catch (e) {
      // 根据状态码判断是网络还是认证错误
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        return Failure(AuthException('用户名或密码错误'));
      }
      return Failure(NetworkException.fromDio(e));
    } catch (e) {
      return Failure(AuthException('登录失败: $e'));
    }
  }
}
