import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
part 'quickconnect_api.g.dart';
part 'quickconnect_api.freezed.dart';

// 请求数据模型
@freezed
class QuickConnectRequest with _$QuickConnectRequest {
  const factory QuickConnectRequest({
    @JsonKey(name: 'get_ca_fingerprints') required bool getCaFingerprints,
    required String id,
    @JsonKey(name: 'serverID') required String serverId,
    required String command,
    required String version,
  }) = _QuickConnectRequest;

  factory QuickConnectRequest.fromJson(Map<String, dynamic> json) =>
      _$QuickConnectRequestFromJson(json);
}

// 响应数据模型
@freezed
class QuickConnectResponse with _$QuickConnectResponse {
  const factory QuickConnectResponse({
    required String command,
    required String errinfo,
    @JsonKey(fromJson: _toString) required String errno,
    required List<String> sites,
    @JsonKey(fromJson: _toString) required String suberrno,
    @JsonKey(fromJson: _toString) required String version,
  }) = _QuickConnectResponse;

  factory QuickConnectResponse.fromJson(Map<String, dynamic> json) =>
      _$QuickConnectResponseFromJson(json);
}

// 添加安全的字符串解析方法
String _toString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}

@RestApi()
abstract class QuickConnectApi {
  factory QuickConnectApi(Dio dio, {String baseUrl}) = _QuickConnectApi;

  @POST('https://global.quickconnect.to/Serv.php')
  Future<QuickConnectResponse> getServerInfo(@Body() QuickConnectRequest request);
}

// 自定义日志拦截器
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('=== REQUEST ===');
    print('URL: ${options.uri}');
    print('Method: ${options.method}');
    print('Headers: ${options.headers}');
    print('Data: ${options.data}');
    print('===============');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('=== RESPONSE ===');
    print('Status Code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Data: ${response.data}');
    print('================');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('=== ERROR ===');
    print('Error Type: ${err.type}');
    print('Error Message: ${err.message}');
    print('Response: ${err.response}');
    print('=============');
    super.onError(err, handler);
  }
}

// JSON响应转换器
class JsonResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is String) {
      try {
        response.data = jsonDecode(response.data);
      } catch (e) {
        print('JSON decode error: $e');
      }
    }
    handler.next(response);
  }
}

class QuickConnectServiceImpl {
  late final QuickConnectApi _api;

  QuickConnectServiceImpl() {
    _api = QuickConnectApi(NetworkConfig.createDio());
  }

  Future<QuickConnectResponse> getServerInfo({
    required String serverId,
    bool getCaFingerprints = true,
    String id = 'dsm_https',
    String command = 'get_server_info',
    String version = '1',
  }) async {
    final request = QuickConnectRequest(
      getCaFingerprints: getCaFingerprints,
      id: id,
      serverId: serverId,
      command: command,
      version: version,
    );

    try {
      return await _api.getServerInfo(request);
    } on DioException catch (e) {
      // 处理网络异常
      print('Network error: ${e.message}');
      rethrow;
    }
  }
}

class NetworkConfig {
  static Dio createDio({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool enableLogging = false,
    Map<String, String>? defaultHeaders,
  }) {
    final dio = Dio();
    dio.options.connectTimeout = connectTimeout ?? const Duration(seconds: 30);
    dio.options.receiveTimeout = receiveTimeout ?? const Duration(seconds: 30);
    dio.options.sendTimeout = sendTimeout ?? const Duration(seconds: 30);
    dio.options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': '*/*',
      ...?defaultHeaders,
    });
    if (enableLogging) {
      dio.interceptors.add(LoggingInterceptor());
    }
    dio.interceptors.add(JsonResponseInterceptor());
    return dio;
  }
}