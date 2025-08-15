// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return LoginResultSuccess.fromJson(json);
    case 'failure':
      return LoginResultFailure.fromJson(json);
    case 'requireOTP':
      return LoginResultRequireOTP.fromJson(json);
    case 'requireOTPWithAddress':
      return LoginResultRequireOTPWithAddress.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'LoginResult',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$LoginResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String sid, String? availableAddress) success,
    required TResult Function(String errorMessage) failure,
    required TResult Function(String errorMessage) requireOTP,
    required TResult Function(String errorMessage, String availableAddress)
    requireOTPWithAddress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String sid, String? availableAddress)? success,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(String errorMessage)? requireOTP,
    TResult? Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sid, String? availableAddress)? success,
    TResult Function(String errorMessage)? failure,
    TResult Function(String errorMessage)? requireOTP,
    TResult Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginResultSuccess value) success,
    required TResult Function(LoginResultFailure value) failure,
    required TResult Function(LoginResultRequireOTP value) requireOTP,
    required TResult Function(LoginResultRequireOTPWithAddress value)
    requireOTPWithAddress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginResultSuccess value)? success,
    TResult? Function(LoginResultFailure value)? failure,
    TResult? Function(LoginResultRequireOTP value)? requireOTP,
    TResult? Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginResultSuccess value)? success,
    TResult Function(LoginResultFailure value)? failure,
    TResult Function(LoginResultRequireOTP value)? requireOTP,
    TResult Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this LoginResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResultCopyWith<$Res> {
  factory $LoginResultCopyWith(
    LoginResult value,
    $Res Function(LoginResult) then,
  ) = _$LoginResultCopyWithImpl<$Res, LoginResult>;
}

/// @nodoc
class _$LoginResultCopyWithImpl<$Res, $Val extends LoginResult>
    implements $LoginResultCopyWith<$Res> {
  _$LoginResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoginResultSuccessImplCopyWith<$Res> {
  factory _$$LoginResultSuccessImplCopyWith(
    _$LoginResultSuccessImpl value,
    $Res Function(_$LoginResultSuccessImpl) then,
  ) = __$$LoginResultSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sid, String? availableAddress});
}

/// @nodoc
class __$$LoginResultSuccessImplCopyWithImpl<$Res>
    extends _$LoginResultCopyWithImpl<$Res, _$LoginResultSuccessImpl>
    implements _$$LoginResultSuccessImplCopyWith<$Res> {
  __$$LoginResultSuccessImplCopyWithImpl(
    _$LoginResultSuccessImpl _value,
    $Res Function(_$LoginResultSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sid = null, Object? availableAddress = freezed}) {
    return _then(
      _$LoginResultSuccessImpl(
        sid: null == sid
            ? _value.sid
            : sid // ignore: cast_nullable_to_non_nullable
                  as String,
        availableAddress: freezed == availableAddress
            ? _value.availableAddress
            : availableAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResultSuccessImpl extends LoginResultSuccess {
  const _$LoginResultSuccessImpl({
    required this.sid,
    this.availableAddress,
    final String? $type,
  }) : $type = $type ?? 'success',
       super._();

  factory _$LoginResultSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResultSuccessImplFromJson(json);

  @override
  final String sid;
  @override
  final String? availableAddress;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LoginResult.success(sid: $sid, availableAddress: $availableAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResultSuccessImpl &&
            (identical(other.sid, sid) || other.sid == sid) &&
            (identical(other.availableAddress, availableAddress) ||
                other.availableAddress == availableAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sid, availableAddress);

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResultSuccessImplCopyWith<_$LoginResultSuccessImpl> get copyWith =>
      __$$LoginResultSuccessImplCopyWithImpl<_$LoginResultSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String sid, String? availableAddress) success,
    required TResult Function(String errorMessage) failure,
    required TResult Function(String errorMessage) requireOTP,
    required TResult Function(String errorMessage, String availableAddress)
    requireOTPWithAddress,
  }) {
    return success(sid, availableAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String sid, String? availableAddress)? success,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(String errorMessage)? requireOTP,
    TResult? Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
  }) {
    return success?.call(sid, availableAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sid, String? availableAddress)? success,
    TResult Function(String errorMessage)? failure,
    TResult Function(String errorMessage)? requireOTP,
    TResult Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(sid, availableAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginResultSuccess value) success,
    required TResult Function(LoginResultFailure value) failure,
    required TResult Function(LoginResultRequireOTP value) requireOTP,
    required TResult Function(LoginResultRequireOTPWithAddress value)
    requireOTPWithAddress,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginResultSuccess value)? success,
    TResult? Function(LoginResultFailure value)? failure,
    TResult? Function(LoginResultRequireOTP value)? requireOTP,
    TResult? Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginResultSuccess value)? success,
    TResult Function(LoginResultFailure value)? failure,
    TResult Function(LoginResultRequireOTP value)? requireOTP,
    TResult Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResultSuccessImplToJson(this);
  }
}

