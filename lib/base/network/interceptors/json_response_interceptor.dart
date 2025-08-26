import 'dart:convert';
import 'package:dio/dio.dart';
import '../../utils/logger.dart';

class JsonResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 跳过音频流接口的响应，避免JSON解析错误
    final uri = response.requestOptions.uri.toString();
    if (uri.contains('/webapi/AudioStation/stream.cgi')) {
      handler.next(response);
      return;
    }
    
    if (response.data is String) {
      try {
        response.data = jsonDecode(response.data);
      } catch (e, stackTrace) {
        Logger.error(
          'JSON decode error for ${response.requestOptions.uri}',
          tag: 'JSON',
          error: e,
          stackTrace: stackTrace,
        );
      }
    }
    handler.next(response);
  }
}
