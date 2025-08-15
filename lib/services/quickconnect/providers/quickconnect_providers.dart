import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/index.dart';
import '../auth_service.dart';
import '../connection_service.dart';
import '../address_resolver.dart';
import '../smart_login_service.dart';
import '../quickconnect_service.dart';

/// QuickConnect 认证服务 Provider
final quickConnectAuthServiceProvider = Provider<QuickConnectAuthService>((ref) {
  final apiClient = ref.watch(quickConnectApiClientProvider);
  return QuickConnectAuthService(apiClient);
});

/// QuickConnect 连接服务 Provider
final quickConnectConnectionServiceProvider = Provider<QuickConnectConnectionService>((ref) {
  final apiClient = ref.watch(quickConnectApiClientProvider);
  return QuickConnectConnectionService(apiClient);
});

/// QuickConnect 地址解析服务 Provider
final quickConnectAddressResolverProvider = Provider<QuickConnectAddressResolver>((ref) {
  final apiClient = ref.watch(quickConnectApiClientProvider);
  return QuickConnectAddressResolver(apiClient);
});

/// QuickConnect 智能登录服务 Provider
final quickConnectSmartLoginServiceProvider = Provider<QuickConnectSmartLoginService>((ref) {
  final connectionService = ref.watch(quickConnectConnectionServiceProvider);
  final authService = ref.watch(quickConnectAuthServiceProvider);
  return QuickConnectSmartLoginService(connectionService, authService);
});

/// QuickConnect 主服务 Provider - 统一入口
final quickConnectServiceProvider = Provider<QuickConnectService>((ref) {
  return QuickConnectService(
    addressResolver: ref.watch(quickConnectAddressResolverProvider),
    authService: ref.watch(quickConnectAuthServiceProvider),
    connectionService: ref.watch(quickConnectConnectionServiceProvider),
    smartLoginService: ref.watch(quickConnectSmartLoginServiceProvider),
  );
});
