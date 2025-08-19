// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quickConnectRepositoryHash() =>
    r'f8cd5bf7d0ef99a07ec6fad6082756f37c63dcd1';

/// QuickConnect 仓库 Provider
///
/// Copied from [quickConnectRepository].
@ProviderFor(quickConnectRepository)
final quickConnectRepositoryProvider =
    AutoDisposeProvider<QuickConnectRepository>.internal(
  quickConnectRepository,
  name: r'quickConnectRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickConnectRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickConnectRepositoryRef
    = AutoDisposeProviderRef<QuickConnectRepository>;
String _$quickConnectRemoteDataSourceHash() =>
    r'899b8372f649ce2bea6b4fcf9a3e9950681a5971';

/// QuickConnect 远程数据源 Provider
///
/// Copied from [quickConnectRemoteDataSource].
@ProviderFor(quickConnectRemoteDataSource)
final quickConnectRemoteDataSourceProvider =
    AutoDisposeProvider<QuickConnectRemoteDataSource>.internal(
  quickConnectRemoteDataSource,
  name: r'quickConnectRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickConnectRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickConnectRemoteDataSourceRef
    = AutoDisposeProviderRef<QuickConnectRemoteDataSource>;
String _$quickConnectLocalDataSourceHash() =>
    r'31bcee4182cbb0c18c772a8cc2ba687de905b81b';

/// QuickConnect 本地数据源 Provider
///
/// Copied from [quickConnectLocalDataSource].
@ProviderFor(quickConnectLocalDataSource)
final quickConnectLocalDataSourceProvider =
    AutoDisposeProvider<QuickConnectLocalDataSource>.internal(
  quickConnectLocalDataSource,
  name: r'quickConnectLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickConnectLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickConnectLocalDataSourceRef
    = AutoDisposeProviderRef<QuickConnectLocalDataSource>;
String _$resolveAddressUseCaseHash() =>
    r'fd093f37dd2e0cbefb80b4acdb2854addcd5565b';

/// 地址解析用例 Provider
///
/// Copied from [resolveAddressUseCase].
@ProviderFor(resolveAddressUseCase)
final resolveAddressUseCaseProvider =
    AutoDisposeProvider<ResolveAddressUseCase>.internal(
  resolveAddressUseCase,
  name: r'resolveAddressUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resolveAddressUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResolveAddressUseCaseRef
    = AutoDisposeProviderRef<ResolveAddressUseCase>;
String _$loginUseCaseHash() => r'a2157714a5ba83af0571fd6f5eb328d3b907336c';

/// 登录用例 Provider
///
/// Copied from [loginUseCase].
@ProviderFor(loginUseCase)
final loginUseCaseProvider = AutoDisposeProvider<LoginUseCase>.internal(
  loginUseCase,
  name: r'loginUseCaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginUseCaseRef = AutoDisposeProviderRef<LoginUseCase>;
String _$smartLoginUseCaseHash() => r'5120d5dee3a88d289a19d098387ef3eecd6f530f';

/// 智能登录用例 Provider
///
/// Copied from [smartLoginUseCase].
@ProviderFor(smartLoginUseCase)
final smartLoginUseCaseProvider =
    AutoDisposeProvider<SmartLoginUseCase>.internal(
  smartLoginUseCase,
  name: r'smartLoginUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$smartLoginUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SmartLoginUseCaseRef = AutoDisposeProviderRef<SmartLoginUseCase>;
String _$addressResolutionNotifierHash() =>
    r'1bcd6b380fc38a30c87049a9f1e8cca3e2639aab';

/// 地址解析状态 Provider
///
/// Copied from [AddressResolutionNotifier].
@ProviderFor(AddressResolutionNotifier)
final addressResolutionNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AddressResolutionNotifier, QuickConnectServerInfo?>.internal(
  AddressResolutionNotifier.new,
  name: r'addressResolutionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addressResolutionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AddressResolutionNotifier
    = AutoDisposeAsyncNotifier<QuickConnectServerInfo?>;
String _$loginNotifierHash() => r'4f1a23b7dafb23d3fb508b97eb6c4cef3f8c02af';

/// 登录状态 Provider
///
/// Copied from [LoginNotifier].
@ProviderFor(LoginNotifier)
final loginNotifierProvider = AutoDisposeAsyncNotifierProvider<LoginNotifier,
    QuickConnectLoginResult?>.internal(
  LoginNotifier.new,
  name: r'loginNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginNotifier = AutoDisposeAsyncNotifier<QuickConnectLoginResult?>;
String _$connectionTestNotifierHash() =>
    r'9e64554adfcd9e989422a8d2d9f8a45f958e9ed6';

/// 连接测试状态 Provider
///
/// Copied from [ConnectionTestNotifier].
@ProviderFor(ConnectionTestNotifier)
final connectionTestNotifierProvider = AutoDisposeAsyncNotifierProvider<
    ConnectionTestNotifier, QuickConnectConnectionStatus?>.internal(
  ConnectionTestNotifier.new,
  name: r'connectionTestNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectionTestNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConnectionTestNotifier
    = AutoDisposeAsyncNotifier<QuickConnectConnectionStatus?>;
String _$connectionHistoryNotifierHash() =>
    r'1e1f6fbc71491cdd27018181ececde96bf59f666';

/// 连接历史 Provider
///
/// Copied from [ConnectionHistoryNotifier].
@ProviderFor(ConnectionHistoryNotifier)
final connectionHistoryNotifierProvider = AutoDisposeAsyncNotifierProvider<
    ConnectionHistoryNotifier, List<QuickConnectServerInfo>>.internal(
  ConnectionHistoryNotifier.new,
  name: r'connectionHistoryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectionHistoryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConnectionHistoryNotifier
    = AutoDisposeAsyncNotifier<List<QuickConnectServerInfo>>;
String _$networkConnectivityNotifierHash() =>
    r'e67557aa3a5c7c7346d4afd5e3001fd657fd2e97';

/// 网络连接状态 Provider
///
/// Copied from [NetworkConnectivityNotifier].
@ProviderFor(NetworkConnectivityNotifier)
final networkConnectivityNotifierProvider = AutoDisposeAsyncNotifierProvider<
    NetworkConnectivityNotifier, bool>.internal(
  NetworkConnectivityNotifier.new,
  name: r'networkConnectivityNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkConnectivityNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NetworkConnectivityNotifier = AutoDisposeAsyncNotifier<bool>;
String _$performanceStatsNotifierHash() =>
    r'72576a9bcea1cd91ed019daa6a584d42b84cc33f';

/// 性能统计 Provider
///
/// Copied from [PerformanceStatsNotifier].
@ProviderFor(PerformanceStatsNotifier)
final performanceStatsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    PerformanceStatsNotifier, Map<String, dynamic>>.internal(
  PerformanceStatsNotifier.new,
  name: r'performanceStatsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$performanceStatsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PerformanceStatsNotifier
    = AutoDisposeAsyncNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
