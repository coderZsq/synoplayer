import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../api_client.dart';
import '../interceptors/logging_interceptor.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/connectivity_interceptor.dart';

/// Connectivity Provider
final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

/// Dio 实例 Provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  
  // 基础配置
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  // 添加拦截器
  dio.interceptors.addAll([
    ConnectivityInterceptor(
      connectivity: ref.read(connectivityProvider),
    ),
    AuthInterceptor(ref),
    LoggingInterceptor(),
  ]);

  return dio;
});

/// QuickConnect 专用 Dio Provider
final quickConnectDioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  
  // QuickConnect 专用配置
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'User-Agent': 'DSfile/12 CFNetwork/3826.600.41 Darwin/24.6.0',
      'Accept': '*/*',
      'Accept-Language': 'en-US,en;q=0.9',
      'Accept-Encoding': 'gzip, deflate, br',
    },
  );

  // 添加 QuickConnect 专用拦截器
  dio.interceptors.addAll([
    ConnectivityInterceptor(
      connectivity: ref.read(connectivityProvider),
    ),
    LoggingInterceptor(),
  ]);

  return dio;
});

/// 通用 API 客户端 Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});

/// QuickConnect API 客户端 Provider
final quickConnectApiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(quickConnectDioProvider);
  return ApiClient(dio);
});
