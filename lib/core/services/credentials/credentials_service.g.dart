// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginCredentialsImpl _$$LoginCredentialsImplFromJson(
  Map<String, dynamic> json,
) => _$LoginCredentialsImpl(
  quickConnectId: json['quickConnectId'] as String,
  username: json['username'] as String,
  password: json['password'] as String,
  workingAddress: json['workingAddress'] as String?,
  sid: json['sid'] as String?,
  loginTime: json['loginTime'] == null
      ? null
      : DateTime.parse(json['loginTime'] as String),
  rememberCredentials: json['rememberCredentials'] as bool? ?? true,
);

Map<String, dynamic> _$$LoginCredentialsImplToJson(
  _$LoginCredentialsImpl instance,
) => <String, dynamic>{
  'quickConnectId': instance.quickConnectId,
  'username': instance.username,
  'password': instance.password,
  'workingAddress': instance.workingAddress,
  'sid': instance.sid,
  'loginTime': instance.loginTime?.toIso8601String(),
  'rememberCredentials': instance.rememberCredentials,
};

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CredentialsServiceRef = AutoDisposeProviderRef<CredentialsService>;
String _$currentCredentialsHash() =>
    r'b4ff762f857027963ecf26f49fb06af284518ec8';

/// 当前登录凭据 Provider
///
/// Copied from [currentCredentials].
@ProviderFor(currentCredentials)
final currentCredentialsProvider =
    AutoDisposeFutureProvider<LoginCredentials?>.internal(
      currentCredentials,
      name: r'currentCredentialsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentCredentialsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentCredentialsRef = AutoDisposeFutureProviderRef<LoginCredentials?>;
String _$sessionStatusHash() => r'ea8b0718310d05d1f6b54733f0ac0cabd569c5be';

/// 会话状态 Provider
///
/// Copied from [sessionStatus].
@ProviderFor(sessionStatus)
final sessionStatusProvider = AutoDisposeFutureProvider<SessionStatus>.internal(
  sessionStatus,
  name: r'sessionStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionStatusRef = AutoDisposeFutureProviderRef<SessionStatus>;
String _$isLoggedInHash() => r'da65a2775a9785b4917669bd9ea3d6a5eca0e9ce';

/// 是否已登录 Provider
///
/// Copied from [isLoggedIn].
@ProviderFor(isLoggedIn)
final isLoggedInProvider = AutoDisposeFutureProvider<bool>.internal(
  isLoggedIn,
  name: r'isLoggedInProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isLoggedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsLoggedInRef = AutoDisposeFutureProviderRef<bool>;
String _$currentSessionIdHash() => r'2c26118025b3f19b56d64fa750fe9b90435cae8d';

/// 当前会话 ID Provider
///
/// Copied from [currentSessionId].
@ProviderFor(currentSessionId)
final currentSessionIdProvider = AutoDisposeFutureProvider<String?>.internal(
  currentSessionId,
  name: r'currentSessionIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSessionIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSessionIdRef = AutoDisposeFutureProviderRef<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
