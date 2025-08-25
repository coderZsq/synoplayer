import 'package:dio/dio.dart';
import '../../utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.network(
      'REQUEST: ${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Data: ${options.data}',
      tag: 'HTTP',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.network(
      'RESPONSE: ${response.statusCode} ${response.requestOptions.uri}\n'
      'Headers: ${response.headers}\n'
      'Data: ${_formatResponseData(response.data)}',
      tag: 'HTTP',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.error(
      'HTTP ERROR: ${err.type} ${err.requestOptions.uri}\n'
      'Error Message: ${err.message}\n'
      'Response: ${err.response}',
      tag: 'HTTP',
      error: err,
    );
    handler.next(err);
  }
  
  /// 格式化响应数据以避免过长的日志
  String _formatResponseData(dynamic data) {
    if (data == null) return 'null';
    final dataString = data.toString();
    if (dataString.length > 1000) {
      return '${dataString.substring(0, 1000)}... (truncated)';
    }
    return dataString;
  }
}
