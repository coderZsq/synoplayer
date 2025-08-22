// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_api_info_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QueryApiInfoResponse _$QueryApiInfoResponseFromJson(Map<String, dynamic> json) {
  return _QueryApiInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$QueryApiInfoResponse {
  Map<String, ApiInfo>? get data => throw _privateConstructorUsedError;
  bool? get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QueryApiInfoResponseCopyWith<QueryApiInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryApiInfoResponseCopyWith<$Res> {
  factory $QueryApiInfoResponseCopyWith(QueryApiInfoResponse value,
          $Res Function(QueryApiInfoResponse) then) =
      _$QueryApiInfoResponseCopyWithImpl<$Res, QueryApiInfoResponse>;
  @useResult
  $Res call({Map<String, ApiInfo>? data, bool? success});
}

/// @nodoc
class _$QueryApiInfoResponseCopyWithImpl<$Res,
        $Val extends QueryApiInfoResponse>
    implements $QueryApiInfoResponseCopyWith<$Res> {
  _$QueryApiInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? success = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, ApiInfo>?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueryApiInfoResponseImplCopyWith<$Res>
    implements $QueryApiInfoResponseCopyWith<$Res> {
  factory _$$QueryApiInfoResponseImplCopyWith(_$QueryApiInfoResponseImpl value,
          $Res Function(_$QueryApiInfoResponseImpl) then) =
      __$$QueryApiInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, ApiInfo>? data, bool? success});
}

/// @nodoc
class __$$QueryApiInfoResponseImplCopyWithImpl<$Res>
    extends _$QueryApiInfoResponseCopyWithImpl<$Res, _$QueryApiInfoResponseImpl>
    implements _$$QueryApiInfoResponseImplCopyWith<$Res> {
  __$$QueryApiInfoResponseImplCopyWithImpl(_$QueryApiInfoResponseImpl _value,
      $Res Function(_$QueryApiInfoResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? success = freezed,
  }) {
    return _then(_$QueryApiInfoResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, ApiInfo>?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueryApiInfoResponseImpl implements _QueryApiInfoResponse {
  const _$QueryApiInfoResponseImpl(
      {required final Map<String, ApiInfo>? data, required this.success})
      : _data = data;

  factory _$QueryApiInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueryApiInfoResponseImplFromJson(json);

  final Map<String, ApiInfo>? _data;
  @override
  Map<String, ApiInfo>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool? success;

  @override
  String toString() {
    return 'QueryApiInfoResponse(data: $data, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryApiInfoResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), success);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryApiInfoResponseImplCopyWith<_$QueryApiInfoResponseImpl>
      get copyWith =>
          __$$QueryApiInfoResponseImplCopyWithImpl<_$QueryApiInfoResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueryApiInfoResponseImplToJson(
      this,
    );
  }
}

abstract class _QueryApiInfoResponse implements QueryApiInfoResponse {
  const factory _QueryApiInfoResponse(
      {required final Map<String, ApiInfo>? data,
      required final bool? success}) = _$QueryApiInfoResponseImpl;

  factory _QueryApiInfoResponse.fromJson(Map<String, dynamic> json) =
      _$QueryApiInfoResponseImpl.fromJson;

  @override
  Map<String, ApiInfo>? get data;
  @override
  bool? get success;
  @override
  @JsonKey(ignore: true)
  _$$QueryApiInfoResponseImplCopyWith<_$QueryApiInfoResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ApiInfo _$ApiInfoFromJson(Map<String, dynamic> json) {
  return _ApiInfo.fromJson(json);
}

/// @nodoc
mixin _$ApiInfo {
  int? get maxVersion => throw _privateConstructorUsedError;
  int? get minVersion => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get requestFormat => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiInfoCopyWith<ApiInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiInfoCopyWith<$Res> {
  factory $ApiInfoCopyWith(ApiInfo value, $Res Function(ApiInfo) then) =
      _$ApiInfoCopyWithImpl<$Res, ApiInfo>;
  @useResult
  $Res call(
      {int? maxVersion, int? minVersion, String? path, String? requestFormat});
}

/// @nodoc
class _$ApiInfoCopyWithImpl<$Res, $Val extends ApiInfo>
    implements $ApiInfoCopyWith<$Res> {
  _$ApiInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxVersion = freezed,
    Object? minVersion = freezed,
    Object? path = freezed,
    Object? requestFormat = freezed,
  }) {
    return _then(_value.copyWith(
      maxVersion: freezed == maxVersion
          ? _value.maxVersion
          : maxVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      minVersion: freezed == minVersion
          ? _value.minVersion
          : minVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      requestFormat: freezed == requestFormat
          ? _value.requestFormat
          : requestFormat // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiInfoImplCopyWith<$Res> implements $ApiInfoCopyWith<$Res> {
  factory _$$ApiInfoImplCopyWith(
          _$ApiInfoImpl value, $Res Function(_$ApiInfoImpl) then) =
      __$$ApiInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? maxVersion, int? minVersion, String? path, String? requestFormat});
}

/// @nodoc
class __$$ApiInfoImplCopyWithImpl<$Res>
    extends _$ApiInfoCopyWithImpl<$Res, _$ApiInfoImpl>
    implements _$$ApiInfoImplCopyWith<$Res> {
  __$$ApiInfoImplCopyWithImpl(
      _$ApiInfoImpl _value, $Res Function(_$ApiInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxVersion = freezed,
    Object? minVersion = freezed,
    Object? path = freezed,
    Object? requestFormat = freezed,
  }) {
    return _then(_$ApiInfoImpl(
      maxVersion: freezed == maxVersion
          ? _value.maxVersion
          : maxVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      minVersion: freezed == minVersion
          ? _value.minVersion
          : minVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      requestFormat: freezed == requestFormat
          ? _value.requestFormat
          : requestFormat // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiInfoImpl implements _ApiInfo {
  const _$ApiInfoImpl(
      {required this.maxVersion,
      required this.minVersion,
      required this.path,
      this.requestFormat});

  factory _$ApiInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiInfoImplFromJson(json);

  @override
  final int? maxVersion;
  @override
  final int? minVersion;
  @override
  final String? path;
  @override
  final String? requestFormat;

  @override
  String toString() {
    return 'ApiInfo(maxVersion: $maxVersion, minVersion: $minVersion, path: $path, requestFormat: $requestFormat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiInfoImpl &&
            (identical(other.maxVersion, maxVersion) ||
                other.maxVersion == maxVersion) &&
            (identical(other.minVersion, minVersion) ||
                other.minVersion == minVersion) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.requestFormat, requestFormat) ||
                other.requestFormat == requestFormat));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, maxVersion, minVersion, path, requestFormat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiInfoImplCopyWith<_$ApiInfoImpl> get copyWith =>
      __$$ApiInfoImplCopyWithImpl<_$ApiInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiInfoImplToJson(
      this,
    );
  }
}

abstract class _ApiInfo implements ApiInfo {
  const factory _ApiInfo(
      {required final int? maxVersion,
      required final int? minVersion,
      required final String? path,
      final String? requestFormat}) = _$ApiInfoImpl;

  factory _ApiInfo.fromJson(Map<String, dynamic> json) = _$ApiInfoImpl.fromJson;

  @override
  int? get maxVersion;
  @override
  int? get minVersion;
  @override
  String? get path;
  @override
  String? get requestFormat;
  @override
  @JsonKey(ignore: true)
  _$$ApiInfoImplCopyWith<_$ApiInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
