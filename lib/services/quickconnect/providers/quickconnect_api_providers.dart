import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/providers/network_providers.dart';
import '../api/quickconnect_api_interface.dart';
import '../api/quickconnect_api_impl.dart';

part 'quickconnect_api_providers.g.dart';

/// QuickConnect API 提供者
/// 
/// 负责创建和管理 QuickConnect API 实例
@riverpod
QuickConnectApiInterface quickConnectApi(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return QuickConnectApiImpl(apiClient);
}

/// QuickConnect API 实现提供者
/// 
/// 直接提供具体实现，用于需要访问实现特定功能的场景
@riverpod
QuickConnectApiImpl quickConnectApiImpl(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return QuickConnectApiImpl(apiClient);
}
