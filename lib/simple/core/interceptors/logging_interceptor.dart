import 'package:dio/dio.dart';

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