abstract class LoginResultSuccess extends LoginResult {
  const factory LoginResultSuccess({
    required final String sid,
    final String? availableAddress,
  }) = _$LoginResultSuccessImpl;
  const LoginResultSuccess._() : super._();

  factory LoginResultSuccess.fromJson(Map<String, dynamic> json) =
      _$LoginResultSuccessImpl.fromJson;

  String get sid;
  String? get availableAddress;

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResultSuccessImplCopyWith<_$LoginResultSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginResultFailureImplCopyWith<$Res> {
  factory _$$LoginResultFailureImplCopyWith(
    _$LoginResultFailureImpl value,
    $Res Function(_$LoginResultFailureImpl) then,
  ) = __$$LoginResultFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$LoginResultFailureImplCopyWithImpl<$Res>
    extends _$LoginResultCopyWithImpl<$Res, _$LoginResultFailureImpl>
    implements _$$LoginResultFailureImplCopyWith<$Res> {
  __$$LoginResultFailureImplCopyWithImpl(
    _$LoginResultFailureImpl _value,
    $Res Function(_$LoginResultFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = null}) {
    return _then(
      _$LoginResultFailureImpl(
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResultFailureImpl extends LoginResultFailure {
  const _$LoginResultFailureImpl({
    required this.errorMessage,
    final String? $type,
  }) : $type = $type ?? 'failure',
       super._();

  factory _$LoginResultFailureImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResultFailureImplFromJson(json);

  @override
  final String errorMessage;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LoginResult.failure(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResultFailureImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResultFailureImplCopyWith<_$LoginResultFailureImpl> get copyWith =>
      __$$LoginResultFailureImplCopyWithImpl<_$LoginResultFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String sid, String? availableAddress) success,
    required TResult Function(String errorMessage) failure,
    required TResult Function(String errorMessage) requireOTP,
    required TResult Function(String errorMessage, String availableAddress)
    requireOTPWithAddress,
  }) {
    return failure(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String sid, String? availableAddress)? success,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(String errorMessage)? requireOTP,
    TResult? Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
  }) {
    return failure?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sid, String? availableAddress)? success,
    TResult Function(String errorMessage)? failure,
    TResult Function(String errorMessage)? requireOTP,
    TResult Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginResultSuccess value) success,
    required TResult Function(LoginResultFailure value) failure,
    required TResult Function(LoginResultRequireOTP value) requireOTP,
    required TResult Function(LoginResultRequireOTPWithAddress value)
    requireOTPWithAddress,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginResultSuccess value)? success,
    TResult? Function(LoginResultFailure value)? failure,
    TResult? Function(LoginResultRequireOTP value)? requireOTP,
    TResult? Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginResultSuccess value)? success,
    TResult Function(LoginResultFailure value)? failure,
    TResult Function(LoginResultRequireOTP value)? requireOTP,
    TResult Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResultFailureImplToJson(this);
  }
}

abstract class LoginResultFailure extends LoginResult {
  const factory LoginResultFailure({required final String errorMessage}) =
      _$LoginResultFailureImpl;
  const LoginResultFailure._() : super._();

