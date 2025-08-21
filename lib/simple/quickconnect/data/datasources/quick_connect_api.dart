import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../entities/get_server_info_request.dart';
import '../../entities/get_server_info_response.dart';
import '../../entities/query_api_info_request.dart';

part 'quick_connect_api.g.dart';

@RestApi()
abstract class QuickConnectApi {
  factory QuickConnectApi(Dio dio, {String baseUrl}) = _QuickConnectApi;

  @POST('/Serv.php')
  Future<GetServerInfoResponse> getServerInfo(
      @Body() GetServerInfoRequest request
  );
  
  @POST('/webapi/query.cgi')
  Future<void> queryApiInfo(
      @Body() QueryApiInfoRequest request
  );
}
