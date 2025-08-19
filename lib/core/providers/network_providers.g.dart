// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkInfoHash() => r'741b8afc2fb3fbb07ee0292562c2af9b068994f9';

/// 网络信息 Provider
///
/// Copied from [networkInfo].
@ProviderFor(networkInfo)
final networkInfoProvider = AutoDisposeProvider<NetworkInfo>.internal(
  networkInfo,
  name: r'networkInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$networkInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NetworkInfoRef = AutoDisposeProviderRef<NetworkInfo>;
String _$networkConnectivityHash() =>
    r'298c569b91cf18366ba614e1299066134005bc10';

/// 网络连接状态 Provider
///
/// Copied from [networkConnectivity].
@ProviderFor(networkConnectivity)
final networkConnectivityProvider = AutoDisposeStreamProvider<bool>.internal(
  networkConnectivity,
  name: r'networkConnectivityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkConnectivityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NetworkConnectivityRef = AutoDisposeStreamProviderRef<bool>;
String _$isNetworkConnectedHash() =>
    r'50316aefb1fc94f615d94cef56be31992386d7fc';

/// 当前网络连接状态 Provider
///
/// Copied from [isNetworkConnected].
@ProviderFor(isNetworkConnected)
final isNetworkConnectedProvider = AutoDisposeFutureProvider<bool>.internal(
  isNetworkConnected,
  name: r'isNetworkConnectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isNetworkConnectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsNetworkConnectedRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