  factory LoginResultFailure.fromJson(Map<String, dynamic> json) =
      _$LoginResultFailureImpl.fromJson;

  String get errorMessage;

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResultFailureImplCopyWith<_$LoginResultFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginResultRequireOTPImplCopyWith<$Res> {
  factory _$$LoginResultRequireOTPImplCopyWith(
    _$LoginResultRequireOTPImpl value,
    $Res Function(_$LoginResultRequireOTPImpl) then,
  ) = __$$LoginResultRequireOTPImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$LoginResultRequireOTPImplCopyWithImpl<$Res>
    extends _$LoginResultCopyWithImpl<$Res, _$LoginResultRequireOTPImpl>
    implements _$$LoginResultRequireOTPImplCopyWith<$Res> {
  __$$LoginResultRequireOTPImplCopyWithImpl(
    _$LoginResultRequireOTPImpl _value,
    $Res Function(_$LoginResultRequireOTPImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = null}) {
    return _then(
      _$LoginResultRequireOTPImpl(
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResultRequireOTPImpl extends LoginResultRequireOTP {
  const _$LoginResultRequireOTPImpl({
    required this.errorMessage,
    final String? $type,
  }) : $type = $type ?? 'requireOTP',
       super._();

  factory _$LoginResultRequireOTPImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResultRequireOTPImplFromJson(json);

  @override
  final String errorMessage;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LoginResult.requireOTP(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResultRequireOTPImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResultRequireOTPImplCopyWith<_$LoginResultRequireOTPImpl>
  get copyWith =>
      __$$LoginResultRequireOTPImplCopyWithImpl<_$LoginResultRequireOTPImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String sid, String? availableAddress) success,
    required TResult Function(String errorMessage) failure,
    required TResult Function(String errorMessage) requireOTP,
    required TResult Function(String errorMessage, String availableAddress)
    requireOTPWithAddress,
  }) {
    return requireOTP(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String sid, String? availableAddress)? success,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(String errorMessage)? requireOTP,
    TResult? Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
  }) {
    return requireOTP?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sid, String? availableAddress)? success,
    TResult Function(String errorMessage)? failure,
    TResult Function(String errorMessage)? requireOTP,
    TResult Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) {
    if (requireOTP != null) {
      return requireOTP(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginResultSuccess value) success,
    required TResult Function(LoginResultFailure value) failure,
    required TResult Function(LoginResultRequireOTP value) requireOTP,
    required TResult Function(LoginResultRequireOTPWithAddress value)
    requireOTPWithAddress,
  }) {
    return requireOTP(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginResultSuccess value)? success,
    TResult? Function(LoginResultFailure value)? failure,
    TResult? Function(LoginResultRequireOTP value)? requireOTP,
    TResult? Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
  }) {
    return requireOTP?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginResultSuccess value)? success,
    TResult Function(LoginResultFailure value)? failure,
    TResult Function(LoginResultRequireOTP value)? requireOTP,
    TResult Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) {
    if (requireOTP != null) {
      return requireOTP(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResultRequireOTPImplToJson(this);
  }
}

abstract class LoginResultRequireOTP extends LoginResult {
  const factory LoginResultRequireOTP({required final String errorMessage}) =
      _$LoginResultRequireOTPImpl;
  const LoginResultRequireOTP._() : super._();

  factory LoginResultRequireOTP.fromJson(Map<String, dynamic> json) =
      _$LoginResultRequireOTPImpl.fromJson;

  String get errorMessage;

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResultRequireOTPImplCopyWith<_$LoginResultRequireOTPImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginResultRequireOTPWithAddressImplCopyWith<$Res> {
  factory _$$LoginResultRequireOTPWithAddressImplCopyWith(
    _$LoginResultRequireOTPWithAddressImpl value,
    $Res Function(_$LoginResultRequireOTPWithAddressImpl) then,
  ) = __$$LoginResultRequireOTPWithAddressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage, String availableAddress});
}

/// @nodoc
class __$$LoginResultRequireOTPWithAddressImplCopyWithImpl<$Res>
    extends
        _$LoginResultCopyWithImpl<$Res, _$LoginResultRequireOTPWithAddressImpl>
    implements _$$LoginResultRequireOTPWithAddressImplCopyWith<$Res> {
  __$$LoginResultRequireOTPWithAddressImplCopyWithImpl(
    _$LoginResultRequireOTPWithAddressImpl _value,
    $Res Function(_$LoginResultRequireOTPWithAddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = null, Object? availableAddress = null}) {
    return _then(
      _$LoginResultRequireOTPWithAddressImpl(
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        availableAddress: null == availableAddress
            ? _value.availableAddress
            : availableAddress // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResultRequireOTPWithAddressImpl
    extends LoginResultRequireOTPWithAddress {
  const _$LoginResultRequireOTPWithAddressImpl({
    required this.errorMessage,
    required this.availableAddress,
    final String? $type,
  }) : $type = $type ?? 'requireOTPWithAddress',
       super._();

  factory _$LoginResultRequireOTPWithAddressImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$LoginResultRequireOTPWithAddressImplFromJson(json);

  @override
  final String errorMessage;
  @override
  final String availableAddress;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LoginResult.requireOTPWithAddress(errorMessage: $errorMessage, availableAddress: $availableAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResultRequireOTPWithAddressImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.availableAddress, availableAddress) ||
                other.availableAddress == availableAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, errorMessage, availableAddress);

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResultRequireOTPWithAddressImplCopyWith<
    _$LoginResultRequireOTPWithAddressImpl
  >
  get copyWith =>
      __$$LoginResultRequireOTPWithAddressImplCopyWithImpl<
        _$LoginResultRequireOTPWithAddressImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String sid, String? availableAddress) success,
    required TResult Function(String errorMessage) failure,
    required TResult Function(String errorMessage) requireOTP,
    required TResult Function(String errorMessage, String availableAddress)
    requireOTPWithAddress,
  }) {
    return requireOTPWithAddress(errorMessage, availableAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String sid, String? availableAddress)? success,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(String errorMessage)? requireOTP,
    TResult? Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
  }) {
    return requireOTPWithAddress?.call(errorMessage, availableAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sid, String? availableAddress)? success,
    TResult Function(String errorMessage)? failure,
    TResult Function(String errorMessage)? requireOTP,
    TResult Function(String errorMessage, String availableAddress)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) {
    if (requireOTPWithAddress != null) {
      return requireOTPWithAddress(errorMessage, availableAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginResultSuccess value) success,
    required TResult Function(LoginResultFailure value) failure,
    required TResult Function(LoginResultRequireOTP value) requireOTP,
    required TResult Function(LoginResultRequireOTPWithAddress value)
    requireOTPWithAddress,
  }) {
    return requireOTPWithAddress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginResultSuccess value)? success,
    TResult? Function(LoginResultFailure value)? failure,
    TResult? Function(LoginResultRequireOTP value)? requireOTP,
    TResult? Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
  }) {
    return requireOTPWithAddress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginResultSuccess value)? success,
    TResult Function(LoginResultFailure value)? failure,
    TResult Function(LoginResultRequireOTP value)? requireOTP,
    TResult Function(LoginResultRequireOTPWithAddress value)?
    requireOTPWithAddress,
    required TResult orElse(),
  }) {
    if (requireOTPWithAddress != null) {
      return requireOTPWithAddress(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResultRequireOTPWithAddressImplToJson(this);
  }
}

abstract class LoginResultRequireOTPWithAddress extends LoginResult {
  const factory LoginResultRequireOTPWithAddress({
    required final String errorMessage,
    required final String availableAddress,
  }) = _$LoginResultRequireOTPWithAddressImpl;
  const LoginResultRequireOTPWithAddress._() : super._();

  factory LoginResultRequireOTPWithAddress.fromJson(Map<String, dynamic> json) =
      _$LoginResultRequireOTPWithAddressImpl.fromJson;

  String get errorMessage;
  String get availableAddress;

  /// Create a copy of LoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResultRequireOTPWithAddressImplCopyWith<
    _$LoginResultRequireOTPWithAddressImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
