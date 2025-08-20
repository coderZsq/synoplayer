import 'dart:convert';
import 'package:dio/dio.dart';

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
