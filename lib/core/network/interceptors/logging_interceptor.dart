import 'package:dio/dio.dart';
import '../../utils/logger.dart';

/// 日志拦截器
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({this.logRequest = true, this.logResponse = true});

  final bool logRequest;
  final bool logResponse;
  static const String _tag = 'HTTP';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (logRequest) {
      AppLogger.network('🚀 REQUEST[${options.method}] => PATH: ${options.path}', tag: _tag);
      AppLogger.debug('Headers: ${options.headers}', tag: _tag);
      AppLogger.debug('QueryParameters: ${options.queryParameters}', tag: _tag);
      if (options.data != null) {
        AppLogger.debug('Body: ${options.data}', tag: _tag);
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (logResponse) {
      AppLogger.network(
        '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        tag: _tag,
      );
      AppLogger.debug('Headers: ${response.headers}', tag: _tag);
      AppLogger.debug('Data: ${response.data}', tag: _tag);
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      tag: _tag,
    );
    AppLogger.error('Error: ${err.message}', tag: _tag);
    if (err.response?.data != null) {
      AppLogger.error('Error Data: ${err.response?.data}', tag: _tag);
    }
    handler.next(err);
  }
}