import 'package:dio/dio.dart';
import '../../domain/repositories/login_repository.dart';
import '../../entities/auth_login/auth_login_request.dart';
import '../../entities/auth_login/auth_login_response.dart';
import '../../entities/auth_logout/auth_logout_request.dart';
import '../../entities/auth_logout/auth_logout_response.dart';
import '../../entities/get_server_info/get_server_info_request.dart';
import '../../entities/get_server_info/get_server_info_response.dart';
import '../../entities/query_api_info/query_api_info_request.dart';
import '../../../../base/network/quick_connect_api_info.dart';
import '../../../../base/network/global_dio_manager.dart';
import '../../../../base/error/exceptions.dart';
import '../../../../base/error/result.dart';
import '../datasources/login_datasource_remote.dart';

class LoginRepositoryImpl implements LoginRepository {
  final GlobalDioManager _globalDioManager;
  late LoginDataSourceRemote _dataSourceRemote;

  LoginRepositoryImpl(this._globalDioManager);

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
      final api = LoginDataSourceRemote(_globalDioManager.dio, baseUrl: baseUrl);
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
      _dataSourceRemote = LoginDataSourceRemote(_globalDioManager.dio, baseUrl: baseUrl);
      apiInfo.apiInfo = await _dataSourceRemote.queryApiInfo(
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
      final response = await _dataSourceRemote.authLogin(
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

  @override
  Future<Result<AuthLogoutResponse>> authLogout({
    required String sessionId,
  }) async {
    try {
      final apiInfo = QuickConnectApiInfo();
      final request = AuthLogoutRequest(sid: sessionId);
      final response = await _dataSourceRemote.authLogout(
        api: apiInfo.auth,
        method: 'logout',
        session: sessionId,
        format: 'sid',
        version: apiInfo.authVersion,
        request: request,
      );
      return Success(response);
    } on DioException catch (e) {
      // 根据状态码判断是网络还是认证错误
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        return Failure(AuthException('会话已过期或无效'));
      }
      return Failure(NetworkException.fromDio(e));
    } catch (e) {
      return Failure(AuthException('登出失败: $e'));
    }
  }
}
