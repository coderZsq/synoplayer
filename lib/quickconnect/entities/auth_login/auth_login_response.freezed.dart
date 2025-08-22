// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthLoginResponse _$AuthLoginResponseFromJson(Map<String, dynamic> json) {
  return _AuthLoginResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthLoginResponse {
  ErrorInfo? get error => throw _privateConstructorUsedError;
  bool? get success => throw _privateConstructorUsedError;
  LoginData? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthLoginResponseCopyWith<AuthLoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthLoginResponseCopyWith<$Res> {
  factory $AuthLoginResponseCopyWith(
          AuthLoginResponse value, $Res Function(AuthLoginResponse) then) =
      _$AuthLoginResponseCopyWithImpl<$Res, AuthLoginResponse>;
  @useResult
  $Res call({ErrorInfo? error, bool? success, LoginData? data});

  $ErrorInfoCopyWith<$Res>? get error;
  $LoginDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$AuthLoginResponseCopyWithImpl<$Res, $Val extends AuthLoginResponse>
    implements $AuthLoginResponseCopyWith<$Res> {
  _$AuthLoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? success = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorInfo?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LoginData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ErrorInfoCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $ErrorInfoCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LoginDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $LoginDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthLoginResponseImplCopyWith<$Res>
    implements $AuthLoginResponseCopyWith<$Res> {
  factory _$$AuthLoginResponseImplCopyWith(_$AuthLoginResponseImpl value,
          $Res Function(_$AuthLoginResponseImpl) then) =
      __$$AuthLoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ErrorInfo? error, bool? success, LoginData? data});

  @override
  $ErrorInfoCopyWith<$Res>? get error;
  @override
  $LoginDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$AuthLoginResponseImplCopyWithImpl<$Res>
    extends _$AuthLoginResponseCopyWithImpl<$Res, _$AuthLoginResponseImpl>
    implements _$$AuthLoginResponseImplCopyWith<$Res> {
  __$$AuthLoginResponseImplCopyWithImpl(_$AuthLoginResponseImpl _value,
      $Res Function(_$AuthLoginResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? success = freezed,
    Object? data = freezed,
  }) {
    return _then(_$AuthLoginResponseImpl(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorInfo?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LoginData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthLoginResponseImpl implements _AuthLoginResponse {
  const _$AuthLoginResponseImpl(
      {required this.error, required this.success, required this.data});

  factory _$AuthLoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthLoginResponseImplFromJson(json);

  @override
  final ErrorInfo? error;
  @override
  final bool? success;
  @override
  final LoginData? data;

  @override
  String toString() {
    return 'AuthLoginResponse(error: $error, success: $success, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLoginResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, success, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthLoginResponseImplCopyWith<_$AuthLoginResponseImpl> get copyWith =>
      __$$AuthLoginResponseImplCopyWithImpl<_$AuthLoginResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthLoginResponseImplToJson(
      this,
    );
  }
}

abstract class _AuthLoginResponse implements AuthLoginResponse {
  const factory _AuthLoginResponse(
      {required final ErrorInfo? error,
      required final bool? success,
      required final LoginData? data}) = _$AuthLoginResponseImpl;

  factory _AuthLoginResponse.fromJson(Map<String, dynamic> json) =
      _$AuthLoginResponseImpl.fromJson;

  @override
  ErrorInfo? get error;
  @override
  bool? get success;
  @override
  LoginData? get data;
  @override
  @JsonKey(ignore: true)
  _$$AuthLoginResponseImplCopyWith<_$AuthLoginResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ErrorInfo _$ErrorInfoFromJson(Map<String, dynamic> json) {
  return _ErrorInfo.fromJson(json);
}

/// @nodoc
mixin _$ErrorInfo {
  int? get code => throw _privateConstructorUsedError;
  ErrorDetails? get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorInfoCopyWith<ErrorInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorInfoCopyWith<$Res> {
  factory $ErrorInfoCopyWith(ErrorInfo value, $Res Function(ErrorInfo) then) =
      _$ErrorInfoCopyWithImpl<$Res, ErrorInfo>;
  @useResult
  $Res call({int? code, ErrorDetails? errors});

  $ErrorDetailsCopyWith<$Res>? get errors;
}

/// @nodoc
class _$ErrorInfoCopyWithImpl<$Res, $Val extends ErrorInfo>
    implements $ErrorInfoCopyWith<$Res> {
  _$ErrorInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? errors = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      errors: freezed == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as ErrorDetails?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ErrorDetailsCopyWith<$Res>? get errors {
    if (_value.errors == null) {
      return null;
    }

    return $ErrorDetailsCopyWith<$Res>(_value.errors!, (value) {
      return _then(_value.copyWith(errors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ErrorInfoImplCopyWith<$Res>
    implements $ErrorInfoCopyWith<$Res> {
  factory _$$ErrorInfoImplCopyWith(
          _$ErrorInfoImpl value, $Res Function(_$ErrorInfoImpl) then) =
      __$$ErrorInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, ErrorDetails? errors});

  @override
  $ErrorDetailsCopyWith<$Res>? get errors;
}

/// @nodoc
class __$$ErrorInfoImplCopyWithImpl<$Res>
    extends _$ErrorInfoCopyWithImpl<$Res, _$ErrorInfoImpl>
    implements _$$ErrorInfoImplCopyWith<$Res> {
  __$$ErrorInfoImplCopyWithImpl(
      _$ErrorInfoImpl _value, $Res Function(_$ErrorInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? errors = freezed,
  }) {
    return _then(_$ErrorInfoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      errors: freezed == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as ErrorDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorInfoImpl implements _ErrorInfo {
  const _$ErrorInfoImpl({required this.code, required this.errors});

  factory _$ErrorInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorInfoImplFromJson(json);

  @override
  final int? code;
  @override
  final ErrorDetails? errors;

  @override
  String toString() {
    return 'ErrorInfo(code: $code, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorInfoImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.errors, errors) || other.errors == errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, errors);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorInfoImplCopyWith<_$ErrorInfoImpl> get copyWith =>
      __$$ErrorInfoImplCopyWithImpl<_$ErrorInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorInfoImplToJson(
      this,
    );
  }
}

abstract class _ErrorInfo implements ErrorInfo {
  const factory _ErrorInfo(
      {required final int? code,
      required final ErrorDetails? errors}) = _$ErrorInfoImpl;

  factory _ErrorInfo.fromJson(Map<String, dynamic> json) =
      _$ErrorInfoImpl.fromJson;

  @override
  int? get code;
  @override
  ErrorDetails? get errors;
  @override
  @JsonKey(ignore: true)
  _$$ErrorInfoImplCopyWith<_$ErrorInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ErrorDetails _$ErrorDetailsFromJson(Map<String, dynamic> json) {
  return _ErrorDetails.fromJson(json);
}

/// @nodoc
mixin _$ErrorDetails {
  String? get token => throw _privateConstructorUsedError;
  List<ErrorType>? get types => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorDetailsCopyWith<ErrorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorDetailsCopyWith<$Res> {
  factory $ErrorDetailsCopyWith(
          ErrorDetails value, $Res Function(ErrorDetails) then) =
      _$ErrorDetailsCopyWithImpl<$Res, ErrorDetails>;
  @useResult
  $Res call({String? token, List<ErrorType>? types});
}

/// @nodoc
class _$ErrorDetailsCopyWithImpl<$Res, $Val extends ErrorDetails>
    implements $ErrorDetailsCopyWith<$Res> {
  _$ErrorDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? types = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      types: freezed == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<ErrorType>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorDetailsImplCopyWith<$Res>
    implements $ErrorDetailsCopyWith<$Res> {
  factory _$$ErrorDetailsImplCopyWith(
          _$ErrorDetailsImpl value, $Res Function(_$ErrorDetailsImpl) then) =
      __$$ErrorDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? token, List<ErrorType>? types});
}

/// @nodoc
class __$$ErrorDetailsImplCopyWithImpl<$Res>
    extends _$ErrorDetailsCopyWithImpl<$Res, _$ErrorDetailsImpl>
    implements _$$ErrorDetailsImplCopyWith<$Res> {
  __$$ErrorDetailsImplCopyWithImpl(
      _$ErrorDetailsImpl _value, $Res Function(_$ErrorDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? types = freezed,
  }) {
    return _then(_$ErrorDetailsImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      types: freezed == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as List<ErrorType>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorDetailsImpl implements _ErrorDetails {
  const _$ErrorDetailsImpl(
      {required this.token, required final List<ErrorType>? types})
      : _types = types;

  factory _$ErrorDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorDetailsImplFromJson(json);

  @override
  final String? token;
  final List<ErrorType>? _types;
  @override
  List<ErrorType>? get types {
    final value = _types;
    if (value == null) return null;
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ErrorDetails(token: $token, types: $types)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorDetailsImpl &&
            (identical(other.token, token) || other.token == token) &&
            const DeepCollectionEquality().equals(other._types, _types));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, token, const DeepCollectionEquality().hash(_types));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorDetailsImplCopyWith<_$ErrorDetailsImpl> get copyWith =>
      __$$ErrorDetailsImplCopyWithImpl<_$ErrorDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorDetailsImplToJson(
      this,
    );
  }
}

abstract class _ErrorDetails implements ErrorDetails {
  const factory _ErrorDetails(
      {required final String? token,
      required final List<ErrorType>? types}) = _$ErrorDetailsImpl;

  factory _ErrorDetails.fromJson(Map<String, dynamic> json) =
      _$ErrorDetailsImpl.fromJson;

  @override
  String? get token;
  @override
  List<ErrorType>? get types;
  @override
  @JsonKey(ignore: true)
  _$$ErrorDetailsImplCopyWith<_$ErrorDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ErrorType _$ErrorTypeFromJson(Map<String, dynamic> json) {
  return _ErrorType.fromJson(json);
}

/// @nodoc
mixin _$ErrorType {
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorTypeCopyWith<ErrorType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorTypeCopyWith<$Res> {
  factory $ErrorTypeCopyWith(ErrorType value, $Res Function(ErrorType) then) =
      _$ErrorTypeCopyWithImpl<$Res, ErrorType>;
  @useResult
  $Res call({String? type});
}

/// @nodoc
class _$ErrorTypeCopyWithImpl<$Res, $Val extends ErrorType>
    implements $ErrorTypeCopyWith<$Res> {
  _$ErrorTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorTypeImplCopyWith<$Res>
    implements $ErrorTypeCopyWith<$Res> {
  factory _$$ErrorTypeImplCopyWith(
          _$ErrorTypeImpl value, $Res Function(_$ErrorTypeImpl) then) =
      __$$ErrorTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? type});
}

/// @nodoc
class __$$ErrorTypeImplCopyWithImpl<$Res>
    extends _$ErrorTypeCopyWithImpl<$Res, _$ErrorTypeImpl>
    implements _$$ErrorTypeImplCopyWith<$Res> {
  __$$ErrorTypeImplCopyWithImpl(
      _$ErrorTypeImpl _value, $Res Function(_$ErrorTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_$ErrorTypeImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorTypeImpl implements _ErrorType {
  const _$ErrorTypeImpl({required this.type});

  factory _$ErrorTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorTypeImplFromJson(json);

  @override
  final String? type;

  @override
  String toString() {
    return 'ErrorType(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorTypeImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorTypeImplCopyWith<_$ErrorTypeImpl> get copyWith =>
      __$$ErrorTypeImplCopyWithImpl<_$ErrorTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorTypeImplToJson(
      this,
    );
  }
}

abstract class _ErrorType implements ErrorType {
  const factory _ErrorType({required final String? type}) = _$ErrorTypeImpl;

  factory _ErrorType.fromJson(Map<String, dynamic> json) =
      _$ErrorTypeImpl.fromJson;

  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$ErrorTypeImplCopyWith<_$ErrorTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginData _$LoginDataFromJson(Map<String, dynamic> json) {
  return _LoginData.fromJson(json);
}

/// @nodoc
mixin _$LoginData {
  String? get account => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  String? get ikMessage => throw _privateConstructorUsedError;
  bool? get isPortalPort => throw _privateConstructorUsedError;
  String? get sid => throw _privateConstructorUsedError;
  String? get synotoken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginDataCopyWith<LoginData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginDataCopyWith<$Res> {
  factory $LoginDataCopyWith(LoginData value, $Res Function(LoginData) then) =
      _$LoginDataCopyWithImpl<$Res, LoginData>;
  @useResult
  $Res call(
      {String? account,
      String? deviceId,
      String? ikMessage,
      bool? isPortalPort,
      String? sid,
      String? synotoken});
}

/// @nodoc
class _$LoginDataCopyWithImpl<$Res, $Val extends LoginData>
    implements $LoginDataCopyWith<$Res> {
  _$LoginDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = freezed,
    Object? deviceId = freezed,
    Object? ikMessage = freezed,
    Object? isPortalPort = freezed,
    Object? sid = freezed,
    Object? synotoken = freezed,
  }) {
    return _then(_value.copyWith(
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      ikMessage: freezed == ikMessage
          ? _value.ikMessage
          : ikMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isPortalPort: freezed == isPortalPort
          ? _value.isPortalPort
          : isPortalPort // ignore: cast_nullable_to_non_nullable
              as bool?,
      sid: freezed == sid
          ? _value.sid
          : sid // ignore: cast_nullable_to_non_nullable
              as String?,
      synotoken: freezed == synotoken
          ? _value.synotoken
          : synotoken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginDataImplCopyWith<$Res>
    implements $LoginDataCopyWith<$Res> {
  factory _$$LoginDataImplCopyWith(
          _$LoginDataImpl value, $Res Function(_$LoginDataImpl) then) =
      __$$LoginDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? account,
      String? deviceId,
      String? ikMessage,
      bool? isPortalPort,
      String? sid,
      String? synotoken});
}

/// @nodoc
class __$$LoginDataImplCopyWithImpl<$Res>
    extends _$LoginDataCopyWithImpl<$Res, _$LoginDataImpl>
    implements _$$LoginDataImplCopyWith<$Res> {
  __$$LoginDataImplCopyWithImpl(
      _$LoginDataImpl _value, $Res Function(_$LoginDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = freezed,
    Object? deviceId = freezed,
    Object? ikMessage = freezed,
    Object? isPortalPort = freezed,
    Object? sid = freezed,
    Object? synotoken = freezed,
  }) {
    return _then(_$LoginDataImpl(
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      ikMessage: freezed == ikMessage
          ? _value.ikMessage
          : ikMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isPortalPort: freezed == isPortalPort
          ? _value.isPortalPort
          : isPortalPort // ignore: cast_nullable_to_non_nullable
              as bool?,
      sid: freezed == sid
          ? _value.sid
          : sid // ignore: cast_nullable_to_non_nullable
              as String?,
      synotoken: freezed == synotoken
          ? _value.synotoken
          : synotoken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginDataImpl implements _LoginData {
  const _$LoginDataImpl(
      {required this.account,
      required this.deviceId,
      required this.ikMessage,
      required this.isPortalPort,
      required this.sid,
      required this.synotoken});

  factory _$LoginDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginDataImplFromJson(json);

  @override
  final String? account;
  @override
  final String? deviceId;
  @override
  final String? ikMessage;
  @override
  final bool? isPortalPort;
  @override
  final String? sid;
  @override
  final String? synotoken;

  @override
  String toString() {
    return 'LoginData(account: $account, deviceId: $deviceId, ikMessage: $ikMessage, isPortalPort: $isPortalPort, sid: $sid, synotoken: $synotoken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginDataImpl &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.ikMessage, ikMessage) ||
                other.ikMessage == ikMessage) &&
            (identical(other.isPortalPort, isPortalPort) ||
                other.isPortalPort == isPortalPort) &&
            (identical(other.sid, sid) || other.sid == sid) &&
            (identical(other.synotoken, synotoken) ||
                other.synotoken == synotoken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, account, deviceId, ikMessage, isPortalPort, sid, synotoken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginDataImplCopyWith<_$LoginDataImpl> get copyWith =>
      __$$LoginDataImplCopyWithImpl<_$LoginDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginDataImplToJson(
      this,
    );
  }
}

abstract class _LoginData implements LoginData {
  const factory _LoginData(
      {required final String? account,
      required final String? deviceId,
      required final String? ikMessage,
      required final bool? isPortalPort,
      required final String? sid,
      required final String? synotoken}) = _$LoginDataImpl;

  factory _LoginData.fromJson(Map<String, dynamic> json) =
      _$LoginDataImpl.fromJson;

  @override
  String? get account;
  @override
  String? get deviceId;
  @override
  String? get ikMessage;
  @override
  bool? get isPortalPort;
  @override
  String? get sid;
  @override
  String? get synotoken;
  @override
  @JsonKey(ignore: true)
  _$$LoginDataImplCopyWith<_$LoginDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
