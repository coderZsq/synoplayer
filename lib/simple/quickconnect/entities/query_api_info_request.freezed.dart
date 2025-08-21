// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_api_info_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QueryApiInfoRequest _$QueryApiInfoRequestFromJson(Map<String, dynamic> json) {
  return _QueryApiInfoRequest.fromJson(json);
}

/// @nodoc
mixin _$QueryApiInfoRequest {
  String get api => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QueryApiInfoRequestCopyWith<QueryApiInfoRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryApiInfoRequestCopyWith<$Res> {
  factory $QueryApiInfoRequestCopyWith(
          QueryApiInfoRequest value, $Res Function(QueryApiInfoRequest) then) =
      _$QueryApiInfoRequestCopyWithImpl<$Res, QueryApiInfoRequest>;
  @useResult
  $Res call({String api, String method, String version});
}

/// @nodoc
class _$QueryApiInfoRequestCopyWithImpl<$Res, $Val extends QueryApiInfoRequest>
    implements $QueryApiInfoRequestCopyWith<$Res> {
  _$QueryApiInfoRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? api = null,
    Object? method = null,
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
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueryApiInfoRequestImplCopyWith<$Res>
    implements $QueryApiInfoRequestCopyWith<$Res> {
  factory _$$QueryApiInfoRequestImplCopyWith(_$QueryApiInfoRequestImpl value,
          $Res Function(_$QueryApiInfoRequestImpl) then) =
      __$$QueryApiInfoRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String api, String method, String version});
}

/// @nodoc
class __$$QueryApiInfoRequestImplCopyWithImpl<$Res>
    extends _$QueryApiInfoRequestCopyWithImpl<$Res, _$QueryApiInfoRequestImpl>
    implements _$$QueryApiInfoRequestImplCopyWith<$Res> {
  __$$QueryApiInfoRequestImplCopyWithImpl(_$QueryApiInfoRequestImpl _value,
      $Res Function(_$QueryApiInfoRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? api = null,
    Object? method = null,
    Object? version = null,
  }) {
    return _then(_$QueryApiInfoRequestImpl(
      api: null == api
          ? _value.api
          : api // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueryApiInfoRequestImpl implements _QueryApiInfoRequest {
  const _$QueryApiInfoRequestImpl(
      {required this.api, required this.method, required this.version});

  factory _$QueryApiInfoRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueryApiInfoRequestImplFromJson(json);

  @override
  final String api;
  @override
  final String method;
  @override
  final String version;

  @override
  String toString() {
    return 'QueryApiInfoRequest(api: $api, method: $method, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryApiInfoRequestImpl &&
            (identical(other.api, api) || other.api == api) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, api, method, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryApiInfoRequestImplCopyWith<_$QueryApiInfoRequestImpl> get copyWith =>
      __$$QueryApiInfoRequestImplCopyWithImpl<_$QueryApiInfoRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueryApiInfoRequestImplToJson(
      this,
    );
  }
}

abstract class _QueryApiInfoRequest implements QueryApiInfoRequest {
  const factory _QueryApiInfoRequest(
      {required final String api,
      required final String method,
      required final String version}) = _$QueryApiInfoRequestImpl;

  factory _QueryApiInfoRequest.fromJson(Map<String, dynamic> json) =
      _$QueryApiInfoRequestImpl.fromJson;

  @override
  String get api;
  @override
  String get method;
  @override
  String get version;
  @override
  @JsonKey(ignore: true)
  _$$QueryApiInfoRequestImplCopyWith<_$QueryApiInfoRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
