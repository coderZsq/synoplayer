import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/quickconnect_models.dart';

part 'quickconnect_retrofit_api.g.dart';

/// 简单的 JSON 响应类型，避免 Retrofit 序列化问题
class JsonResponse {
  final Map<String, dynamic> data;
  
  JsonResponse(this.data);
  
  Map<String, dynamic> toJson() => data;
  
  factory JsonResponse.fromJson(Map<String, dynamic> json) => JsonResponse(json);
}

/// QuickConnect Retrofit API 接口
/// 
/// 这是新的 Retrofit 实现，与现有代码并行运行
/// 可以逐步迁移，降低风险
@RestApi()
abstract class QuickConnectRetrofitApi {
  factory QuickConnectRetrofitApi(Dio dio, {String baseUrl}) = _QuickConnectRetrofitApi;

  // ==================== 地址解析 API ====================
  
  /// 发送隧道请求获取中继服务器信息
  /// 使用 QuickConnect 隧道服务 URL
  @RestApi(baseUrl: "https://global.quickconnect.to")
  @POST('/Serv.php')
  Future<TunnelResponse> requestTunnel(
    @Body() Map<String, dynamic> requestBody,
  );
  
  /// 发送服务器信息请求
  /// 使用 QuickConnect 服务器信息服务 URL
  @RestApi(baseUrl: "https://cnc.quickconnect.cn")
  @POST('/Serv.php')
  Future<ServerInfoResponse> requestServerInfo(
    @Body() Map<String, dynamic> requestBody,
  );
  
  /// 发送 QuickConnect 全球服务器信息请求
  /// 使用 QuickConnect 全球服务 URL
  @RestApi(baseUrl: "https://global.quickconnect.to")
  @POST('/Serv.php')
  Future<QuickConnectServerInfoResponse> requestQuickConnectServerInfo(
    @Body() Map<String, dynamic> requestBody,
  );
  
  // ==================== 认证登录 API ====================
  
  /// 发送登录请求到群晖 Auth API
  /// 使用动态 baseUrl
  @GET('/webapi/auth.cgi')
  Future<JsonResponse> requestLogin(
    @Query('api') String api,
    @Query('version') String version,
    @Query('method') String method,
    @Query('account') String username,
    @Query('passwd') String password,
    @Query('session') String session,
    @Query('format') String format,
    @Query('otp_code') String? otpCode,
  );
  
  // ==================== 连接测试 API ====================
  
  /// 测试连接可用性
  /// 使用动态 baseUrl
  @GET('/webapi/query.cgi')
  Future<JsonResponse> testConnection(
    @Query('api') String api,
    @Query('version') String version,
    @Query('method') String method,
    @Query('query') String query,
  );
}
