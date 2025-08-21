import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../entities/get_server_info_request.dart';
import '../../entities/get_server_info_response.dart';

part 'get_server_info_api.g.dart';

@RestApi()
abstract class GetServerInfoApi {
  factory GetServerInfoApi(Dio dio, {String baseUrl}) = _GetServerInfoApi;

  @POST('/Serv.php')
  Future<GetServerInfoResponse> getServerInfo(
      @Body() GetServerInfoRequest request
  );
}
