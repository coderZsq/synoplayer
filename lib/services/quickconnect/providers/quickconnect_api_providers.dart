import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/providers/network_providers.dart';
import '../../../core/config/feature_flags.dart';
import '../api/quickconnect_api_interface.dart';
import '../api/quickconnect_api_impl.dart';
import '../api/quickconnect_api_adapter.dart';
import '../api/quickconnect_retrofit_api.dart';

part 'quickconnect_api_providers.g.dart';

/// 功能开关 Provider - 控制是否使用 Retrofit
/// 
/// 可以通过配置文件、环境变量或远程配置动态控制
/// 默认关闭，确保安全
@riverpod
bool useRetrofitApi(Ref ref) {
  return FeatureFlags.useRetrofitApi;
}

/// QuickConnect API 提供者
/// 
/// 根据配置选择使用适配器或直接实现
@riverpod
QuickConnectApiInterface quickConnectApi(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final dio = ref.watch(dioProvider);
  
  // 创建 Retrofit API 实例，使用默认的 QuickConnect 服务 URL
  // 注意：具体的 baseUrl 会在调用时动态设置
  final retrofitApi = QuickConnectRetrofitApi(dio);
  
  return QuickConnectApiAdapter(
    apiClient: apiClient,
    retrofitApi: retrofitApi,
  );
}

/// QuickConnect API 实现提供者
/// 
/// 直接提供具体实现，用于需要访问实现特定功能的场景
@riverpod
QuickConnectApiImpl quickConnectApiImpl(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return QuickConnectApiImpl(apiClient);
}

/// Retrofit API 提供者 (用于测试和调试)
@riverpod
QuickConnectRetrofitApi quickConnectRetrofitApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  return QuickConnectRetrofitApi(dio);
}

/// 适配器 API 提供者 (用于测试和调试)
@riverpod
QuickConnectApiAdapter quickConnectApiAdapter(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final dio = ref.watch(dioProvider);
  final retrofitApi = QuickConnectRetrofitApi(dio);
  
  return QuickConnectApiAdapter(
    apiClient: apiClient,
    retrofitApi: retrofitApi,
  );
}
