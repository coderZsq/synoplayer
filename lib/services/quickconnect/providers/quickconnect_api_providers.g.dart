// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$useRetrofitApiHash() => r'044fa5a679cd6855d7b35e4219e5f6aea18b9125';

/// 功能开关 Provider - 控制是否使用 Retrofit
///
/// 可以通过配置文件、环境变量或远程配置动态控制
/// 默认关闭，确保安全
///
/// Copied from [useRetrofitApi].
@ProviderFor(useRetrofitApi)
final useRetrofitApiProvider = AutoDisposeProvider<bool>.internal(
  useRetrofitApi,
  name: r'useRetrofitApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$useRetrofitApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UseRetrofitApiRef = AutoDisposeProviderRef<bool>;
String _$quickConnectApiHash() => r'e4007bee53557d6671773106488c0c797f5c5c7a';

/// QuickConnect API 提供者
///
/// 根据配置选择使用适配器或直接实现
///
/// Copied from [quickConnectApi].
@ProviderFor(quickConnectApi)
final quickConnectApiProvider =
    AutoDisposeProvider<QuickConnectApiInterface>.internal(
  quickConnectApi,
  name: r'quickConnectApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickConnectApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickConnectApiRef = AutoDisposeProviderRef<QuickConnectApiInterface>;
String _$quickConnectApiImplHash() =>
    r'e2ce979d0a10c442b2287660800ee758fe0a11b6';

/// QuickConnect API 实现提供者
///
/// 直接提供具体实现，用于需要访问实现特定功能的场景
///
/// Copied from [quickConnectApiImpl].
@ProviderFor(quickConnectApiImpl)
final quickConnectApiImplProvider =
    AutoDisposeProvider<QuickConnectApiImpl>.internal(
  quickConnectApiImpl,
  name: r'quickConnectApiImplProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickConnectApiImplHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickConnectApiImplRef = AutoDisposeProviderRef<QuickConnectApiImpl>;
String _$quickConnectRetrofitApiHash() =>
    r'bbab6fb8f8a7234d74236e9af5da76376288831e';

/// Retrofit API 提供者 (用于测试和调试)
///
/// Copied from [quickConnectRetrofitApi].
@ProviderFor(quickConnectRetrofitApi)
final quickConnectRetrofitApiProvider =
    AutoDisposeProvider<QuickConnectRetrofitApi>.internal(
  quickConnectRetrofitApi,
  name: r'quickConnectRetrofitApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickConnectRetrofitApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickConnectRetrofitApiRef
    = AutoDisposeProviderRef<QuickConnectRetrofitApi>;
String _$quickConnectApiAdapterHash() =>
    r'84ebe9ace2e623cc973e10bf85e750acbc01036b';

/// 适配器 API 提供者 (用于测试和调试)
///
/// Copied from [quickConnectApiAdapter].
@ProviderFor(quickConnectApiAdapter)
final quickConnectApiAdapterProvider =
    AutoDisposeProvider<QuickConnectApiAdapter>.internal(
  quickConnectApiAdapter,
  name: r'quickConnectApiAdapterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickConnectApiAdapterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickConnectApiAdapterRef
    = AutoDisposeProviderRef<QuickConnectApiAdapter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
