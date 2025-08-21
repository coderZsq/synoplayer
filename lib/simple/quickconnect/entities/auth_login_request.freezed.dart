// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_login_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthLoginRequest _$AuthLoginRequestFromJson(Map<String, dynamic> json) {
  return _AuthLoginRequest.fromJson(json);
}

/// @nodoc
mixin _$AuthLoginRequest {
  String get api => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get account => throw _privateConstructorUsedError;
  String get passwd => throw _privateConstructorUsedError;
  String get session => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  String? get otp_code => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthLoginRequestCopyWith<AuthLoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthLoginRequestCopyWith<$Res> {
  factory $AuthLoginRequestCopyWith(
          AuthLoginRequest value, $Res Function(AuthLoginRequest) then) =
      _$AuthLoginRequestCopyWithImpl<$Res, AuthLoginRequest>;
  @useResult
  $Res call(
      {String api,
      String method,
      String account,
      String passwd,
      String session,
      String format,
      String? otp_code,
      String version});
}

/// @nodoc
class _$AuthLoginRequestCopyWithImpl<$Res, $Val extends AuthLoginRequest>
    implements $AuthLoginRequestCopyWith<$Res> {
  _$AuthLoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? api = null,
    Object? method = null,
    Object? account = null,
    Object? passwd = null,
    Object? session = null,
    Object? format = null,
    Object? otp_code = freezed,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      api: null == api
          ? _value.api
          : api // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      passwd: null == passwd
          ? _value.passwd
          : passwd // ignore: cast_nullable_to_non_nullable
              as String,
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      otp_code: freezed == otp_code
          ? _value.otp_code
          : otp_code // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthLoginRequestImplCopyWith<$Res>
    implements $AuthLoginRequestCopyWith<$Res> {
  factory _$$AuthLoginRequestImplCopyWith(_$AuthLoginRequestImpl value,
          $Res Function(_$AuthLoginRequestImpl) then) =
      __$$AuthLoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String api,
      String method,
      String account,
      String passwd,
      String session,
      String format,
      String? otp_code,
      String version});
}

/// @nodoc
class __$$AuthLoginRequestImplCopyWithImpl<$Res>
    extends _$AuthLoginRequestCopyWithImpl<$Res, _$AuthLoginRequestImpl>
    implements _$$AuthLoginRequestImplCopyWith<$Res> {
  __$$AuthLoginRequestImplCopyWithImpl(_$AuthLoginRequestImpl _value,
      $Res Function(_$AuthLoginRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? api = null,
    Object? method = null,
    Object? account = null,
    Object? passwd = null,
    Object? session = null,
    Object? format = null,
    Object? otp_code = freezed,
    Object? version = null,
  }) {
    return _then(_$AuthLoginRequestImpl(
      api: null == api
          ? _value.api
          : api // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      passwd: null == passwd
          ? _value.passwd
          : passwd // ignore: cast_nullable_to_non_nullable
              as String,
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      otp_code: freezed == otp_code
          ? _value.otp_code
          : otp_code // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthLoginRequestImpl implements _AuthLoginRequest {
  const _$AuthLoginRequestImpl(
      {required this.api,
      required this.method,
      required this.account,
      required this.passwd,
      required this.session,
      required this.format,
      this.otp_code,
      required this.version});

  factory _$AuthLoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthLoginRequestImplFromJson(json);

  @override
  final String api;
  @override
  final String method;
  @override
  final String account;
  @override
  final String passwd;
  @override
  final String session;
  @override
  final String format;
  @override
  final String? otp_code;
  @override
  final String version;

  @override
  String toString() {
    return 'AuthLoginRequest(api: $api, method: $method, account: $account, passwd: $passwd, session: $session, format: $format, otp_code: $otp_code, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLoginRequestImpl &&
            (identical(other.api, api) || other.api == api) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.passwd, passwd) || other.passwd == passwd) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.otp_code, otp_code) ||
                other.otp_code == otp_code) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, api, method, account, passwd,
      session, format, otp_code, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthLoginRequestImplCopyWith<_$AuthLoginRequestImpl> get copyWith =>
      __$$AuthLoginRequestImplCopyWithImpl<_$AuthLoginRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthLoginRequestImplToJson(
      this,
    );
  }
}

abstract class _AuthLoginRequest implements AuthLoginRequest {
  const factory _AuthLoginRequest(
      {required final String api,
      required final String method,
      required final String account,
      required final String passwd,
      required final String session,
      required final String format,
      final String? otp_code,
      required final String version}) = _$AuthLoginRequestImpl;

  factory _AuthLoginRequest.fromJson(Map<String, dynamic> json) =
      _$AuthLoginRequestImpl.fromJson;

  @override
  String get api;
  @override
  String get method;
  @override
  String get account;
  @override
  String get passwd;
  @override
  String get session;
  @override
  String get format;
  @override
  String? get otp_code;
  @override
  String get version;
  @override
  @JsonKey(ignore: true)
  _$$AuthLoginRequestImplCopyWith<_$AuthLoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
