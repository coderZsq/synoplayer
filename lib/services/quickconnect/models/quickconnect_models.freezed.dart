// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quickconnect_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BaseResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaseResponseCopyWith<BaseResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseResponseCopyWith<$Res> {
  factory $BaseResponseCopyWith(
    BaseResponse value,
    $Res Function(BaseResponse) then,
  ) = _$BaseResponseCopyWithImpl<$Res, BaseResponse>;
  @useResult
  $Res call({bool success, String? error, int? errorCode});
}

/// @nodoc
class _$BaseResponseCopyWithImpl<$Res, $Val extends BaseResponse>
    implements $BaseResponseCopyWith<$Res> {
  _$BaseResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? error = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BaseResponseImplCopyWith<$Res>
    implements $BaseResponseCopyWith<$Res> {
  factory _$$BaseResponseImplCopyWith(
    _$BaseResponseImpl value,
    $Res Function(_$BaseResponseImpl) then,
  ) = __$$BaseResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? error, int? errorCode});
}

/// @nodoc
class __$$BaseResponseImplCopyWithImpl<$Res>
    extends _$BaseResponseCopyWithImpl<$Res, _$BaseResponseImpl>
    implements _$$BaseResponseImplCopyWith<$Res> {
  __$$BaseResponseImplCopyWithImpl(
    _$BaseResponseImpl _value,
    $Res Function(_$BaseResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? error = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(
      _$BaseResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$BaseResponseImpl extends _BaseResponse {
  const _$BaseResponseImpl({required this.success, this.error, this.errorCode})
    : super._();

  @override
  final bool success;
  @override
  final String? error;
  @override
  final int? errorCode;

  @override
  String toString() {
    return 'BaseResponse(success: $success, error: $error, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, success, error, errorCode);

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseResponseImplCopyWith<_$BaseResponseImpl> get copyWith =>
      __$$BaseResponseImplCopyWithImpl<_$BaseResponseImpl>(this, _$identity);
}

abstract class _BaseResponse extends BaseResponse {
  const factory _BaseResponse({
    required final bool success,
    final String? error,
    final int? errorCode,
  }) = _$BaseResponseImpl;
  const _BaseResponse._() : super._();

  @override
  bool get success;
  @override
  String? get error;
  @override
  int? get errorCode;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaseResponseImplCopyWith<_$BaseResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SuccessResponse _$SuccessResponseFromJson(Map<String, dynamic> json) {
  return _SuccessResponse.fromJson(json);
}

/// @nodoc
mixin _$SuccessResponse {
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this SuccessResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SuccessResponseCopyWith<SuccessResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuccessResponseCopyWith<$Res> {
  factory $SuccessResponseCopyWith(
    SuccessResponse value,
    $Res Function(SuccessResponse) then,
  ) = _$SuccessResponseCopyWithImpl<$Res, SuccessResponse>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class _$SuccessResponseCopyWithImpl<$Res, $Val extends SuccessResponse>
    implements $SuccessResponseCopyWith<$Res> {
  _$SuccessResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SuccessResponseImplCopyWith<$Res>
    implements $SuccessResponseCopyWith<$Res> {
  factory _$$SuccessResponseImplCopyWith(
    _$SuccessResponseImpl value,
    $Res Function(_$SuccessResponseImpl) then,
  ) = __$$SuccessResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$SuccessResponseImplCopyWithImpl<$Res>
    extends _$SuccessResponseCopyWithImpl<$Res, _$SuccessResponseImpl>
    implements _$$SuccessResponseImplCopyWith<$Res> {
  __$$SuccessResponseImplCopyWithImpl(
    _$SuccessResponseImpl _value,
    $Res Function(_$SuccessResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$SuccessResponseImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SuccessResponseImpl extends _SuccessResponse {
  const _$SuccessResponseImpl({required final Map<String, dynamic> data})
    : _data = data,
      super._();

  factory _$SuccessResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuccessResponseImplFromJson(json);

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'SuccessResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessResponseImplCopyWith<_$SuccessResponseImpl> get copyWith =>
      __$$SuccessResponseImplCopyWithImpl<_$SuccessResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SuccessResponseImplToJson(this);
  }
}

abstract class _SuccessResponse extends SuccessResponse {
  const factory _SuccessResponse({required final Map<String, dynamic> data}) =
      _$SuccessResponseImpl;
  const _SuccessResponse._() : super._();

  factory _SuccessResponse.fromJson(Map<String, dynamic> json) =
      _$SuccessResponseImpl.fromJson;

  @override
  Map<String, dynamic> get data;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessResponseImplCopyWith<_$SuccessResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ErrorResponse {
  String get error => throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorResponseCopyWith<ErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorResponseCopyWith<$Res> {
  factory $ErrorResponseCopyWith(
    ErrorResponse value,
    $Res Function(ErrorResponse) then,
  ) = _$ErrorResponseCopyWithImpl<$Res, ErrorResponse>;
  @useResult
  $Res call({String error, int? errorCode});
}

/// @nodoc
class _$ErrorResponseCopyWithImpl<$Res, $Val extends ErrorResponse>
    implements $ErrorResponseCopyWith<$Res> {
  _$ErrorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? errorCode = freezed}) {
    return _then(
      _value.copyWith(
            error: null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ErrorResponseImplCopyWith<$Res>
    implements $ErrorResponseCopyWith<$Res> {
  factory _$$ErrorResponseImplCopyWith(
    _$ErrorResponseImpl value,
    $Res Function(_$ErrorResponseImpl) then,
  ) = __$$ErrorResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String error, int? errorCode});
}

/// @nodoc
class __$$ErrorResponseImplCopyWithImpl<$Res>
    extends _$ErrorResponseCopyWithImpl<$Res, _$ErrorResponseImpl>
    implements _$$ErrorResponseImplCopyWith<$Res> {
  __$$ErrorResponseImplCopyWithImpl(
    _$ErrorResponseImpl _value,
    $Res Function(_$ErrorResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? errorCode = freezed}) {
    return _then(
      _$ErrorResponseImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$ErrorResponseImpl extends _ErrorResponse {
  const _$ErrorResponseImpl({required this.error, this.errorCode}) : super._();

  @override
  final String error;
  @override
  final int? errorCode;

  @override
  String toString() {
    return 'ErrorResponse(error: $error, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, errorCode);

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      __$$ErrorResponseImplCopyWithImpl<_$ErrorResponseImpl>(this, _$identity);
}

abstract class _ErrorResponse extends ErrorResponse {
  const factory _ErrorResponse({
    required final String error,
    final int? errorCode,
  }) = _$ErrorResponseImpl;
  const _ErrorResponse._() : super._();

  @override
  String get error;
  @override
  int? get errorCode;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TunnelResponse {
  TunnelData? get tunnelData => throw _privateConstructorUsedError;
  String? get errorInfo => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;

  /// Create a copy of TunnelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TunnelResponseCopyWith<TunnelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TunnelResponseCopyWith<$Res> {
  factory $TunnelResponseCopyWith(
    TunnelResponse value,
    $Res Function(TunnelResponse) then,
  ) = _$TunnelResponseCopyWithImpl<$Res, TunnelResponse>;
  @useResult
  $Res call({
    TunnelData? tunnelData,
    String? errorInfo,
    bool success,
    String? error,
    int? errorCode,
  });

  $TunnelDataCopyWith<$Res>? get tunnelData;
}

/// @nodoc
class _$TunnelResponseCopyWithImpl<$Res, $Val extends TunnelResponse>
    implements $TunnelResponseCopyWith<$Res> {
  _$TunnelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TunnelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tunnelData = freezed,
    Object? errorInfo = freezed,
    Object? success = null,
    Object? error = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            tunnelData: freezed == tunnelData
                ? _value.tunnelData
                : tunnelData // ignore: cast_nullable_to_non_nullable
                      as TunnelData?,
            errorInfo: freezed == errorInfo
                ? _value.errorInfo
                : errorInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of TunnelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TunnelDataCopyWith<$Res>? get tunnelData {
    if (_value.tunnelData == null) {
      return null;
    }

    return $TunnelDataCopyWith<$Res>(_value.tunnelData!, (value) {
      return _then(_value.copyWith(tunnelData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TunnelResponseImplCopyWith<$Res>
    implements $TunnelResponseCopyWith<$Res> {
  factory _$$TunnelResponseImplCopyWith(
    _$TunnelResponseImpl value,
    $Res Function(_$TunnelResponseImpl) then,
  ) = __$$TunnelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TunnelData? tunnelData,
    String? errorInfo,
    bool success,
    String? error,
    int? errorCode,
  });

  @override
  $TunnelDataCopyWith<$Res>? get tunnelData;
}

/// @nodoc
class __$$TunnelResponseImplCopyWithImpl<$Res>
    extends _$TunnelResponseCopyWithImpl<$Res, _$TunnelResponseImpl>
    implements _$$TunnelResponseImplCopyWith<$Res> {
  __$$TunnelResponseImplCopyWithImpl(
    _$TunnelResponseImpl _value,
    $Res Function(_$TunnelResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TunnelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tunnelData = freezed,
    Object? errorInfo = freezed,
    Object? success = null,
    Object? error = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(
      _$TunnelResponseImpl(
        tunnelData: freezed == tunnelData
            ? _value.tunnelData
            : tunnelData // ignore: cast_nullable_to_non_nullable
                  as TunnelData?,
        errorInfo: freezed == errorInfo
            ? _value.errorInfo
            : errorInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$TunnelResponseImpl extends _TunnelResponse {
  const _$TunnelResponseImpl({
    this.tunnelData,
    this.errorInfo,
    required this.success,
    this.error,
    this.errorCode,
  }) : super._();

  @override
  final TunnelData? tunnelData;
  @override
  final String? errorInfo;
  @override
  final bool success;
  @override
  final String? error;
  @override
  final int? errorCode;

  @override
  String toString() {
    return 'TunnelResponse(tunnelData: $tunnelData, errorInfo: $errorInfo, success: $success, error: $error, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TunnelResponseImpl &&
            (identical(other.tunnelData, tunnelData) ||
                other.tunnelData == tunnelData) &&
            (identical(other.errorInfo, errorInfo) ||
                other.errorInfo == errorInfo) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    tunnelData,
    errorInfo,
    success,
    error,
    errorCode,
  );

  /// Create a copy of TunnelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TunnelResponseImplCopyWith<_$TunnelResponseImpl> get copyWith =>
      __$$TunnelResponseImplCopyWithImpl<_$TunnelResponseImpl>(
        this,
        _$identity,
      );
}

abstract class _TunnelResponse extends TunnelResponse {
  const factory _TunnelResponse({
    final TunnelData? tunnelData,
    final String? errorInfo,
    required final bool success,
    final String? error,
    final int? errorCode,
  }) = _$TunnelResponseImpl;
  const _TunnelResponse._() : super._();

  @override
  TunnelData? get tunnelData;
  @override
  String? get errorInfo;
  @override
  bool get success;
  @override
  String? get error;
  @override
  int? get errorCode;

  /// Create a copy of TunnelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TunnelResponseImplCopyWith<_$TunnelResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TunnelData _$TunnelDataFromJson(Map<String, dynamic> json) {
  return _TunnelData.fromJson(json);
}

/// @nodoc
mixin _$TunnelData {
  RelayInfo? get relay => throw _privateConstructorUsedError;
  ExternalInfo? get external => throw _privateConstructorUsedError;

  /// Serializes this TunnelData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TunnelData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TunnelDataCopyWith<TunnelData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TunnelDataCopyWith<$Res> {
  factory $TunnelDataCopyWith(
    TunnelData value,
    $Res Function(TunnelData) then,
  ) = _$TunnelDataCopyWithImpl<$Res, TunnelData>;
  @useResult
  $Res call({RelayInfo? relay, ExternalInfo? external});

  $RelayInfoCopyWith<$Res>? get relay;
  $ExternalInfoCopyWith<$Res>? get external;
}

/// @nodoc
class _$TunnelDataCopyWithImpl<$Res, $Val extends TunnelData>
    implements $TunnelDataCopyWith<$Res> {
  _$TunnelDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TunnelData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? relay = freezed, Object? external = freezed}) {
    return _then(
      _value.copyWith(
            relay: freezed == relay
                ? _value.relay
                : relay // ignore: cast_nullable_to_non_nullable
                      as RelayInfo?,
            external: freezed == external
                ? _value.external
                : external // ignore: cast_nullable_to_non_nullable
                      as ExternalInfo?,
          )
          as $Val,
    );
  }

  /// Create a copy of TunnelData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RelayInfoCopyWith<$Res>? get relay {
    if (_value.relay == null) {
      return null;
    }

    return $RelayInfoCopyWith<$Res>(_value.relay!, (value) {
      return _then(_value.copyWith(relay: value) as $Val);
    });
  }

  /// Create a copy of TunnelData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExternalInfoCopyWith<$Res>? get external {
    if (_value.external == null) {
      return null;
    }

    return $ExternalInfoCopyWith<$Res>(_value.external!, (value) {
      return _then(_value.copyWith(external: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TunnelDataImplCopyWith<$Res>
    implements $TunnelDataCopyWith<$Res> {
  factory _$$TunnelDataImplCopyWith(
    _$TunnelDataImpl value,
    $Res Function(_$TunnelDataImpl) then,
  ) = __$$TunnelDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RelayInfo? relay, ExternalInfo? external});

  @override
  $RelayInfoCopyWith<$Res>? get relay;
  @override
  $ExternalInfoCopyWith<$Res>? get external;
}

/// @nodoc
class __$$TunnelDataImplCopyWithImpl<$Res>
    extends _$TunnelDataCopyWithImpl<$Res, _$TunnelDataImpl>
    implements _$$TunnelDataImplCopyWith<$Res> {
  __$$TunnelDataImplCopyWithImpl(
    _$TunnelDataImpl _value,
    $Res Function(_$TunnelDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TunnelData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? relay = freezed, Object? external = freezed}) {
    return _then(
      _$TunnelDataImpl(
        relay: freezed == relay
            ? _value.relay
            : relay // ignore: cast_nullable_to_non_nullable
                  as RelayInfo?,
        external: freezed == external
            ? _value.external
            : external // ignore: cast_nullable_to_non_nullable
                  as ExternalInfo?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TunnelDataImpl extends _TunnelData {
  const _$TunnelDataImpl({this.relay, this.external}) : super._();

  factory _$TunnelDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TunnelDataImplFromJson(json);

  @override
  final RelayInfo? relay;
  @override
  final ExternalInfo? external;

  @override
  String toString() {
    return 'TunnelData(relay: $relay, external: $external)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TunnelDataImpl &&
            (identical(other.relay, relay) || other.relay == relay) &&
            (identical(other.external, external) ||
                other.external == external));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, relay, external);

  /// Create a copy of TunnelData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TunnelDataImplCopyWith<_$TunnelDataImpl> get copyWith =>
      __$$TunnelDataImplCopyWithImpl<_$TunnelDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TunnelDataImplToJson(this);
  }
}

abstract class _TunnelData extends TunnelData {
  const factory _TunnelData({
    final RelayInfo? relay,
    final ExternalInfo? external,
  }) = _$TunnelDataImpl;
  const _TunnelData._() : super._();

  factory _TunnelData.fromJson(Map<String, dynamic> json) =
      _$TunnelDataImpl.fromJson;

  @override
  RelayInfo? get relay;
  @override
  ExternalInfo? get external;

  /// Create a copy of TunnelData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TunnelDataImplCopyWith<_$TunnelDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RelayInfo _$RelayInfoFromJson(Map<String, dynamic> json) {
  return _RelayInfo.fromJson(json);
}

/// @nodoc
mixin _$RelayInfo {
  String? get fqdn => throw _privateConstructorUsedError;
  String? get ip => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;

  /// Serializes this RelayInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RelayInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RelayInfoCopyWith<RelayInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelayInfoCopyWith<$Res> {
  factory $RelayInfoCopyWith(RelayInfo value, $Res Function(RelayInfo) then) =
      _$RelayInfoCopyWithImpl<$Res, RelayInfo>;
  @useResult
  $Res call({String? fqdn, String? ip, int? port});
}

/// @nodoc
class _$RelayInfoCopyWithImpl<$Res, $Val extends RelayInfo>
    implements $RelayInfoCopyWith<$Res> {
  _$RelayInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RelayInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fqdn = freezed,
    Object? ip = freezed,
    Object? port = freezed,
  }) {
    return _then(
      _value.copyWith(
            fqdn: freezed == fqdn
                ? _value.fqdn
                : fqdn // ignore: cast_nullable_to_non_nullable
                      as String?,
            ip: freezed == ip
                ? _value.ip
                : ip // ignore: cast_nullable_to_non_nullable
                      as String?,
            port: freezed == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RelayInfoImplCopyWith<$Res>
    implements $RelayInfoCopyWith<$Res> {
  factory _$$RelayInfoImplCopyWith(
    _$RelayInfoImpl value,
    $Res Function(_$RelayInfoImpl) then,
  ) = __$$RelayInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? fqdn, String? ip, int? port});
}

/// @nodoc
class __$$RelayInfoImplCopyWithImpl<$Res>
    extends _$RelayInfoCopyWithImpl<$Res, _$RelayInfoImpl>
    implements _$$RelayInfoImplCopyWith<$Res> {
  __$$RelayInfoImplCopyWithImpl(
    _$RelayInfoImpl _value,
    $Res Function(_$RelayInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RelayInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fqdn = freezed,
    Object? ip = freezed,
    Object? port = freezed,
  }) {
    return _then(
      _$RelayInfoImpl(
        fqdn: freezed == fqdn
            ? _value.fqdn
            : fqdn // ignore: cast_nullable_to_non_nullable
                  as String?,
        ip: freezed == ip
            ? _value.ip
            : ip // ignore: cast_nullable_to_non_nullable
                  as String?,
        port: freezed == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RelayInfoImpl extends _RelayInfo {
  const _$RelayInfoImpl({this.fqdn, this.ip, this.port}) : super._();

  factory _$RelayInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelayInfoImplFromJson(json);

  @override
  final String? fqdn;
  @override
  final String? ip;
  @override
  final int? port;

  @override
  String toString() {
    return 'RelayInfo(fqdn: $fqdn, ip: $ip, port: $port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelayInfoImpl &&
            (identical(other.fqdn, fqdn) || other.fqdn == fqdn) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fqdn, ip, port);

  /// Create a copy of RelayInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RelayInfoImplCopyWith<_$RelayInfoImpl> get copyWith =>
      __$$RelayInfoImplCopyWithImpl<_$RelayInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RelayInfoImplToJson(this);
  }
}

abstract class _RelayInfo extends RelayInfo {
  const factory _RelayInfo({
    final String? fqdn,
    final String? ip,
    final int? port,
  }) = _$RelayInfoImpl;
  const _RelayInfo._() : super._();

  factory _RelayInfo.fromJson(Map<String, dynamic> json) =
      _$RelayInfoImpl.fromJson;

  @override
  String? get fqdn;
  @override
  String? get ip;
  @override
  int? get port;

  /// Create a copy of RelayInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RelayInfoImplCopyWith<_$RelayInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExternalInfo _$ExternalInfoFromJson(Map<String, dynamic> json) {
  return _ExternalInfo.fromJson(json);
}

/// @nodoc
mixin _$ExternalInfo {
  String? get fqdn => throw _privateConstructorUsedError;
  String? get ip => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;

  /// Serializes this ExternalInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExternalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalInfoCopyWith<ExternalInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalInfoCopyWith<$Res> {
  factory $ExternalInfoCopyWith(
    ExternalInfo value,
    $Res Function(ExternalInfo) then,
  ) = _$ExternalInfoCopyWithImpl<$Res, ExternalInfo>;
  @useResult
  $Res call({String? fqdn, String? ip, int? port});
}

/// @nodoc
class _$ExternalInfoCopyWithImpl<$Res, $Val extends ExternalInfo>
    implements $ExternalInfoCopyWith<$Res> {
  _$ExternalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fqdn = freezed,
    Object? ip = freezed,
    Object? port = freezed,
  }) {
    return _then(
      _value.copyWith(
            fqdn: freezed == fqdn
                ? _value.fqdn
                : fqdn // ignore: cast_nullable_to_non_nullable
                      as String?,
            ip: freezed == ip
                ? _value.ip
                : ip // ignore: cast_nullable_to_non_nullable
                      as String?,
            port: freezed == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExternalInfoImplCopyWith<$Res>
    implements $ExternalInfoCopyWith<$Res> {
  factory _$$ExternalInfoImplCopyWith(
    _$ExternalInfoImpl value,
    $Res Function(_$ExternalInfoImpl) then,
  ) = __$$ExternalInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? fqdn, String? ip, int? port});
}

/// @nodoc
class __$$ExternalInfoImplCopyWithImpl<$Res>
    extends _$ExternalInfoCopyWithImpl<$Res, _$ExternalInfoImpl>
    implements _$$ExternalInfoImplCopyWith<$Res> {
  __$$ExternalInfoImplCopyWithImpl(
    _$ExternalInfoImpl _value,
    $Res Function(_$ExternalInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExternalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fqdn = freezed,
    Object? ip = freezed,
    Object? port = freezed,
  }) {
    return _then(
      _$ExternalInfoImpl(
        fqdn: freezed == fqdn
            ? _value.fqdn
            : fqdn // ignore: cast_nullable_to_non_nullable
                  as String?,
        ip: freezed == ip
            ? _value.ip
            : ip // ignore: cast_nullable_to_non_nullable
                  as String?,
        port: freezed == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExternalInfoImpl extends _ExternalInfo {
  const _$ExternalInfoImpl({this.fqdn, this.ip, this.port}) : super._();

  factory _$ExternalInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalInfoImplFromJson(json);

  @override
  final String? fqdn;
  @override
  final String? ip;
  @override
  final int? port;

  @override
  String toString() {
    return 'ExternalInfo(fqdn: $fqdn, ip: $ip, port: $port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalInfoImpl &&
            (identical(other.fqdn, fqdn) || other.fqdn == fqdn) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fqdn, ip, port);

  /// Create a copy of ExternalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalInfoImplCopyWith<_$ExternalInfoImpl> get copyWith =>
      __$$ExternalInfoImplCopyWithImpl<_$ExternalInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalInfoImplToJson(this);
  }
}

abstract class _ExternalInfo extends ExternalInfo {
  const factory _ExternalInfo({
    final String? fqdn,
    final String? ip,
    final int? port,
  }) = _$ExternalInfoImpl;
  const _ExternalInfo._() : super._();

  factory _ExternalInfo.fromJson(Map<String, dynamic> json) =
      _$ExternalInfoImpl.fromJson;

  @override
  String? get fqdn;
  @override
  String? get ip;
  @override
  int? get port;

  /// Create a copy of ExternalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalInfoImplCopyWith<_$ExternalInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ServerInfoResponse {
  ServerInfo? get serverInfo => throw _privateConstructorUsedError;
  List<String>? get sites => throw _privateConstructorUsedError;
  SmartDnsInfo? get smartDns => throw _privateConstructorUsedError;
  ServiceInfo? get service => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;

  /// Create a copy of ServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerInfoResponseCopyWith<ServerInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerInfoResponseCopyWith<$Res> {
  factory $ServerInfoResponseCopyWith(
    ServerInfoResponse value,
    $Res Function(ServerInfoResponse) then,
  ) = _$ServerInfoResponseCopyWithImpl<$Res, ServerInfoResponse>;
  @useResult
  $Res call({
    ServerInfo? serverInfo,
    List<String>? sites,
    SmartDnsInfo? smartDns,
    ServiceInfo? service,
    bool success,
    String? error,
    int? errorCode,
  });

  $ServerInfoCopyWith<$Res>? get serverInfo;
  $SmartDnsInfoCopyWith<$Res>? get smartDns;
  $ServiceInfoCopyWith<$Res>? get service;
}

/// @nodoc
class _$ServerInfoResponseCopyWithImpl<$Res, $Val extends ServerInfoResponse>
    implements $ServerInfoResponseCopyWith<$Res> {
  _$ServerInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverInfo = freezed,
    Object? sites = freezed,
    Object? smartDns = freezed,
    Object? service = freezed,
    Object? success = null,
    Object? error = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            serverInfo: freezed == serverInfo
                ? _value.serverInfo
                : serverInfo // ignore: cast_nullable_to_non_nullable
                      as ServerInfo?,
            sites: freezed == sites
                ? _value.sites
                : sites // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            smartDns: freezed == smartDns
                ? _value.smartDns
                : smartDns // ignore: cast_nullable_to_non_nullable
                      as SmartDnsInfo?,
            service: freezed == service
                ? _value.service
                : service // ignore: cast_nullable_to_non_nullable
                      as ServiceInfo?,
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of ServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServerInfoCopyWith<$Res>? get serverInfo {
    if (_value.serverInfo == null) {
      return null;
    }

    return $ServerInfoCopyWith<$Res>(_value.serverInfo!, (value) {
      return _then(_value.copyWith(serverInfo: value) as $Val);
    });
  }

  /// Create a copy of ServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SmartDnsInfoCopyWith<$Res>? get smartDns {
    if (_value.smartDns == null) {
      return null;
    }

    return $SmartDnsInfoCopyWith<$Res>(_value.smartDns!, (value) {
      return _then(_value.copyWith(smartDns: value) as $Val);
    });
  }

  /// Create a copy of ServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceInfoCopyWith<$Res>? get service {
    if (_value.service == null) {
      return null;
    }

    return $ServiceInfoCopyWith<$Res>(_value.service!, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServerInfoResponseImplCopyWith<$Res>
    implements $ServerInfoResponseCopyWith<$Res> {
  factory _$$ServerInfoResponseImplCopyWith(
    _$ServerInfoResponseImpl value,
    $Res Function(_$ServerInfoResponseImpl) then,
  ) = __$$ServerInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ServerInfo? serverInfo,
    List<String>? sites,
    SmartDnsInfo? smartDns,
    ServiceInfo? service,
    bool success,
    String? error,
    int? errorCode,
  });

  @override
  $ServerInfoCopyWith<$Res>? get serverInfo;
  @override
  $SmartDnsInfoCopyWith<$Res>? get smartDns;
  @override
  $ServiceInfoCopyWith<$Res>? get service;
}

/// @nodoc
class __$$ServerInfoResponseImplCopyWithImpl<$Res>
    extends _$ServerInfoResponseCopyWithImpl<$Res, _$ServerInfoResponseImpl>
    implements _$$ServerInfoResponseImplCopyWith<$Res> {
  __$$ServerInfoResponseImplCopyWithImpl(
    _$ServerInfoResponseImpl _value,
    $Res Function(_$ServerInfoResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverInfo = freezed,
    Object? sites = freezed,
    Object? smartDns = freezed,
    Object? service = freezed,
    Object? success = null,
    Object? error = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(
      _$ServerInfoResponseImpl(
        serverInfo: freezed == serverInfo
            ? _value.serverInfo
            : serverInfo // ignore: cast_nullable_to_non_nullable
                  as ServerInfo?,
        sites: freezed == sites
            ? _value._sites
            : sites // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        smartDns: freezed == smartDns
            ? _value.smartDns
            : smartDns // ignore: cast_nullable_to_non_nullable
                  as SmartDnsInfo?,
        service: freezed == service
            ? _value.service
            : service // ignore: cast_nullable_to_non_nullable
                  as ServiceInfo?,
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$ServerInfoResponseImpl extends _ServerInfoResponse {
  const _$ServerInfoResponseImpl({
    this.serverInfo,
    final List<String>? sites,
    this.smartDns,
    this.service,
    required this.success,
    this.error,
    this.errorCode,
  }) : _sites = sites,
       super._();

  @override
  final ServerInfo? serverInfo;
  final List<String>? _sites;
  @override
  List<String>? get sites {
    final value = _sites;
    if (value == null) return null;
    if (_sites is EqualUnmodifiableListView) return _sites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final SmartDnsInfo? smartDns;
  @override
  final ServiceInfo? service;
  @override
  final bool success;
  @override
  final String? error;
  @override
  final int? errorCode;

  @override
  String toString() {
    return 'ServerInfoResponse(serverInfo: $serverInfo, sites: $sites, smartDns: $smartDns, service: $service, success: $success, error: $error, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerInfoResponseImpl &&
            (identical(other.serverInfo, serverInfo) ||
                other.serverInfo == serverInfo) &&
            const DeepCollectionEquality().equals(other._sites, _sites) &&
            (identical(other.smartDns, smartDns) ||
                other.smartDns == smartDns) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    serverInfo,
    const DeepCollectionEquality().hash(_sites),
    smartDns,
    service,
    success,
    error,
    errorCode,
  );

  /// Create a copy of ServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerInfoResponseImplCopyWith<_$ServerInfoResponseImpl> get copyWith =>
      __$$ServerInfoResponseImplCopyWithImpl<_$ServerInfoResponseImpl>(
        this,
        _$identity,
      );
}

abstract class _ServerInfoResponse extends ServerInfoResponse {
  const factory _ServerInfoResponse({
    final ServerInfo? serverInfo,
    final List<String>? sites,
    final SmartDnsInfo? smartDns,
    final ServiceInfo? service,
    required final bool success,
    final String? error,
    final int? errorCode,
  }) = _$ServerInfoResponseImpl;
  const _ServerInfoResponse._() : super._();

  @override
  ServerInfo? get serverInfo;
  @override
  List<String>? get sites;
  @override
  SmartDnsInfo? get smartDns;
  @override
  ServiceInfo? get service;
  @override
  bool get success;
  @override
  String? get error;
  @override
  int? get errorCode;

  /// Create a copy of ServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerInfoResponseImplCopyWith<_$ServerInfoResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuickConnectServerInfoResponse {
  String get command => throw _privateConstructorUsedError;
  String? get errinfo => throw _privateConstructorUsedError;
  int? get errno => throw _privateConstructorUsedError;
  List<String>? get sites => throw _privateConstructorUsedError;
  int? get suberrno => throw _privateConstructorUsedError;
  int? get version => throw _privateConstructorUsedError;
  bool? get getCaFingerprints => throw _privateConstructorUsedError;
  ServerInfo? get server => throw _privateConstructorUsedError;
  SmartDnsInfo? get smartdns => throw _privateConstructorUsedError;
  ServiceInfo? get service => throw _privateConstructorUsedError;

  /// Create a copy of QuickConnectServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickConnectServerInfoResponseCopyWith<QuickConnectServerInfoResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickConnectServerInfoResponseCopyWith<$Res> {
  factory $QuickConnectServerInfoResponseCopyWith(
    QuickConnectServerInfoResponse value,
    $Res Function(QuickConnectServerInfoResponse) then,
  ) =
      _$QuickConnectServerInfoResponseCopyWithImpl<
        $Res,
        QuickConnectServerInfoResponse
      >;
  @useResult
  $Res call({
    String command,
    String? errinfo,
    int? errno,
    List<String>? sites,
    int? suberrno,
    int? version,
    bool? getCaFingerprints,
    ServerInfo? server,
    SmartDnsInfo? smartdns,
    ServiceInfo? service,
  });

  $ServerInfoCopyWith<$Res>? get server;
  $SmartDnsInfoCopyWith<$Res>? get smartdns;
  $ServiceInfoCopyWith<$Res>? get service;
}

/// @nodoc
class _$QuickConnectServerInfoResponseCopyWithImpl<
  $Res,
  $Val extends QuickConnectServerInfoResponse
>
    implements $QuickConnectServerInfoResponseCopyWith<$Res> {
  _$QuickConnectServerInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickConnectServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? errinfo = freezed,
    Object? errno = freezed,
    Object? sites = freezed,
    Object? suberrno = freezed,
    Object? version = freezed,
    Object? getCaFingerprints = freezed,
    Object? server = freezed,
    Object? smartdns = freezed,
    Object? service = freezed,
  }) {
    return _then(
      _value.copyWith(
            command: null == command
                ? _value.command
                : command // ignore: cast_nullable_to_non_nullable
                      as String,
            errinfo: freezed == errinfo
                ? _value.errinfo
                : errinfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            errno: freezed == errno
                ? _value.errno
                : errno // ignore: cast_nullable_to_non_nullable
                      as int?,
            sites: freezed == sites
                ? _value.sites
                : sites // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            suberrno: freezed == suberrno
                ? _value.suberrno
                : suberrno // ignore: cast_nullable_to_non_nullable
                      as int?,
            version: freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int?,
            getCaFingerprints: freezed == getCaFingerprints
                ? _value.getCaFingerprints
                : getCaFingerprints // ignore: cast_nullable_to_non_nullable
                      as bool?,
            server: freezed == server
                ? _value.server
                : server // ignore: cast_nullable_to_non_nullable
                      as ServerInfo?,
            smartdns: freezed == smartdns
                ? _value.smartdns
                : smartdns // ignore: cast_nullable_to_non_nullable
                      as SmartDnsInfo?,
            service: freezed == service
                ? _value.service
                : service // ignore: cast_nullable_to_non_nullable
                      as ServiceInfo?,
          )
          as $Val,
    );
  }

  /// Create a copy of QuickConnectServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServerInfoCopyWith<$Res>? get server {
    if (_value.server == null) {
      return null;
    }

    return $ServerInfoCopyWith<$Res>(_value.server!, (value) {
      return _then(_value.copyWith(server: value) as $Val);
    });
  }

  /// Create a copy of QuickConnectServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SmartDnsInfoCopyWith<$Res>? get smartdns {
    if (_value.smartdns == null) {
      return null;
    }

    return $SmartDnsInfoCopyWith<$Res>(_value.smartdns!, (value) {
      return _then(_value.copyWith(smartdns: value) as $Val);
    });
  }

  /// Create a copy of QuickConnectServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceInfoCopyWith<$Res>? get service {
    if (_value.service == null) {
      return null;
    }

    return $ServiceInfoCopyWith<$Res>(_value.service!, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuickConnectServerInfoResponseImplCopyWith<$Res>
    implements $QuickConnectServerInfoResponseCopyWith<$Res> {
  factory _$$QuickConnectServerInfoResponseImplCopyWith(
    _$QuickConnectServerInfoResponseImpl value,
    $Res Function(_$QuickConnectServerInfoResponseImpl) then,
  ) = __$$QuickConnectServerInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String command,
    String? errinfo,
    int? errno,
    List<String>? sites,
    int? suberrno,
    int? version,
    bool? getCaFingerprints,
    ServerInfo? server,
    SmartDnsInfo? smartdns,
    ServiceInfo? service,
  });

  @override
  $ServerInfoCopyWith<$Res>? get server;
  @override
  $SmartDnsInfoCopyWith<$Res>? get smartdns;
  @override
  $ServiceInfoCopyWith<$Res>? get service;
}

/// @nodoc
class __$$QuickConnectServerInfoResponseImplCopyWithImpl<$Res>
    extends
        _$QuickConnectServerInfoResponseCopyWithImpl<
          $Res,
          _$QuickConnectServerInfoResponseImpl
        >
    implements _$$QuickConnectServerInfoResponseImplCopyWith<$Res> {
  __$$QuickConnectServerInfoResponseImplCopyWithImpl(
    _$QuickConnectServerInfoResponseImpl _value,
    $Res Function(_$QuickConnectServerInfoResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuickConnectServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? errinfo = freezed,
    Object? errno = freezed,
    Object? sites = freezed,
    Object? suberrno = freezed,
    Object? version = freezed,
    Object? getCaFingerprints = freezed,
    Object? server = freezed,
    Object? smartdns = freezed,
    Object? service = freezed,
  }) {
    return _then(
      _$QuickConnectServerInfoResponseImpl(
        command: null == command
            ? _value.command
            : command // ignore: cast_nullable_to_non_nullable
                  as String,
        errinfo: freezed == errinfo
            ? _value.errinfo
            : errinfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        errno: freezed == errno
            ? _value.errno
            : errno // ignore: cast_nullable_to_non_nullable
                  as int?,
        sites: freezed == sites
            ? _value._sites
            : sites // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        suberrno: freezed == suberrno
            ? _value.suberrno
            : suberrno // ignore: cast_nullable_to_non_nullable
                  as int?,
        version: freezed == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int?,
        getCaFingerprints: freezed == getCaFingerprints
            ? _value.getCaFingerprints
            : getCaFingerprints // ignore: cast_nullable_to_non_nullable
                  as bool?,
        server: freezed == server
            ? _value.server
            : server // ignore: cast_nullable_to_non_nullable
                  as ServerInfo?,
        smartdns: freezed == smartdns
            ? _value.smartdns
            : smartdns // ignore: cast_nullable_to_non_nullable
                  as SmartDnsInfo?,
        service: freezed == service
            ? _value.service
            : service // ignore: cast_nullable_to_non_nullable
                  as ServiceInfo?,
      ),
    );
  }
}

/// @nodoc

class _$QuickConnectServerInfoResponseImpl
    extends _QuickConnectServerInfoResponse {
  const _$QuickConnectServerInfoResponseImpl({
    required this.command,
    this.errinfo,
    this.errno,
    final List<String>? sites,
    this.suberrno,
    this.version,
    this.getCaFingerprints,
    this.server,
    this.smartdns,
    this.service,
  }) : _sites = sites,
       super._();

  @override
  final String command;
  @override
  final String? errinfo;
  @override
  final int? errno;
  final List<String>? _sites;
  @override
  List<String>? get sites {
    final value = _sites;
    if (value == null) return null;
    if (_sites is EqualUnmodifiableListView) return _sites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? suberrno;
  @override
  final int? version;
  @override
  final bool? getCaFingerprints;
  @override
  final ServerInfo? server;
  @override
  final SmartDnsInfo? smartdns;
  @override
  final ServiceInfo? service;

  @override
  String toString() {
    return 'QuickConnectServerInfoResponse(command: $command, errinfo: $errinfo, errno: $errno, sites: $sites, suberrno: $suberrno, version: $version, getCaFingerprints: $getCaFingerprints, server: $server, smartdns: $smartdns, service: $service)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectServerInfoResponseImpl &&
            (identical(other.command, command) || other.command == command) &&
            (identical(other.errinfo, errinfo) || other.errinfo == errinfo) &&
            (identical(other.errno, errno) || other.errno == errno) &&
            const DeepCollectionEquality().equals(other._sites, _sites) &&
            (identical(other.suberrno, suberrno) ||
                other.suberrno == suberrno) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.getCaFingerprints, getCaFingerprints) ||
                other.getCaFingerprints == getCaFingerprints) &&
            (identical(other.server, server) || other.server == server) &&
            (identical(other.smartdns, smartdns) ||
                other.smartdns == smartdns) &&
            (identical(other.service, service) || other.service == service));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    command,
    errinfo,
    errno,
    const DeepCollectionEquality().hash(_sites),
    suberrno,
    version,
    getCaFingerprints,
    server,
    smartdns,
    service,
  );

  /// Create a copy of QuickConnectServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickConnectServerInfoResponseImplCopyWith<
    _$QuickConnectServerInfoResponseImpl
  >
  get copyWith =>
      __$$QuickConnectServerInfoResponseImplCopyWithImpl<
        _$QuickConnectServerInfoResponseImpl
      >(this, _$identity);
}

abstract class _QuickConnectServerInfoResponse
    extends QuickConnectServerInfoResponse {
  const factory _QuickConnectServerInfoResponse({
    required final String command,
    final String? errinfo,
    final int? errno,
    final List<String>? sites,
    final int? suberrno,
    final int? version,
    final bool? getCaFingerprints,
    final ServerInfo? server,
    final SmartDnsInfo? smartdns,
    final ServiceInfo? service,
  }) = _$QuickConnectServerInfoResponseImpl;
  const _QuickConnectServerInfoResponse._() : super._();

  @override
  String get command;
  @override
  String? get errinfo;
  @override
  int? get errno;
  @override
  List<String>? get sites;
  @override
  int? get suberrno;
  @override
  int? get version;
  @override
  bool? get getCaFingerprints;
  @override
  ServerInfo? get server;
  @override
  SmartDnsInfo? get smartdns;
  @override
  ServiceInfo? get service;

  /// Create a copy of QuickConnectServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectServerInfoResponseImplCopyWith<
    _$QuickConnectServerInfoResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ServerInfo {
  ExternalServerInfo? get external => throw _privateConstructorUsedError;
  List<InterfaceInfo>? get interfaces => throw _privateConstructorUsedError;

  /// Create a copy of ServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerInfoCopyWith<ServerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerInfoCopyWith<$Res> {
  factory $ServerInfoCopyWith(
    ServerInfo value,
    $Res Function(ServerInfo) then,
  ) = _$ServerInfoCopyWithImpl<$Res, ServerInfo>;
  @useResult
  $Res call({ExternalServerInfo? external, List<InterfaceInfo>? interfaces});

  $ExternalServerInfoCopyWith<$Res>? get external;
}

/// @nodoc
class _$ServerInfoCopyWithImpl<$Res, $Val extends ServerInfo>
    implements $ServerInfoCopyWith<$Res> {
  _$ServerInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? external = freezed, Object? interfaces = freezed}) {
    return _then(
      _value.copyWith(
            external: freezed == external
                ? _value.external
                : external // ignore: cast_nullable_to_non_nullable
                      as ExternalServerInfo?,
            interfaces: freezed == interfaces
                ? _value.interfaces
                : interfaces // ignore: cast_nullable_to_non_nullable
                      as List<InterfaceInfo>?,
          )
          as $Val,
    );
  }

  /// Create a copy of ServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExternalServerInfoCopyWith<$Res>? get external {
    if (_value.external == null) {
      return null;
    }

    return $ExternalServerInfoCopyWith<$Res>(_value.external!, (value) {
      return _then(_value.copyWith(external: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServerInfoImplCopyWith<$Res>
    implements $ServerInfoCopyWith<$Res> {
  factory _$$ServerInfoImplCopyWith(
    _$ServerInfoImpl value,
    $Res Function(_$ServerInfoImpl) then,
  ) = __$$ServerInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ExternalServerInfo? external, List<InterfaceInfo>? interfaces});

  @override
  $ExternalServerInfoCopyWith<$Res>? get external;
}

/// @nodoc
class __$$ServerInfoImplCopyWithImpl<$Res>
    extends _$ServerInfoCopyWithImpl<$Res, _$ServerInfoImpl>
    implements _$$ServerInfoImplCopyWith<$Res> {
  __$$ServerInfoImplCopyWithImpl(
    _$ServerInfoImpl _value,
    $Res Function(_$ServerInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? external = freezed, Object? interfaces = freezed}) {
    return _then(
      _$ServerInfoImpl(
        external: freezed == external
            ? _value.external
            : external // ignore: cast_nullable_to_non_nullable
                  as ExternalServerInfo?,
        interfaces: freezed == interfaces
            ? _value._interfaces
            : interfaces // ignore: cast_nullable_to_non_nullable
                  as List<InterfaceInfo>?,
      ),
    );
  }
}

/// @nodoc

class _$ServerInfoImpl extends _ServerInfo {
  const _$ServerInfoImpl({this.external, final List<InterfaceInfo>? interfaces})
    : _interfaces = interfaces,
      super._();

  @override
  final ExternalServerInfo? external;
  final List<InterfaceInfo>? _interfaces;
  @override
  List<InterfaceInfo>? get interfaces {
    final value = _interfaces;
    if (value == null) return null;
    if (_interfaces is EqualUnmodifiableListView) return _interfaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ServerInfo(external: $external, interfaces: $interfaces)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerInfoImpl &&
            (identical(other.external, external) ||
                other.external == external) &&
            const DeepCollectionEquality().equals(
              other._interfaces,
              _interfaces,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    external,
    const DeepCollectionEquality().hash(_interfaces),
  );

  /// Create a copy of ServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerInfoImplCopyWith<_$ServerInfoImpl> get copyWith =>
      __$$ServerInfoImplCopyWithImpl<_$ServerInfoImpl>(this, _$identity);
}

abstract class _ServerInfo extends ServerInfo {
  const factory _ServerInfo({
    final ExternalServerInfo? external,
    final List<InterfaceInfo>? interfaces,
  }) = _$ServerInfoImpl;
  const _ServerInfo._() : super._();

  @override
  ExternalServerInfo? get external;
  @override
  List<InterfaceInfo>? get interfaces;

  /// Create a copy of ServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerInfoImplCopyWith<_$ServerInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExternalServerInfo _$ExternalServerInfoFromJson(Map<String, dynamic> json) {
  return _ExternalServerInfo.fromJson(json);
}

/// @nodoc
mixin _$ExternalServerInfo {
  String? get ip => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;

  /// Serializes this ExternalServerInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExternalServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalServerInfoCopyWith<ExternalServerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalServerInfoCopyWith<$Res> {
  factory $ExternalServerInfoCopyWith(
    ExternalServerInfo value,
    $Res Function(ExternalServerInfo) then,
  ) = _$ExternalServerInfoCopyWithImpl<$Res, ExternalServerInfo>;
  @useResult
  $Res call({String? ip, int? port});
}

/// @nodoc
class _$ExternalServerInfoCopyWithImpl<$Res, $Val extends ExternalServerInfo>
    implements $ExternalServerInfoCopyWith<$Res> {
  _$ExternalServerInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ip = freezed, Object? port = freezed}) {
    return _then(
      _value.copyWith(
            ip: freezed == ip
                ? _value.ip
                : ip // ignore: cast_nullable_to_non_nullable
                      as String?,
            port: freezed == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExternalServerInfoImplCopyWith<$Res>
    implements $ExternalServerInfoCopyWith<$Res> {
  factory _$$ExternalServerInfoImplCopyWith(
    _$ExternalServerInfoImpl value,
    $Res Function(_$ExternalServerInfoImpl) then,
  ) = __$$ExternalServerInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? ip, int? port});
}

/// @nodoc
class __$$ExternalServerInfoImplCopyWithImpl<$Res>
    extends _$ExternalServerInfoCopyWithImpl<$Res, _$ExternalServerInfoImpl>
    implements _$$ExternalServerInfoImplCopyWith<$Res> {
  __$$ExternalServerInfoImplCopyWithImpl(
    _$ExternalServerInfoImpl _value,
    $Res Function(_$ExternalServerInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExternalServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ip = freezed, Object? port = freezed}) {
    return _then(
      _$ExternalServerInfoImpl(
        ip: freezed == ip
            ? _value.ip
            : ip // ignore: cast_nullable_to_non_nullable
                  as String?,
        port: freezed == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExternalServerInfoImpl extends _ExternalServerInfo {
  const _$ExternalServerInfoImpl({this.ip, this.port}) : super._();

  factory _$ExternalServerInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalServerInfoImplFromJson(json);

  @override
  final String? ip;
  @override
  final int? port;

  @override
  String toString() {
    return 'ExternalServerInfo(ip: $ip, port: $port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalServerInfoImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ip, port);

  /// Create a copy of ExternalServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalServerInfoImplCopyWith<_$ExternalServerInfoImpl> get copyWith =>
      __$$ExternalServerInfoImplCopyWithImpl<_$ExternalServerInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalServerInfoImplToJson(this);
  }
}

abstract class _ExternalServerInfo extends ExternalServerInfo {
  const factory _ExternalServerInfo({final String? ip, final int? port}) =
      _$ExternalServerInfoImpl;
  const _ExternalServerInfo._() : super._();

  factory _ExternalServerInfo.fromJson(Map<String, dynamic> json) =
      _$ExternalServerInfoImpl.fromJson;

  @override
  String? get ip;
  @override
  int? get port;

  /// Create a copy of ExternalServerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalServerInfoImplCopyWith<_$ExternalServerInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InterfaceInfo _$InterfaceInfoFromJson(Map<String, dynamic> json) {
  return _InterfaceInfo.fromJson(json);
}

/// @nodoc
mixin _$InterfaceInfo {
  String? get ip => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  /// Serializes this InterfaceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InterfaceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterfaceInfoCopyWith<InterfaceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterfaceInfoCopyWith<$Res> {
  factory $InterfaceInfoCopyWith(
    InterfaceInfo value,
    $Res Function(InterfaceInfo) then,
  ) = _$InterfaceInfoCopyWithImpl<$Res, InterfaceInfo>;
  @useResult
  $Res call({String? ip, String? name, String? type});
}

/// @nodoc
class _$InterfaceInfoCopyWithImpl<$Res, $Val extends InterfaceInfo>
    implements $InterfaceInfoCopyWith<$Res> {
  _$InterfaceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterfaceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? name = freezed,
    Object? type = freezed,
  }) {
    return _then(
      _value.copyWith(
            ip: freezed == ip
                ? _value.ip
                : ip // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InterfaceInfoImplCopyWith<$Res>
    implements $InterfaceInfoCopyWith<$Res> {
  factory _$$InterfaceInfoImplCopyWith(
    _$InterfaceInfoImpl value,
    $Res Function(_$InterfaceInfoImpl) then,
  ) = __$$InterfaceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? ip, String? name, String? type});
}

/// @nodoc
class __$$InterfaceInfoImplCopyWithImpl<$Res>
    extends _$InterfaceInfoCopyWithImpl<$Res, _$InterfaceInfoImpl>
    implements _$$InterfaceInfoImplCopyWith<$Res> {
  __$$InterfaceInfoImplCopyWithImpl(
    _$InterfaceInfoImpl _value,
    $Res Function(_$InterfaceInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InterfaceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? name = freezed,
    Object? type = freezed,
  }) {
    return _then(
      _$InterfaceInfoImpl(
        ip: freezed == ip
            ? _value.ip
            : ip // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InterfaceInfoImpl extends _InterfaceInfo {
  const _$InterfaceInfoImpl({this.ip, this.name, this.type}) : super._();

  factory _$InterfaceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterfaceInfoImplFromJson(json);

  @override
  final String? ip;
  @override
  final String? name;
  @override
  final String? type;

  @override
  String toString() {
    return 'InterfaceInfo(ip: $ip, name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterfaceInfoImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ip, name, type);

  /// Create a copy of InterfaceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterfaceInfoImplCopyWith<_$InterfaceInfoImpl> get copyWith =>
      __$$InterfaceInfoImplCopyWithImpl<_$InterfaceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterfaceInfoImplToJson(this);
  }
}

abstract class _InterfaceInfo extends InterfaceInfo {
  const factory _InterfaceInfo({
    final String? ip,
    final String? name,
    final String? type,
  }) = _$InterfaceInfoImpl;
  const _InterfaceInfo._() : super._();

  factory _InterfaceInfo.fromJson(Map<String, dynamic> json) =
      _$InterfaceInfoImpl.fromJson;

  @override
  String? get ip;
  @override
  String? get name;
  @override
  String? get type;

  /// Create a copy of InterfaceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterfaceInfoImplCopyWith<_$InterfaceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmartDnsInfo _$SmartDnsInfoFromJson(Map<String, dynamic> json) {
  return _SmartDnsInfo.fromJson(json);
}

/// @nodoc
mixin _$SmartDnsInfo {
  String? get host => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;

  /// Serializes this SmartDnsInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmartDnsInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmartDnsInfoCopyWith<SmartDnsInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartDnsInfoCopyWith<$Res> {
  factory $SmartDnsInfoCopyWith(
    SmartDnsInfo value,
    $Res Function(SmartDnsInfo) then,
  ) = _$SmartDnsInfoCopyWithImpl<$Res, SmartDnsInfo>;
  @useResult
  $Res call({String? host, int? port});
}

/// @nodoc
class _$SmartDnsInfoCopyWithImpl<$Res, $Val extends SmartDnsInfo>
    implements $SmartDnsInfoCopyWith<$Res> {
  _$SmartDnsInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmartDnsInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? host = freezed, Object? port = freezed}) {
    return _then(
      _value.copyWith(
            host: freezed == host
                ? _value.host
                : host // ignore: cast_nullable_to_non_nullable
                      as String?,
            port: freezed == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmartDnsInfoImplCopyWith<$Res>
    implements $SmartDnsInfoCopyWith<$Res> {
  factory _$$SmartDnsInfoImplCopyWith(
    _$SmartDnsInfoImpl value,
    $Res Function(_$SmartDnsInfoImpl) then,
  ) = __$$SmartDnsInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? host, int? port});
}

/// @nodoc
class __$$SmartDnsInfoImplCopyWithImpl<$Res>
    extends _$SmartDnsInfoCopyWithImpl<$Res, _$SmartDnsInfoImpl>
    implements _$$SmartDnsInfoImplCopyWith<$Res> {
  __$$SmartDnsInfoImplCopyWithImpl(
    _$SmartDnsInfoImpl _value,
    $Res Function(_$SmartDnsInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartDnsInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? host = freezed, Object? port = freezed}) {
    return _then(
      _$SmartDnsInfoImpl(
        host: freezed == host
            ? _value.host
            : host // ignore: cast_nullable_to_non_nullable
                  as String?,
        port: freezed == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartDnsInfoImpl extends _SmartDnsInfo {
  const _$SmartDnsInfoImpl({this.host, this.port}) : super._();

  factory _$SmartDnsInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartDnsInfoImplFromJson(json);

  @override
  final String? host;
  @override
  final int? port;

  @override
  String toString() {
    return 'SmartDnsInfo(host: $host, port: $port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartDnsInfoImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, host, port);

  /// Create a copy of SmartDnsInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartDnsInfoImplCopyWith<_$SmartDnsInfoImpl> get copyWith =>
      __$$SmartDnsInfoImplCopyWithImpl<_$SmartDnsInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartDnsInfoImplToJson(this);
  }
}

abstract class _SmartDnsInfo extends SmartDnsInfo {
  const factory _SmartDnsInfo({final String? host, final int? port}) =
      _$SmartDnsInfoImpl;
  const _SmartDnsInfo._() : super._();

  factory _SmartDnsInfo.fromJson(Map<String, dynamic> json) =
      _$SmartDnsInfoImpl.fromJson;

  @override
  String? get host;
  @override
  int? get port;

  /// Create a copy of SmartDnsInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmartDnsInfoImplCopyWith<_$SmartDnsInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ServiceInfo {
  String? get relayDn => throw _privateConstructorUsedError;
  int? get relayPort => throw _privateConstructorUsedError;
  String? get httpsIp => throw _privateConstructorUsedError;
  int? get httpsPort => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceInfoCopyWith<ServiceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceInfoCopyWith<$Res> {
  factory $ServiceInfoCopyWith(
    ServiceInfo value,
    $Res Function(ServiceInfo) then,
  ) = _$ServiceInfoCopyWithImpl<$Res, ServiceInfo>;
  @useResult
  $Res call({
    String? relayDn,
    int? relayPort,
    String? httpsIp,
    int? httpsPort,
    int? port,
  });
}

/// @nodoc
class _$ServiceInfoCopyWithImpl<$Res, $Val extends ServiceInfo>
    implements $ServiceInfoCopyWith<$Res> {
  _$ServiceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relayDn = freezed,
    Object? relayPort = freezed,
    Object? httpsIp = freezed,
    Object? httpsPort = freezed,
    Object? port = freezed,
  }) {
    return _then(
      _value.copyWith(
            relayDn: freezed == relayDn
                ? _value.relayDn
                : relayDn // ignore: cast_nullable_to_non_nullable
                      as String?,
            relayPort: freezed == relayPort
                ? _value.relayPort
                : relayPort // ignore: cast_nullable_to_non_nullable
                      as int?,
            httpsIp: freezed == httpsIp
                ? _value.httpsIp
                : httpsIp // ignore: cast_nullable_to_non_nullable
                      as String?,
            httpsPort: freezed == httpsPort
                ? _value.httpsPort
                : httpsPort // ignore: cast_nullable_to_non_nullable
                      as int?,
            port: freezed == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceInfoImplCopyWith<$Res>
    implements $ServiceInfoCopyWith<$Res> {
  factory _$$ServiceInfoImplCopyWith(
    _$ServiceInfoImpl value,
    $Res Function(_$ServiceInfoImpl) then,
  ) = __$$ServiceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? relayDn,
    int? relayPort,
    String? httpsIp,
    int? httpsPort,
    int? port,
  });
}

/// @nodoc
class __$$ServiceInfoImplCopyWithImpl<$Res>
    extends _$ServiceInfoCopyWithImpl<$Res, _$ServiceInfoImpl>
    implements _$$ServiceInfoImplCopyWith<$Res> {
  __$$ServiceInfoImplCopyWithImpl(
    _$ServiceInfoImpl _value,
    $Res Function(_$ServiceInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relayDn = freezed,
    Object? relayPort = freezed,
    Object? httpsIp = freezed,
    Object? httpsPort = freezed,
    Object? port = freezed,
  }) {
    return _then(
      _$ServiceInfoImpl(
        relayDn: freezed == relayDn
            ? _value.relayDn
            : relayDn // ignore: cast_nullable_to_non_nullable
                  as String?,
        relayPort: freezed == relayPort
            ? _value.relayPort
            : relayPort // ignore: cast_nullable_to_non_nullable
                  as int?,
        httpsIp: freezed == httpsIp
            ? _value.httpsIp
            : httpsIp // ignore: cast_nullable_to_non_nullable
                  as String?,
        httpsPort: freezed == httpsPort
            ? _value.httpsPort
            : httpsPort // ignore: cast_nullable_to_non_nullable
                  as int?,
        port: freezed == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$ServiceInfoImpl extends _ServiceInfo {
  const _$ServiceInfoImpl({
    this.relayDn,
    this.relayPort,
    this.httpsIp,
    this.httpsPort,
    this.port,
  }) : super._();

  @override
  final String? relayDn;
  @override
  final int? relayPort;
  @override
  final String? httpsIp;
  @override
  final int? httpsPort;
  @override
  final int? port;

  @override
  String toString() {
    return 'ServiceInfo(relayDn: $relayDn, relayPort: $relayPort, httpsIp: $httpsIp, httpsPort: $httpsPort, port: $port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceInfoImpl &&
            (identical(other.relayDn, relayDn) || other.relayDn == relayDn) &&
            (identical(other.relayPort, relayPort) ||
                other.relayPort == relayPort) &&
            (identical(other.httpsIp, httpsIp) || other.httpsIp == httpsIp) &&
            (identical(other.httpsPort, httpsPort) ||
                other.httpsPort == httpsPort) &&
            (identical(other.port, port) || other.port == port));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, relayDn, relayPort, httpsIp, httpsPort, port);

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceInfoImplCopyWith<_$ServiceInfoImpl> get copyWith =>
      __$$ServiceInfoImplCopyWithImpl<_$ServiceInfoImpl>(this, _$identity);
}

abstract class _ServiceInfo extends ServiceInfo {
  const factory _ServiceInfo({
    final String? relayDn,
    final int? relayPort,
    final String? httpsIp,
    final int? httpsPort,
    final int? port,
  }) = _$ServiceInfoImpl;
  const _ServiceInfo._() : super._();

  @override
  String? get relayDn;
  @override
  int? get relayPort;
  @override
  String? get httpsIp;
  @override
  int? get httpsPort;
  @override
  int? get port;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceInfoImplCopyWith<_$ServiceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressInfo _$AddressInfoFromJson(Map<String, dynamic> json) {
  return _AddressInfo.fromJson(json);
}

/// @nodoc
mixin _$AddressInfo {
  String get url => throw _privateConstructorUsedError;
  AddressType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;

  /// Serializes this AddressInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressInfoCopyWith<AddressInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressInfoCopyWith<$Res> {
  factory $AddressInfoCopyWith(
    AddressInfo value,
    $Res Function(AddressInfo) then,
  ) = _$AddressInfoCopyWithImpl<$Res, AddressInfo>;
  @useResult
  $Res call({String url, AddressType type, String description, int priority});
}

/// @nodoc
class _$AddressInfoCopyWithImpl<$Res, $Val extends AddressInfo>
    implements $AddressInfoCopyWith<$Res> {
  _$AddressInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? description = null,
    Object? priority = null,
  }) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as AddressType,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressInfoImplCopyWith<$Res>
    implements $AddressInfoCopyWith<$Res> {
  factory _$$AddressInfoImplCopyWith(
    _$AddressInfoImpl value,
    $Res Function(_$AddressInfoImpl) then,
  ) = __$$AddressInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, AddressType type, String description, int priority});
}

/// @nodoc
class __$$AddressInfoImplCopyWithImpl<$Res>
    extends _$AddressInfoCopyWithImpl<$Res, _$AddressInfoImpl>
    implements _$$AddressInfoImplCopyWith<$Res> {
  __$$AddressInfoImplCopyWithImpl(
    _$AddressInfoImpl _value,
    $Res Function(_$AddressInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? description = null,
    Object? priority = null,
  }) {
    return _then(
      _$AddressInfoImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as AddressType,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressInfoImpl extends _AddressInfo {
  const _$AddressInfoImpl({
    required this.url,
    required this.type,
    required this.description,
    required this.priority,
  }) : super._();

  factory _$AddressInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressInfoImplFromJson(json);

  @override
  final String url;
  @override
  final AddressType type;
  @override
  final String description;
  @override
  final int priority;

  @override
  String toString() {
    return 'AddressInfo(url: $url, type: $type, description: $description, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressInfoImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, url, type, description, priority);

  /// Create a copy of AddressInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressInfoImplCopyWith<_$AddressInfoImpl> get copyWith =>
      __$$AddressInfoImplCopyWithImpl<_$AddressInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressInfoImplToJson(this);
  }
}

abstract class _AddressInfo extends AddressInfo {
  const factory _AddressInfo({
    required final String url,
    required final AddressType type,
    required final String description,
    required final int priority,
  }) = _$AddressInfoImpl;
  const _AddressInfo._() : super._();

  factory _AddressInfo.fromJson(Map<String, dynamic> json) =
      _$AddressInfoImpl.fromJson;

  @override
  String get url;
  @override
  AddressType get type;
  @override
  String get description;
  @override
  int get priority;

  /// Create a copy of AddressInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressInfoImplCopyWith<_$AddressInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConnectionTestResult _$ConnectionTestResultFromJson(Map<String, dynamic> json) {
  return _ConnectionTestResult.fromJson(json);
}

/// @nodoc
mixin _$ConnectionTestResult {
  String get url => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Duration get responseTime => throw _privateConstructorUsedError;

  /// Serializes this ConnectionTestResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionTestResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionTestResultCopyWith<ConnectionTestResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionTestResultCopyWith<$Res> {
  factory $ConnectionTestResultCopyWith(
    ConnectionTestResult value,
    $Res Function(ConnectionTestResult) then,
  ) = _$ConnectionTestResultCopyWithImpl<$Res, ConnectionTestResult>;
  @useResult
  $Res call({
    String url,
    bool isConnected,
    int? statusCode,
    String? error,
    Duration responseTime,
  });
}

/// @nodoc
class _$ConnectionTestResultCopyWithImpl<
  $Res,
  $Val extends ConnectionTestResult
>
    implements $ConnectionTestResultCopyWith<$Res> {
  _$ConnectionTestResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionTestResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? isConnected = null,
    Object? statusCode = freezed,
    Object? error = freezed,
    Object? responseTime = null,
  }) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            isConnected: null == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                      as bool,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            responseTime: null == responseTime
                ? _value.responseTime
                : responseTime // ignore: cast_nullable_to_non_nullable
                      as Duration,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionTestResultImplCopyWith<$Res>
    implements $ConnectionTestResultCopyWith<$Res> {
  factory _$$ConnectionTestResultImplCopyWith(
    _$ConnectionTestResultImpl value,
    $Res Function(_$ConnectionTestResultImpl) then,
  ) = __$$ConnectionTestResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String url,
    bool isConnected,
    int? statusCode,
    String? error,
    Duration responseTime,
  });
}

/// @nodoc
class __$$ConnectionTestResultImplCopyWithImpl<$Res>
    extends _$ConnectionTestResultCopyWithImpl<$Res, _$ConnectionTestResultImpl>
    implements _$$ConnectionTestResultImplCopyWith<$Res> {
  __$$ConnectionTestResultImplCopyWithImpl(
    _$ConnectionTestResultImpl _value,
    $Res Function(_$ConnectionTestResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionTestResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? isConnected = null,
    Object? statusCode = freezed,
    Object? error = freezed,
    Object? responseTime = null,
  }) {
    return _then(
      _$ConnectionTestResultImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        isConnected: null == isConnected
            ? _value.isConnected
            : isConnected // ignore: cast_nullable_to_non_nullable
                  as bool,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        responseTime: null == responseTime
            ? _value.responseTime
            : responseTime // ignore: cast_nullable_to_non_nullable
                  as Duration,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionTestResultImpl extends _ConnectionTestResult {
  const _$ConnectionTestResultImpl({
    required this.url,
    required this.isConnected,
    this.statusCode,
    this.error,
    required this.responseTime,
  }) : super._();

  factory _$ConnectionTestResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionTestResultImplFromJson(json);

  @override
  final String url;
  @override
  final bool isConnected;
  @override
  final int? statusCode;
  @override
  final String? error;
  @override
  final Duration responseTime;

  @override
  String toString() {
    return 'ConnectionTestResult(url: $url, isConnected: $isConnected, statusCode: $statusCode, error: $error, responseTime: $responseTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionTestResultImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    url,
    isConnected,
    statusCode,
    error,
    responseTime,
  );

  /// Create a copy of ConnectionTestResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionTestResultImplCopyWith<_$ConnectionTestResultImpl>
  get copyWith =>
      __$$ConnectionTestResultImplCopyWithImpl<_$ConnectionTestResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionTestResultImplToJson(this);
  }
}

abstract class _ConnectionTestResult extends ConnectionTestResult {
  const factory _ConnectionTestResult({
    required final String url,
    required final bool isConnected,
    final int? statusCode,
    final String? error,
    required final Duration responseTime,
  }) = _$ConnectionTestResultImpl;
  const _ConnectionTestResult._() : super._();

  factory _ConnectionTestResult.fromJson(Map<String, dynamic> json) =
      _$ConnectionTestResultImpl.fromJson;

  @override
  String get url;
  @override
  bool get isConnected;
  @override
  int? get statusCode;
  @override
  String? get error;
  @override
  Duration get responseTime;

  /// Create a copy of ConnectionTestResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionTestResultImplCopyWith<_$ConnectionTestResultImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SmartLoginResult _$SmartLoginResultFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return SmartLoginResultSuccess.fromJson(json);
    case 'failure':
      return SmartLoginResultFailure.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'SmartLoginResult',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$SmartLoginResult {
  List<LoginAttempt> get attempts => throw _privateConstructorUsedError;
  Map<String, dynamic> get stats => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )
    success,
    required TResult Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )
    failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    success,
    TResult? Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    success,
    TResult Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartLoginResultSuccess value) success,
    required TResult Function(SmartLoginResultFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartLoginResultSuccess value)? success,
    TResult? Function(SmartLoginResultFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartLoginResultSuccess value)? success,
    TResult Function(SmartLoginResultFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this SmartLoginResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmartLoginResultCopyWith<SmartLoginResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartLoginResultCopyWith<$Res> {
  factory $SmartLoginResultCopyWith(
    SmartLoginResult value,
    $Res Function(SmartLoginResult) then,
  ) = _$SmartLoginResultCopyWithImpl<$Res, SmartLoginResult>;
  @useResult
  $Res call({List<LoginAttempt> attempts, Map<String, dynamic> stats});
}

/// @nodoc
class _$SmartLoginResultCopyWithImpl<$Res, $Val extends SmartLoginResult>
    implements $SmartLoginResultCopyWith<$Res> {
  _$SmartLoginResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? attempts = null, Object? stats = null}) {
    return _then(
      _value.copyWith(
            attempts: null == attempts
                ? _value.attempts
                : attempts // ignore: cast_nullable_to_non_nullable
                      as List<LoginAttempt>,
            stats: null == stats
                ? _value.stats
                : stats // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmartLoginResultSuccessImplCopyWith<$Res>
    implements $SmartLoginResultCopyWith<$Res> {
  factory _$$SmartLoginResultSuccessImplCopyWith(
    _$SmartLoginResultSuccessImpl value,
    $Res Function(_$SmartLoginResultSuccessImpl) then,
  ) = __$$SmartLoginResultSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoginResult loginResult,
    String bestAddress,
    List<LoginAttempt> attempts,
    Map<String, dynamic> stats,
  });

  $LoginResultCopyWith<$Res> get loginResult;
}

/// @nodoc
class __$$SmartLoginResultSuccessImplCopyWithImpl<$Res>
    extends _$SmartLoginResultCopyWithImpl<$Res, _$SmartLoginResultSuccessImpl>
    implements _$$SmartLoginResultSuccessImplCopyWith<$Res> {
  __$$SmartLoginResultSuccessImplCopyWithImpl(
    _$SmartLoginResultSuccessImpl _value,
    $Res Function(_$SmartLoginResultSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginResult = null,
    Object? bestAddress = null,
    Object? attempts = null,
    Object? stats = null,
  }) {
    return _then(
      _$SmartLoginResultSuccessImpl(
        loginResult: null == loginResult
            ? _value.loginResult
            : loginResult // ignore: cast_nullable_to_non_nullable
                  as LoginResult,
        bestAddress: null == bestAddress
            ? _value.bestAddress
            : bestAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        attempts: null == attempts
            ? _value._attempts
            : attempts // ignore: cast_nullable_to_non_nullable
                  as List<LoginAttempt>,
        stats: null == stats
            ? _value._stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginResultCopyWith<$Res> get loginResult {
    return $LoginResultCopyWith<$Res>(_value.loginResult, (value) {
      return _then(_value.copyWith(loginResult: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartLoginResultSuccessImpl extends SmartLoginResultSuccess {
  const _$SmartLoginResultSuccessImpl({
    required this.loginResult,
    required this.bestAddress,
    required final List<LoginAttempt> attempts,
    required final Map<String, dynamic> stats,
    final String? $type,
  }) : _attempts = attempts,
       _stats = stats,
       $type = $type ?? 'success',
       super._();

  factory _$SmartLoginResultSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartLoginResultSuccessImplFromJson(json);

  @override
  final LoginResult loginResult;
  @override
  final String bestAddress;
  final List<LoginAttempt> _attempts;
  @override
  List<LoginAttempt> get attempts {
    if (_attempts is EqualUnmodifiableListView) return _attempts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attempts);
  }

  final Map<String, dynamic> _stats;
  @override
  Map<String, dynamic> get stats {
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stats);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SmartLoginResult.success(loginResult: $loginResult, bestAddress: $bestAddress, attempts: $attempts, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartLoginResultSuccessImpl &&
            (identical(other.loginResult, loginResult) ||
                other.loginResult == loginResult) &&
            (identical(other.bestAddress, bestAddress) ||
                other.bestAddress == bestAddress) &&
            const DeepCollectionEquality().equals(other._attempts, _attempts) &&
            const DeepCollectionEquality().equals(other._stats, _stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    loginResult,
    bestAddress,
    const DeepCollectionEquality().hash(_attempts),
    const DeepCollectionEquality().hash(_stats),
  );

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartLoginResultSuccessImplCopyWith<_$SmartLoginResultSuccessImpl>
  get copyWith =>
      __$$SmartLoginResultSuccessImplCopyWithImpl<
        _$SmartLoginResultSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )
    success,
    required TResult Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )
    failure,
  }) {
    return success(loginResult, bestAddress, attempts, stats);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    success,
    TResult? Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    failure,
  }) {
    return success?.call(loginResult, bestAddress, attempts, stats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    success,
    TResult Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(loginResult, bestAddress, attempts, stats);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartLoginResultSuccess value) success,
    required TResult Function(SmartLoginResultFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartLoginResultSuccess value)? success,
    TResult? Function(SmartLoginResultFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartLoginResultSuccess value)? success,
    TResult Function(SmartLoginResultFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartLoginResultSuccessImplToJson(this);
  }
}

abstract class SmartLoginResultSuccess extends SmartLoginResult {
  const factory SmartLoginResultSuccess({
    required final LoginResult loginResult,
    required final String bestAddress,
    required final List<LoginAttempt> attempts,
    required final Map<String, dynamic> stats,
  }) = _$SmartLoginResultSuccessImpl;
  const SmartLoginResultSuccess._() : super._();

  factory SmartLoginResultSuccess.fromJson(Map<String, dynamic> json) =
      _$SmartLoginResultSuccessImpl.fromJson;

  LoginResult get loginResult;
  String get bestAddress;
  @override
  List<LoginAttempt> get attempts;
  @override
  Map<String, dynamic> get stats;

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmartLoginResultSuccessImplCopyWith<_$SmartLoginResultSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SmartLoginResultFailureImplCopyWith<$Res>
    implements $SmartLoginResultCopyWith<$Res> {
  factory _$$SmartLoginResultFailureImplCopyWith(
    _$SmartLoginResultFailureImpl value,
    $Res Function(_$SmartLoginResultFailureImpl) then,
  ) = __$$SmartLoginResultFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String error,
    List<LoginAttempt> attempts,
    Map<String, dynamic> stats,
  });
}

/// @nodoc
class __$$SmartLoginResultFailureImplCopyWithImpl<$Res>
    extends _$SmartLoginResultCopyWithImpl<$Res, _$SmartLoginResultFailureImpl>
    implements _$$SmartLoginResultFailureImplCopyWith<$Res> {
  __$$SmartLoginResultFailureImplCopyWithImpl(
    _$SmartLoginResultFailureImpl _value,
    $Res Function(_$SmartLoginResultFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? attempts = null,
    Object? stats = null,
  }) {
    return _then(
      _$SmartLoginResultFailureImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
        attempts: null == attempts
            ? _value._attempts
            : attempts // ignore: cast_nullable_to_non_nullable
                  as List<LoginAttempt>,
        stats: null == stats
            ? _value._stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartLoginResultFailureImpl extends SmartLoginResultFailure {
  const _$SmartLoginResultFailureImpl({
    required this.error,
    required final List<LoginAttempt> attempts,
    required final Map<String, dynamic> stats,
    final String? $type,
  }) : _attempts = attempts,
       _stats = stats,
       $type = $type ?? 'failure',
       super._();

  factory _$SmartLoginResultFailureImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartLoginResultFailureImplFromJson(json);

  @override
  final String error;
  final List<LoginAttempt> _attempts;
  @override
  List<LoginAttempt> get attempts {
    if (_attempts is EqualUnmodifiableListView) return _attempts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attempts);
  }

  final Map<String, dynamic> _stats;
  @override
  Map<String, dynamic> get stats {
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stats);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SmartLoginResult.failure(error: $error, attempts: $attempts, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartLoginResultFailureImpl &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._attempts, _attempts) &&
            const DeepCollectionEquality().equals(other._stats, _stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    error,
    const DeepCollectionEquality().hash(_attempts),
    const DeepCollectionEquality().hash(_stats),
  );

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartLoginResultFailureImplCopyWith<_$SmartLoginResultFailureImpl>
  get copyWith =>
      __$$SmartLoginResultFailureImplCopyWithImpl<
        _$SmartLoginResultFailureImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )
    success,
    required TResult Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )
    failure,
  }) {
    return failure(error, attempts, stats);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    success,
    TResult? Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    failure,
  }) {
    return failure?.call(error, attempts, stats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      LoginResult loginResult,
      String bestAddress,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    success,
    TResult Function(
      String error,
      List<LoginAttempt> attempts,
      Map<String, dynamic> stats,
    )?
    failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error, attempts, stats);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartLoginResultSuccess value) success,
    required TResult Function(SmartLoginResultFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartLoginResultSuccess value)? success,
    TResult? Function(SmartLoginResultFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartLoginResultSuccess value)? success,
    TResult Function(SmartLoginResultFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartLoginResultFailureImplToJson(this);
  }
}

abstract class SmartLoginResultFailure extends SmartLoginResult {
  const factory SmartLoginResultFailure({
    required final String error,
    required final List<LoginAttempt> attempts,
    required final Map<String, dynamic> stats,
  }) = _$SmartLoginResultFailureImpl;
  const SmartLoginResultFailure._() : super._();

  factory SmartLoginResultFailure.fromJson(Map<String, dynamic> json) =
      _$SmartLoginResultFailureImpl.fromJson;

  String get error;
  @override
  List<LoginAttempt> get attempts;
  @override
  Map<String, dynamic> get stats;

  /// Create a copy of SmartLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmartLoginResultFailureImplCopyWith<_$SmartLoginResultFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LoginAttempt _$LoginAttemptFromJson(Map<String, dynamic> json) {
  return _LoginAttempt.fromJson(json);
}

/// @nodoc
mixin _$LoginAttempt {
  String get address => throw _privateConstructorUsedError;
  AddressType get addressType => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  int get attemptNumber => throw _privateConstructorUsedError;
  ConnectionTestResult? get connectionResult =>
      throw _privateConstructorUsedError;
  LoginResult? get loginResult => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this LoginAttempt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginAttemptCopyWith<LoginAttempt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginAttemptCopyWith<$Res> {
  factory $LoginAttemptCopyWith(
    LoginAttempt value,
    $Res Function(LoginAttempt) then,
  ) = _$LoginAttemptCopyWithImpl<$Res, LoginAttempt>;
  @useResult
  $Res call({
    String address,
    AddressType addressType,
    int priority,
    int attemptNumber,
    ConnectionTestResult? connectionResult,
    LoginResult? loginResult,
    String? error,
  });

  $ConnectionTestResultCopyWith<$Res>? get connectionResult;
  $LoginResultCopyWith<$Res>? get loginResult;
}

/// @nodoc
class _$LoginAttemptCopyWithImpl<$Res, $Val extends LoginAttempt>
    implements $LoginAttemptCopyWith<$Res> {
  _$LoginAttemptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? addressType = null,
    Object? priority = null,
    Object? attemptNumber = null,
    Object? connectionResult = freezed,
    Object? loginResult = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            addressType: null == addressType
                ? _value.addressType
                : addressType // ignore: cast_nullable_to_non_nullable
                      as AddressType,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as int,
            attemptNumber: null == attemptNumber
                ? _value.attemptNumber
                : attemptNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            connectionResult: freezed == connectionResult
                ? _value.connectionResult
                : connectionResult // ignore: cast_nullable_to_non_nullable
                      as ConnectionTestResult?,
            loginResult: freezed == loginResult
                ? _value.loginResult
                : loginResult // ignore: cast_nullable_to_non_nullable
                      as LoginResult?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of LoginAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionTestResultCopyWith<$Res>? get connectionResult {
    if (_value.connectionResult == null) {
      return null;
    }

    return $ConnectionTestResultCopyWith<$Res>(_value.connectionResult!, (
      value,
    ) {
      return _then(_value.copyWith(connectionResult: value) as $Val);
    });
  }

  /// Create a copy of LoginAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginResultCopyWith<$Res>? get loginResult {
    if (_value.loginResult == null) {
      return null;
    }

    return $LoginResultCopyWith<$Res>(_value.loginResult!, (value) {
      return _then(_value.copyWith(loginResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginAttemptImplCopyWith<$Res>
    implements $LoginAttemptCopyWith<$Res> {
  factory _$$LoginAttemptImplCopyWith(
    _$LoginAttemptImpl value,
    $Res Function(_$LoginAttemptImpl) then,
  ) = __$$LoginAttemptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String address,
    AddressType addressType,
    int priority,
    int attemptNumber,
    ConnectionTestResult? connectionResult,
    LoginResult? loginResult,
    String? error,
  });

  @override
  $ConnectionTestResultCopyWith<$Res>? get connectionResult;
  @override
  $LoginResultCopyWith<$Res>? get loginResult;
}

/// @nodoc
class __$$LoginAttemptImplCopyWithImpl<$Res>
    extends _$LoginAttemptCopyWithImpl<$Res, _$LoginAttemptImpl>
    implements _$$LoginAttemptImplCopyWith<$Res> {
  __$$LoginAttemptImplCopyWithImpl(
    _$LoginAttemptImpl _value,
    $Res Function(_$LoginAttemptImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? addressType = null,
    Object? priority = null,
    Object? attemptNumber = null,
    Object? connectionResult = freezed,
    Object? loginResult = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$LoginAttemptImpl(
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        addressType: null == addressType
            ? _value.addressType
            : addressType // ignore: cast_nullable_to_non_nullable
                  as AddressType,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as int,
        attemptNumber: null == attemptNumber
            ? _value.attemptNumber
            : attemptNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        connectionResult: freezed == connectionResult
            ? _value.connectionResult
            : connectionResult // ignore: cast_nullable_to_non_nullable
                  as ConnectionTestResult?,
        loginResult: freezed == loginResult
            ? _value.loginResult
            : loginResult // ignore: cast_nullable_to_non_nullable
                  as LoginResult?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginAttemptImpl extends _LoginAttempt {
  const _$LoginAttemptImpl({
    required this.address,
    required this.addressType,
    required this.priority,
    required this.attemptNumber,
    this.connectionResult,
    this.loginResult,
    this.error,
  }) : super._();

  factory _$LoginAttemptImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginAttemptImplFromJson(json);

  @override
  final String address;
  @override
  final AddressType addressType;
  @override
  final int priority;
  @override
  final int attemptNumber;
  @override
  final ConnectionTestResult? connectionResult;
  @override
  final LoginResult? loginResult;
  @override
  final String? error;

  @override
  String toString() {
    return 'LoginAttempt(address: $address, addressType: $addressType, priority: $priority, attemptNumber: $attemptNumber, connectionResult: $connectionResult, loginResult: $loginResult, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginAttemptImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.addressType, addressType) ||
                other.addressType == addressType) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.attemptNumber, attemptNumber) ||
                other.attemptNumber == attemptNumber) &&
            (identical(other.connectionResult, connectionResult) ||
                other.connectionResult == connectionResult) &&
            (identical(other.loginResult, loginResult) ||
                other.loginResult == loginResult) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    address,
    addressType,
    priority,
    attemptNumber,
    connectionResult,
    loginResult,
    error,
  );

  /// Create a copy of LoginAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginAttemptImplCopyWith<_$LoginAttemptImpl> get copyWith =>
      __$$LoginAttemptImplCopyWithImpl<_$LoginAttemptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginAttemptImplToJson(this);
  }
}

abstract class _LoginAttempt extends LoginAttempt {
  const factory _LoginAttempt({
    required final String address,
    required final AddressType addressType,
    required final int priority,
    required final int attemptNumber,
    final ConnectionTestResult? connectionResult,
    final LoginResult? loginResult,
    final String? error,
  }) = _$LoginAttemptImpl;
  const _LoginAttempt._() : super._();

  factory _LoginAttempt.fromJson(Map<String, dynamic> json) =
      _$LoginAttemptImpl.fromJson;

  @override
  String get address;
  @override
  AddressType get addressType;
  @override
  int get priority;
  @override
  int get attemptNumber;
  @override
  ConnectionTestResult? get connectionResult;
  @override
  LoginResult? get loginResult;
  @override
  String? get error;

  /// Create a copy of LoginAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginAttemptImplCopyWith<_$LoginAttemptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuickConnectResult _$QuickConnectResultFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return QuickConnectResultSuccess.fromJson(json);
    case 'failure':
      return QuickConnectResultFailure.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'QuickConnectResult',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$QuickConnectResult {
  String get quickConnectId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )
    success,
    required TResult Function(String error, String quickConnectId) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )?
    success,
    TResult? Function(String error, String quickConnectId)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )?
    success,
    TResult Function(String error, String quickConnectId)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QuickConnectResultSuccess value) success,
    required TResult Function(QuickConnectResultFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QuickConnectResultSuccess value)? success,
    TResult? Function(QuickConnectResultFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QuickConnectResultSuccess value)? success,
    TResult Function(QuickConnectResultFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this QuickConnectResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickConnectResultCopyWith<QuickConnectResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickConnectResultCopyWith<$Res> {
  factory $QuickConnectResultCopyWith(
    QuickConnectResult value,
    $Res Function(QuickConnectResult) then,
  ) = _$QuickConnectResultCopyWithImpl<$Res, QuickConnectResult>;
  @useResult
  $Res call({String quickConnectId});
}

/// @nodoc
class _$QuickConnectResultCopyWithImpl<$Res, $Val extends QuickConnectResult>
    implements $QuickConnectResultCopyWith<$Res> {
  _$QuickConnectResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? quickConnectId = null}) {
    return _then(
      _value.copyWith(
            quickConnectId: null == quickConnectId
                ? _value.quickConnectId
                : quickConnectId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuickConnectResultSuccessImplCopyWith<$Res>
    implements $QuickConnectResultCopyWith<$Res> {
  factory _$$QuickConnectResultSuccessImplCopyWith(
    _$QuickConnectResultSuccessImpl value,
    $Res Function(_$QuickConnectResultSuccessImpl) then,
  ) = __$$QuickConnectResultSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String address,
    ConnectionTestResult connectionResult,
    String quickConnectId,
  });

  $ConnectionTestResultCopyWith<$Res> get connectionResult;
}

/// @nodoc
class __$$QuickConnectResultSuccessImplCopyWithImpl<$Res>
    extends
        _$QuickConnectResultCopyWithImpl<$Res, _$QuickConnectResultSuccessImpl>
    implements _$$QuickConnectResultSuccessImplCopyWith<$Res> {
  __$$QuickConnectResultSuccessImplCopyWithImpl(
    _$QuickConnectResultSuccessImpl _value,
    $Res Function(_$QuickConnectResultSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? connectionResult = null,
    Object? quickConnectId = null,
  }) {
    return _then(
      _$QuickConnectResultSuccessImpl(
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        connectionResult: null == connectionResult
            ? _value.connectionResult
            : connectionResult // ignore: cast_nullable_to_non_nullable
                  as ConnectionTestResult,
        quickConnectId: null == quickConnectId
            ? _value.quickConnectId
            : quickConnectId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionTestResultCopyWith<$Res> get connectionResult {
    return $ConnectionTestResultCopyWith<$Res>(_value.connectionResult, (
      value,
    ) {
      return _then(_value.copyWith(connectionResult: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickConnectResultSuccessImpl extends QuickConnectResultSuccess {
  const _$QuickConnectResultSuccessImpl({
    required this.address,
    required this.connectionResult,
    required this.quickConnectId,
    final String? $type,
  }) : $type = $type ?? 'success',
       super._();

  factory _$QuickConnectResultSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickConnectResultSuccessImplFromJson(json);

  @override
  final String address;
  @override
  final ConnectionTestResult connectionResult;
  @override
  final String quickConnectId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'QuickConnectResult.success(address: $address, connectionResult: $connectionResult, quickConnectId: $quickConnectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectResultSuccessImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.connectionResult, connectionResult) ||
                other.connectionResult == connectionResult) &&
            (identical(other.quickConnectId, quickConnectId) ||
                other.quickConnectId == quickConnectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, connectionResult, quickConnectId);

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickConnectResultSuccessImplCopyWith<_$QuickConnectResultSuccessImpl>
  get copyWith =>
      __$$QuickConnectResultSuccessImplCopyWithImpl<
        _$QuickConnectResultSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )
    success,
    required TResult Function(String error, String quickConnectId) failure,
  }) {
    return success(address, connectionResult, quickConnectId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )?
    success,
    TResult? Function(String error, String quickConnectId)? failure,
  }) {
    return success?.call(address, connectionResult, quickConnectId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )?
    success,
    TResult Function(String error, String quickConnectId)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(address, connectionResult, quickConnectId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QuickConnectResultSuccess value) success,
    required TResult Function(QuickConnectResultFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QuickConnectResultSuccess value)? success,
    TResult? Function(QuickConnectResultFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QuickConnectResultSuccess value)? success,
    TResult Function(QuickConnectResultFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickConnectResultSuccessImplToJson(this);
  }
}

abstract class QuickConnectResultSuccess extends QuickConnectResult {
  const factory QuickConnectResultSuccess({
    required final String address,
    required final ConnectionTestResult connectionResult,
    required final String quickConnectId,
  }) = _$QuickConnectResultSuccessImpl;
  const QuickConnectResultSuccess._() : super._();

  factory QuickConnectResultSuccess.fromJson(Map<String, dynamic> json) =
      _$QuickConnectResultSuccessImpl.fromJson;

  String get address;
  ConnectionTestResult get connectionResult;
  @override
  String get quickConnectId;

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectResultSuccessImplCopyWith<_$QuickConnectResultSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuickConnectResultFailureImplCopyWith<$Res>
    implements $QuickConnectResultCopyWith<$Res> {
  factory _$$QuickConnectResultFailureImplCopyWith(
    _$QuickConnectResultFailureImpl value,
    $Res Function(_$QuickConnectResultFailureImpl) then,
  ) = __$$QuickConnectResultFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String error, String quickConnectId});
}

/// @nodoc
class __$$QuickConnectResultFailureImplCopyWithImpl<$Res>
    extends
        _$QuickConnectResultCopyWithImpl<$Res, _$QuickConnectResultFailureImpl>
    implements _$$QuickConnectResultFailureImplCopyWith<$Res> {
  __$$QuickConnectResultFailureImplCopyWithImpl(
    _$QuickConnectResultFailureImpl _value,
    $Res Function(_$QuickConnectResultFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? quickConnectId = null}) {
    return _then(
      _$QuickConnectResultFailureImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
        quickConnectId: null == quickConnectId
            ? _value.quickConnectId
            : quickConnectId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickConnectResultFailureImpl extends QuickConnectResultFailure {
  const _$QuickConnectResultFailureImpl({
    required this.error,
    required this.quickConnectId,
    final String? $type,
  }) : $type = $type ?? 'failure',
       super._();

  factory _$QuickConnectResultFailureImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickConnectResultFailureImplFromJson(json);

  @override
  final String error;
  @override
  final String quickConnectId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'QuickConnectResult.failure(error: $error, quickConnectId: $quickConnectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectResultFailureImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.quickConnectId, quickConnectId) ||
                other.quickConnectId == quickConnectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error, quickConnectId);

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickConnectResultFailureImplCopyWith<_$QuickConnectResultFailureImpl>
  get copyWith =>
      __$$QuickConnectResultFailureImplCopyWithImpl<
        _$QuickConnectResultFailureImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )
    success,
    required TResult Function(String error, String quickConnectId) failure,
  }) {
    return failure(error, quickConnectId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )?
    success,
    TResult? Function(String error, String quickConnectId)? failure,
  }) {
    return failure?.call(error, quickConnectId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String address,
      ConnectionTestResult connectionResult,
      String quickConnectId,
    )?
    success,
    TResult Function(String error, String quickConnectId)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error, quickConnectId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QuickConnectResultSuccess value) success,
    required TResult Function(QuickConnectResultFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QuickConnectResultSuccess value)? success,
    TResult? Function(QuickConnectResultFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QuickConnectResultSuccess value)? success,
    TResult Function(QuickConnectResultFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickConnectResultFailureImplToJson(this);
  }
}

abstract class QuickConnectResultFailure extends QuickConnectResult {
  const factory QuickConnectResultFailure({
    required final String error,
    required final String quickConnectId,
  }) = _$QuickConnectResultFailureImpl;
  const QuickConnectResultFailure._() : super._();

  factory QuickConnectResultFailure.fromJson(Map<String, dynamic> json) =
      _$QuickConnectResultFailureImpl.fromJson;

  String get error;
  @override
  String get quickConnectId;

  /// Create a copy of QuickConnectResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectResultFailureImplCopyWith<_$QuickConnectResultFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FullConnectionResult _$FullConnectionResultFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return FullConnectionResultSuccess.fromJson(json);
    case 'failure':
      return FullConnectionResultFailure.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'FullConnectionResult',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$FullConnectionResult {
  String get quickConnectId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )
    success,
    required TResult Function(String error, String quickConnectId) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )?
    success,
    TResult? Function(String error, String quickConnectId)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )?
    success,
    TResult Function(String error, String quickConnectId)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullConnectionResultSuccess value) success,
    required TResult Function(FullConnectionResultFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FullConnectionResultSuccess value)? success,
    TResult? Function(FullConnectionResultFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullConnectionResultSuccess value)? success,
    TResult Function(FullConnectionResultFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this FullConnectionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FullConnectionResultCopyWith<FullConnectionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullConnectionResultCopyWith<$Res> {
  factory $FullConnectionResultCopyWith(
    FullConnectionResult value,
    $Res Function(FullConnectionResult) then,
  ) = _$FullConnectionResultCopyWithImpl<$Res, FullConnectionResult>;
  @useResult
  $Res call({String quickConnectId});
}

/// @nodoc
class _$FullConnectionResultCopyWithImpl<
  $Res,
  $Val extends FullConnectionResult
>
    implements $FullConnectionResultCopyWith<$Res> {
  _$FullConnectionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? quickConnectId = null}) {
    return _then(
      _value.copyWith(
            quickConnectId: null == quickConnectId
                ? _value.quickConnectId
                : quickConnectId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FullConnectionResultSuccessImplCopyWith<$Res>
    implements $FullConnectionResultCopyWith<$Res> {
  factory _$$FullConnectionResultSuccessImplCopyWith(
    _$FullConnectionResultSuccessImpl value,
    $Res Function(_$FullConnectionResultSuccessImpl) then,
  ) = __$$FullConnectionResultSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AddressInfo> addresses,
    List<ConnectionTestResult> connectionResults,
    Map<String, dynamic> connectionStats,
    LoginResult loginResult,
    String quickConnectId,
  });

  $LoginResultCopyWith<$Res> get loginResult;
}

/// @nodoc
class __$$FullConnectionResultSuccessImplCopyWithImpl<$Res>
    extends
        _$FullConnectionResultCopyWithImpl<
          $Res,
          _$FullConnectionResultSuccessImpl
        >
    implements _$$FullConnectionResultSuccessImplCopyWith<$Res> {
  __$$FullConnectionResultSuccessImplCopyWithImpl(
    _$FullConnectionResultSuccessImpl _value,
    $Res Function(_$FullConnectionResultSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addresses = null,
    Object? connectionResults = null,
    Object? connectionStats = null,
    Object? loginResult = null,
    Object? quickConnectId = null,
  }) {
    return _then(
      _$FullConnectionResultSuccessImpl(
        addresses: null == addresses
            ? _value._addresses
            : addresses // ignore: cast_nullable_to_non_nullable
                  as List<AddressInfo>,
        connectionResults: null == connectionResults
            ? _value._connectionResults
            : connectionResults // ignore: cast_nullable_to_non_nullable
                  as List<ConnectionTestResult>,
        connectionStats: null == connectionStats
            ? _value._connectionStats
            : connectionStats // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        loginResult: null == loginResult
            ? _value.loginResult
            : loginResult // ignore: cast_nullable_to_non_nullable
                  as LoginResult,
        quickConnectId: null == quickConnectId
            ? _value.quickConnectId
            : quickConnectId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginResultCopyWith<$Res> get loginResult {
    return $LoginResultCopyWith<$Res>(_value.loginResult, (value) {
      return _then(_value.copyWith(loginResult: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$FullConnectionResultSuccessImpl extends FullConnectionResultSuccess {
  const _$FullConnectionResultSuccessImpl({
    required final List<AddressInfo> addresses,
    required final List<ConnectionTestResult> connectionResults,
    required final Map<String, dynamic> connectionStats,
    required this.loginResult,
    required this.quickConnectId,
    final String? $type,
  }) : _addresses = addresses,
       _connectionResults = connectionResults,
       _connectionStats = connectionStats,
       $type = $type ?? 'success',
       super._();

  factory _$FullConnectionResultSuccessImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$FullConnectionResultSuccessImplFromJson(json);

  final List<AddressInfo> _addresses;
  @override
  List<AddressInfo> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  final List<ConnectionTestResult> _connectionResults;
  @override
  List<ConnectionTestResult> get connectionResults {
    if (_connectionResults is EqualUnmodifiableListView)
      return _connectionResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connectionResults);
  }

  final Map<String, dynamic> _connectionStats;
  @override
  Map<String, dynamic> get connectionStats {
    if (_connectionStats is EqualUnmodifiableMapView) return _connectionStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_connectionStats);
  }

  @override
  final LoginResult loginResult;
  @override
  final String quickConnectId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FullConnectionResult.success(addresses: $addresses, connectionResults: $connectionResults, connectionStats: $connectionStats, loginResult: $loginResult, quickConnectId: $quickConnectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FullConnectionResultSuccessImpl &&
            const DeepCollectionEquality().equals(
              other._addresses,
              _addresses,
            ) &&
            const DeepCollectionEquality().equals(
              other._connectionResults,
              _connectionResults,
            ) &&
            const DeepCollectionEquality().equals(
              other._connectionStats,
              _connectionStats,
            ) &&
            (identical(other.loginResult, loginResult) ||
                other.loginResult == loginResult) &&
            (identical(other.quickConnectId, quickConnectId) ||
                other.quickConnectId == quickConnectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_addresses),
    const DeepCollectionEquality().hash(_connectionResults),
    const DeepCollectionEquality().hash(_connectionStats),
    loginResult,
    quickConnectId,
  );

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullConnectionResultSuccessImplCopyWith<_$FullConnectionResultSuccessImpl>
  get copyWith =>
      __$$FullConnectionResultSuccessImplCopyWithImpl<
        _$FullConnectionResultSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )
    success,
    required TResult Function(String error, String quickConnectId) failure,
  }) {
    return success(
      addresses,
      connectionResults,
      connectionStats,
      loginResult,
      quickConnectId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )?
    success,
    TResult? Function(String error, String quickConnectId)? failure,
  }) {
    return success?.call(
      addresses,
      connectionResults,
      connectionStats,
      loginResult,
      quickConnectId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )?
    success,
    TResult Function(String error, String quickConnectId)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(
        addresses,
        connectionResults,
        connectionStats,
        loginResult,
        quickConnectId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullConnectionResultSuccess value) success,
    required TResult Function(FullConnectionResultFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FullConnectionResultSuccess value)? success,
    TResult? Function(FullConnectionResultFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullConnectionResultSuccess value)? success,
    TResult Function(FullConnectionResultFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FullConnectionResultSuccessImplToJson(this);
  }
}

abstract class FullConnectionResultSuccess extends FullConnectionResult {
  const factory FullConnectionResultSuccess({
    required final List<AddressInfo> addresses,
    required final List<ConnectionTestResult> connectionResults,
    required final Map<String, dynamic> connectionStats,
    required final LoginResult loginResult,
    required final String quickConnectId,
  }) = _$FullConnectionResultSuccessImpl;
  const FullConnectionResultSuccess._() : super._();

  factory FullConnectionResultSuccess.fromJson(Map<String, dynamic> json) =
      _$FullConnectionResultSuccessImpl.fromJson;

  List<AddressInfo> get addresses;
  List<ConnectionTestResult> get connectionResults;
  Map<String, dynamic> get connectionStats;
  LoginResult get loginResult;
  @override
  String get quickConnectId;

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullConnectionResultSuccessImplCopyWith<_$FullConnectionResultSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FullConnectionResultFailureImplCopyWith<$Res>
    implements $FullConnectionResultCopyWith<$Res> {
  factory _$$FullConnectionResultFailureImplCopyWith(
    _$FullConnectionResultFailureImpl value,
    $Res Function(_$FullConnectionResultFailureImpl) then,
  ) = __$$FullConnectionResultFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String error, String quickConnectId});
}

/// @nodoc
class __$$FullConnectionResultFailureImplCopyWithImpl<$Res>
    extends
        _$FullConnectionResultCopyWithImpl<
          $Res,
          _$FullConnectionResultFailureImpl
        >
    implements _$$FullConnectionResultFailureImplCopyWith<$Res> {
  __$$FullConnectionResultFailureImplCopyWithImpl(
    _$FullConnectionResultFailureImpl _value,
    $Res Function(_$FullConnectionResultFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? quickConnectId = null}) {
    return _then(
      _$FullConnectionResultFailureImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
        quickConnectId: null == quickConnectId
            ? _value.quickConnectId
            : quickConnectId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FullConnectionResultFailureImpl extends FullConnectionResultFailure {
  const _$FullConnectionResultFailureImpl({
    required this.error,
    required this.quickConnectId,
    final String? $type,
  }) : $type = $type ?? 'failure',
       super._();

  factory _$FullConnectionResultFailureImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$FullConnectionResultFailureImplFromJson(json);

  @override
  final String error;
  @override
  final String quickConnectId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FullConnectionResult.failure(error: $error, quickConnectId: $quickConnectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FullConnectionResultFailureImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.quickConnectId, quickConnectId) ||
                other.quickConnectId == quickConnectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error, quickConnectId);

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullConnectionResultFailureImplCopyWith<_$FullConnectionResultFailureImpl>
  get copyWith =>
      __$$FullConnectionResultFailureImplCopyWithImpl<
        _$FullConnectionResultFailureImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )
    success,
    required TResult Function(String error, String quickConnectId) failure,
  }) {
    return failure(error, quickConnectId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )?
    success,
    TResult? Function(String error, String quickConnectId)? failure,
  }) {
    return failure?.call(error, quickConnectId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      List<AddressInfo> addresses,
      List<ConnectionTestResult> connectionResults,
      Map<String, dynamic> connectionStats,
      LoginResult loginResult,
      String quickConnectId,
    )?
    success,
    TResult Function(String error, String quickConnectId)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error, quickConnectId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullConnectionResultSuccess value) success,
    required TResult Function(FullConnectionResultFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FullConnectionResultSuccess value)? success,
    TResult? Function(FullConnectionResultFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullConnectionResultSuccess value)? success,
    TResult Function(FullConnectionResultFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FullConnectionResultFailureImplToJson(this);
  }
}

abstract class FullConnectionResultFailure extends FullConnectionResult {
  const factory FullConnectionResultFailure({
    required final String error,
    required final String quickConnectId,
  }) = _$FullConnectionResultFailureImpl;
  const FullConnectionResultFailure._() : super._();

  factory FullConnectionResultFailure.fromJson(Map<String, dynamic> json) =
      _$FullConnectionResultFailureImpl.fromJson;

  String get error;
  @override
  String get quickConnectId;

  /// Create a copy of FullConnectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullConnectionResultFailureImplCopyWith<_$FullConnectionResultFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}
