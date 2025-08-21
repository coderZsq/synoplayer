// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localDataSourceHash() => r'fe095d9b89a418e8bf8bb9bbf3d567391b6e53e5';

/// 本地数据源 Provider
///
/// Copied from [localDataSource].
@ProviderFor(localDataSource)
final localDataSourceProvider =
    AutoDisposeProvider<QuickConnectLocalDataSource>.internal(
  localDataSource,
  name: r'localDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalDataSourceRef
    = AutoDisposeProviderRef<QuickConnectLocalDataSource>;
String _$remoteDataSourceHash() => r'221d43d84e3c5baabdf45826141218308bfac6d6';

/// 远程数据源 Provider
///
/// Copied from [remoteDataSource].
@ProviderFor(remoteDataSource)
final remoteDataSourceProvider =
    AutoDisposeProvider<QuickConnectRemoteDataSource>.internal(
  remoteDataSource,
  name: r'remoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RemoteDataSourceRef
    = AutoDisposeProviderRef<QuickConnectRemoteDataSource>;
String _$quickConnectRepositoryHash() =>
    r'1ffa9eaa4862f393a0d54934661e9377d0e63af3';

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

typedef QuickConnectRepositoryRef
    = AutoDisposeProviderRef<QuickConnectRepository>;
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

typedef SmartLoginUseCaseRef = AutoDisposeProviderRef<SmartLoginUseCase>;
String _$enhancedSmartLoginUseCaseHash() =>
    r'e12cf6a353a1ba33e908d5cac97f84fac647a4ba';

/// 增强智能登录用例 Provider
///
/// Copied from [enhancedSmartLoginUseCase].
@ProviderFor(enhancedSmartLoginUseCase)
final enhancedSmartLoginUseCaseProvider =
    AutoDisposeProvider<EnhancedSmartLoginUseCase>.internal(
  enhancedSmartLoginUseCase,
  name: r'enhancedSmartLoginUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$enhancedSmartLoginUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EnhancedSmartLoginUseCaseRef
    = AutoDisposeProviderRef<EnhancedSmartLoginUseCase>;
String _$connectionManagementUseCaseHash() =>
    r'9e1a5b93d40df91af415773b633a76ad970fb67d';

/// 连接管理用例 Provider
///
/// Copied from [connectionManagementUseCase].
@ProviderFor(connectionManagementUseCase)
final connectionManagementUseCaseProvider =
    AutoDisposeProvider<ConnectionManagementUseCase>.internal(
  connectionManagementUseCase,
  name: r'connectionManagementUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectionManagementUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConnectionManagementUseCaseRef
    = AutoDisposeProviderRef<ConnectionManagementUseCase>;
String _$quickConnectServiceAdapterHash() =>
    r'ef6d80f7c3b412cd042c5ff56b84b0a32b5f56e3';

/// QuickConnect 服务适配器 Provider
///
/// Copied from [quickConnectServiceAdapter].
@ProviderFor(quickConnectServiceAdapter)
final quickConnectServiceAdapterProvider =
    AutoDisposeProvider<QuickConnectServiceAdapter>.internal(
  quickConnectServiceAdapter,
  name: r'quickConnectServiceAdapterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickConnectServiceAdapterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QuickConnectServiceAdapterRef
    = AutoDisposeProviderRef<QuickConnectServiceAdapter>;
String _$sharedPreferencesHash() => r'6c03b929f567eb6f97608f6208b95744ffee3bfd';

/// 共享偏好设置 Provider
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeFutureProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = AutoDisposeFutureProviderRef<SharedPreferences>;
String _$secureStorageHash() => r'273dc403a965c1f24962aaf4d40776611a26f8b8';

/// 安全存储 Provider
///
/// Copied from [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider =
    AutoDisposeProvider<FlutterSecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SecureStorageRef = AutoDisposeProviderRef<FlutterSecureStorage>;
String _$dioHash() => r'c50c57ae3220b42c06ae5c33f1bce6ef76cd8f0c';

/// Dio 客户端 Provider
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioRef = AutoDisposeProviderRef<Dio>;
String _$addressResolutionNotifierHash() =>
    r'3de49cf28ad00d4d7c6bffc67d15059a6ec1c3af';

/// 地址解析状态管理
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
String _$loginNotifierHash() => r'8bc02b31cb97a4a8d448fb02b113ea03fcf185da';

/// 登录状态管理
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
    r'e4722ab73892a159cd7a6448f10f90c37d8cf605';

/// 连接测试状态管理
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
String _$cacheManagementNotifierHash() =>
    r'2f64c51ebabef8d4eec7929f9431a9f33a64fbb1';

/// 缓存管理状态
///
/// Copied from [CacheManagementNotifier].
@ProviderFor(CacheManagementNotifier)
final cacheManagementNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CacheManagementNotifier, Map<String, dynamic>?>.internal(
  CacheManagementNotifier.new,
  name: r'cacheManagementNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cacheManagementNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CacheManagementNotifier
    = AutoDisposeAsyncNotifier<Map<String, dynamic>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
