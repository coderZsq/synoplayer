// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quickConnectApiHash() => r'96c2260e6f61e93a3424aad5737bbc1cccc4abe2';

/// QuickConnect API 提供者
///
/// 负责创建和管理 QuickConnect API 实例
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
