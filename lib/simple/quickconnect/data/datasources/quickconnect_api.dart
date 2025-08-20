import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../entities/quickconnect_request.dart';
import '../../entities/quickconnect_response.dart';

part 'quickconnect_api.g.dart';

@RestApi()
abstract class QuickConnectApi {
  factory QuickConnectApi(Dio dio, {String baseUrl}) = _QuickConnectApi;

  @POST('https://global.quickconnect.to/Serv.php')
  Future<QuickConnectResponse> getServerInfo(@Body() QuickConnectRequest request);
}
