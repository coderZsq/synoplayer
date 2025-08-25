import 'dart:convert';
import 'package:dio/dio.dart';
import '../../utils/logger.dart';

class JsonResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
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
