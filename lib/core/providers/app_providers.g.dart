// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$credentialsServiceHash() =>
    r'3ef4aebba329985abfe382b27ad3c9e0a46672e8';

/// 凭据服务 Provider
///
/// Copied from [credentialsService].
@ProviderFor(credentialsService)
final credentialsServiceProvider =
    AutoDisposeProvider<CredentialsService>.internal(
  credentialsService,
  name: r'credentialsServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$credentialsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CredentialsServiceRef = AutoDisposeProviderRef<CredentialsService>;
String _$themeServiceHash() => r'b66070108bd53fa9a711625ecf5fc04ecc6d862d';

/// 主题服务 Provider
///
/// Copied from [themeService].
@ProviderFor(themeService)
final themeServiceProvider = AutoDisposeProvider<ThemeService>.internal(
  themeService,
  name: r'themeServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ThemeServiceRef = AutoDisposeProviderRef<ThemeService>;
String _$appConfigHash() => r'89539f7dfac47380884155599073a6cbd054873a';

/// 应用配置 Provider
///
/// Copied from [appConfig].
@ProviderFor(appConfig)
final appConfigProvider = AutoDisposeProvider<AppConfig>.internal(
  appConfig,
  name: r'appConfigProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppConfigRef = AutoDisposeProviderRef<AppConfig>;
String _$appDependenciesHash() => r'da4a222c9a24182134e850c89ac0717cf409b8a2';

/// 应用全局依赖管理
///
/// 集中管理所有全局依赖，包括：
/// - 网络服务
/// - 本地存储服务
/// - 主题服务
/// - 认证服务
///
/// Copied from [AppDependencies].
@ProviderFor(AppDependencies)
final appDependenciesProvider =
    AutoDisposeAsyncNotifierProvider<AppDependencies, void>.internal(
  AppDependencies.new,
  name: r'appDependenciesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDependenciesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppDependencies = AutoDisposeAsyncNotifier<void>;
String _$appStateHash() => r'4938d8af585f6b1d3403d1c2fa91adc89072df22';

/// 应用状态管理
///
/// Copied from [AppState].
@ProviderFor(AppState)
final appStateProvider =
    AutoDisposeNotifierProvider<AppState, AppStateData>.internal(
  AppState.new,
  name: r'appStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppState = AutoDisposeNotifier<AppStateData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
