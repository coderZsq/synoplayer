import 'package:dio/dio.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/json_response_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class NetworkConfig {
  static Dio createDio({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool enableLogging = true,
    bool enableRetry = true,
    RetryInterceptorConfig? retryConfig,
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
    
    // 添加响应拦截器
    dio.interceptors.add(JsonResponseInterceptor());
    
    // 添加重试拦截器（在日志拦截器之前）
    if (enableRetry) {
      dio.addRetryInterceptor(retryConfig ?? RetryInterceptorConfig.networkConfig);
    }
    
    // 添加日志拦截器
    if (enableLogging) {
      dio.interceptors.add(LoggingInterceptor());
    }
    
    return dio;
  }
  
  /// 创建带网络重试的 Dio 实例
  static Dio createNetworkRetryDio({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool enableLogging = true,
    Map<String, String>? defaultHeaders,
  }) {
    return createDio(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      enableLogging: enableLogging,
      enableRetry: true,
      retryConfig: RetryInterceptorConfig.networkConfig,
      defaultHeaders: defaultHeaders,
    );
  }
  
  /// 创建带服务器重试的 Dio 实例
  static Dio createServerRetryDio({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool enableLogging = true,
    Map<String, String>? defaultHeaders,
  }) {
    return createDio(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      enableLogging: enableLogging,
      enableRetry: true,
      retryConfig: RetryInterceptorConfig.serverConfig,
      defaultHeaders: defaultHeaders,
    );
  }
}
