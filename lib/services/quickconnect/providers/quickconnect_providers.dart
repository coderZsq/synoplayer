import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';
import '../connection_service.dart';
import '../address_resolver.dart';
import '../smart_login_service.dart';
import '../quickconnect_service.dart';
import 'quickconnect_api_providers.dart';

part 'quickconnect_providers.g.dart';

/// QuickConnect 认证服务 Provider
@riverpod
QuickConnectAuthService quickConnectAuthService(Ref ref) {
  final api = ref.watch(quickConnectApiProvider);
  return QuickConnectAuthService(api);
}

/// QuickConnect 连接服务 Provider
@riverpod
QuickConnectConnectionService quickConnectConnectionService(Ref ref) {
  final api = ref.watch(quickConnectApiProvider);
  return QuickConnectConnectionService(api);
}

/// QuickConnect 地址解析服务 Provider
@riverpod
QuickConnectAddressResolver quickConnectAddressResolver(Ref ref) {
  final api = ref.watch(quickConnectApiProvider);
  return QuickConnectAddressResolver(api);
}

/// QuickConnect 智能登录服务 Provider
@riverpod
QuickConnectSmartLoginService quickConnectSmartLoginService(Ref ref) {
  final connectionService = ref.watch(quickConnectConnectionServiceProvider);
  final authService = ref.watch(quickConnectAuthServiceProvider);
  return QuickConnectSmartLoginService(connectionService, authService);
}

/// QuickConnect 主服务 Provider - 统一入口
@riverpod
QuickConnectService quickConnectService(Ref ref) {
  return QuickConnectService(
    addressResolver: ref.watch(quickConnectAddressResolverProvider),
    authService: ref.watch(quickConnectAuthServiceProvider),
    connectionService: ref.watch(quickConnectConnectionServiceProvider),
    smartLoginService: ref.watch(quickConnectSmartLoginServiceProvider),
  );
}
