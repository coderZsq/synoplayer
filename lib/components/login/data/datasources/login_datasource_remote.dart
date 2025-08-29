import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../entities/auth_login/auth_login_request.dart';
import '../../entities/auth_login/auth_login_response.dart';
import '../../entities/auth_logout/auth_logout_request.dart';
import '../../entities/auth_logout/auth_logout_response.dart';
import '../../entities/get_server_info/get_server_info_request.dart';
import '../../entities/get_server_info/get_server_info_response.dart';
import '../../entities/query_api_info/query_api_info_request.dart';
import '../../entities/query_api_info/query_api_info_response.dart';

part 'login_datasource_remote.g.dart';

@RestApi()
abstract class LoginDataSourceRemote {
  factory LoginDataSourceRemote(Dio dio, {String baseUrl}) = _LoginDataSourceRemote;

  @POST('/Serv.php')
  Future<GetServerInfoResponse> getServerInfo({
    @Body() required GetServerInfoRequest request
  });

  @POST('/webapi/query.cgi')
  Future<QueryApiInfoResponse> queryApiInfo({
    @Query('api') required String api,
    @Query('method') required String method,
    @Query('version') required String version,
    @Body() required QueryApiInfoRequest request
  });

  @POST('/webapi/auth.cgi')
  Future<AuthLoginResponse> authLogin({
    @Query('api') required String api,
    @Query('method') required String method,
    @Query('account') required String account,
    @Query('passwd') required String passwd,
    @Query('session') required String session,
    @Query('format') required String format,
    @Query('otp_code') String? otp_code,
    @Query('version') required String version,
    @Body() required AuthLoginRequest request
  });

  @POST('/webapi/auth.cgi')
  Future<AuthLogoutResponse> authLogout({
    @Query('api') required String api,
    @Query('method') required String method,
    @Query('session') required String session,
    @Query('format') required String format,
    @Query('version') required String version,
    @Body() required AuthLogoutRequest request
  });
}
