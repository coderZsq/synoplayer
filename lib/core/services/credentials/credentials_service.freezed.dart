// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credentials_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginCredentials _$LoginCredentialsFromJson(Map<String, dynamic> json) {
  return _LoginCredentials.fromJson(json);
}

/// @nodoc
mixin _$LoginCredentials {
  String get quickConnectId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String? get workingAddress => throw _privateConstructorUsedError;
  String? get sid => throw _privateConstructorUsedError;
  DateTime? get loginTime => throw _privateConstructorUsedError;
  bool get rememberCredentials => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginCredentialsCopyWith<LoginCredentials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginCredentialsCopyWith<$Res> {
  factory $LoginCredentialsCopyWith(
          LoginCredentials value, $Res Function(LoginCredentials) then) =
      _$LoginCredentialsCopyWithImpl<$Res, LoginCredentials>;
  @useResult
  $Res call(
      {String quickConnectId,
      String username,
      String password,
      String? workingAddress,
      String? sid,
      DateTime? loginTime,
      bool rememberCredentials});
}

/// @nodoc
class _$LoginCredentialsCopyWithImpl<$Res, $Val extends LoginCredentials>
    implements $LoginCredentialsCopyWith<$Res> {
  _$LoginCredentialsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quickConnectId = null,
    Object? username = null,
    Object? password = null,
    Object? workingAddress = freezed,
    Object? sid = freezed,
    Object? loginTime = freezed,
    Object? rememberCredentials = null,
  }) {
    return _then(_value.copyWith(
      quickConnectId: null == quickConnectId
          ? _value.quickConnectId
          : quickConnectId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      workingAddress: freezed == workingAddress
          ? _value.workingAddress
          : workingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      sid: freezed == sid
          ? _value.sid
          : sid // ignore: cast_nullable_to_non_nullable
              as String?,
      loginTime: freezed == loginTime
          ? _value.loginTime
          : loginTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rememberCredentials: null == rememberCredentials
          ? _value.rememberCredentials
          : rememberCredentials // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginCredentialsImplCopyWith<$Res>
    implements $LoginCredentialsCopyWith<$Res> {
  factory _$$LoginCredentialsImplCopyWith(_$LoginCredentialsImpl value,
          $Res Function(_$LoginCredentialsImpl) then) =
      __$$LoginCredentialsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String quickConnectId,
      String username,
      String password,
      String? workingAddress,
      String? sid,
      DateTime? loginTime,
      bool rememberCredentials});
}

/// @nodoc
class __$$LoginCredentialsImplCopyWithImpl<$Res>
    extends _$LoginCredentialsCopyWithImpl<$Res, _$LoginCredentialsImpl>
    implements _$$LoginCredentialsImplCopyWith<$Res> {
  __$$LoginCredentialsImplCopyWithImpl(_$LoginCredentialsImpl _value,
      $Res Function(_$LoginCredentialsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quickConnectId = null,
    Object? username = null,
    Object? password = null,
    Object? workingAddress = freezed,
    Object? sid = freezed,
    Object? loginTime = freezed,
    Object? rememberCredentials = null,
  }) {
    return _then(_$LoginCredentialsImpl(
      quickConnectId: null == quickConnectId
          ? _value.quickConnectId
          : quickConnectId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      workingAddress: freezed == workingAddress
          ? _value.workingAddress
          : workingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      sid: freezed == sid
          ? _value.sid
          : sid // ignore: cast_nullable_to_non_nullable
              as String?,
      loginTime: freezed == loginTime
          ? _value.loginTime
          : loginTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rememberCredentials: null == rememberCredentials
          ? _value.rememberCredentials
          : rememberCredentials // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginCredentialsImpl implements _LoginCredentials {
  const _$LoginCredentialsImpl(
      {required this.quickConnectId,
      required this.username,
      required this.password,
      this.workingAddress,
      this.sid,
      this.loginTime,
      this.rememberCredentials = true});

  factory _$LoginCredentialsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginCredentialsImplFromJson(json);

  @override
  final String quickConnectId;
  @override
  final String username;
  @override
  final String password;
  @override
  final String? workingAddress;
  @override
  final String? sid;
  @override
  final DateTime? loginTime;
  @override
  @JsonKey()
  final bool rememberCredentials;

  @override
  String toString() {
    return 'LoginCredentials(quickConnectId: $quickConnectId, username: $username, password: $password, workingAddress: $workingAddress, sid: $sid, loginTime: $loginTime, rememberCredentials: $rememberCredentials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginCredentialsImpl &&
            (identical(other.quickConnectId, quickConnectId) ||
                other.quickConnectId == quickConnectId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.workingAddress, workingAddress) ||
                other.workingAddress == workingAddress) &&
            (identical(other.sid, sid) || other.sid == sid) &&
            (identical(other.loginTime, loginTime) ||
                other.loginTime == loginTime) &&
            (identical(other.rememberCredentials, rememberCredentials) ||
                other.rememberCredentials == rememberCredentials));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, quickConnectId, username,
      password, workingAddress, sid, loginTime, rememberCredentials);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginCredentialsImplCopyWith<_$LoginCredentialsImpl> get copyWith =>
      __$$LoginCredentialsImplCopyWithImpl<_$LoginCredentialsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginCredentialsImplToJson(
      this,
    );
  }
}

abstract class _LoginCredentials implements LoginCredentials {
  const factory _LoginCredentials(
      {required final String quickConnectId,
      required final String username,
      required final String password,
      final String? workingAddress,
      final String? sid,
      final DateTime? loginTime,
      final bool rememberCredentials}) = _$LoginCredentialsImpl;

  factory _LoginCredentials.fromJson(Map<String, dynamic> json) =
      _$LoginCredentialsImpl.fromJson;

  @override
  String get quickConnectId;
  @override
  String get username;
  @override
  String get password;
  @override
  String? get workingAddress;
  @override
  String? get sid;
  @override
  DateTime? get loginTime;
  @override
  bool get rememberCredentials;
  @override
  @JsonKey(ignore: true)
  _$$LoginCredentialsImplCopyWith<_$LoginCredentialsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
