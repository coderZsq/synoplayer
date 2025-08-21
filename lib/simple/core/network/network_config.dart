import 'package:dio/dio.dart';
import '../interceptors/logging_interceptor.dart';
import '../interceptors/json_response_interceptor.dart';

class NetworkConfig {
  static Dio createDio({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool enableLogging = true,
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
