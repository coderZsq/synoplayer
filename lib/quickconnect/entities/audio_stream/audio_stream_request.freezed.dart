// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_stream_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AudioStreamRequest _$AudioStreamRequestFromJson(Map<String, dynamic> json) {
  return _AudioStreamRequest.fromJson(json);
}

/// @nodoc
mixin _$AudioStreamRequest {
  String get api => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  int get seekPosition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioStreamRequestCopyWith<AudioStreamRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStreamRequestCopyWith<$Res> {
  factory $AudioStreamRequestCopyWith(
          AudioStreamRequest value, $Res Function(AudioStreamRequest) then) =
      _$AudioStreamRequestCopyWithImpl<$Res, AudioStreamRequest>;
  @useResult
  $Res call(
      {String api, String method, String version, String id, int seekPosition});
}

/// @nodoc
class _$AudioStreamRequestCopyWithImpl<$Res, $Val extends AudioStreamRequest>
    implements $AudioStreamRequestCopyWith<$Res> {
  _$AudioStreamRequestCopyWithImpl(this._value, this._then);

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
    Object? id = null,
    Object? seekPosition = null,
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
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      seekPosition: null == seekPosition
          ? _value.seekPosition
          : seekPosition // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioStreamRequestImplCopyWith<$Res>
    implements $AudioStreamRequestCopyWith<$Res> {
  factory _$$AudioStreamRequestImplCopyWith(_$AudioStreamRequestImpl value,
          $Res Function(_$AudioStreamRequestImpl) then) =
      __$$AudioStreamRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String api, String method, String version, String id, int seekPosition});
}

/// @nodoc
class __$$AudioStreamRequestImplCopyWithImpl<$Res>
    extends _$AudioStreamRequestCopyWithImpl<$Res, _$AudioStreamRequestImpl>
    implements _$$AudioStreamRequestImplCopyWith<$Res> {
  __$$AudioStreamRequestImplCopyWithImpl(_$AudioStreamRequestImpl _value,
      $Res Function(_$AudioStreamRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? api = null,
    Object? method = null,
    Object? version = null,
    Object? id = null,
    Object? seekPosition = null,
  }) {
    return _then(_$AudioStreamRequestImpl(
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
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      seekPosition: null == seekPosition
          ? _value.seekPosition
          : seekPosition // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioStreamRequestImpl implements _AudioStreamRequest {
  const _$AudioStreamRequestImpl(
      {required this.api,
      required this.method,
      required this.version,
      required this.id,
      required this.seekPosition});

  factory _$AudioStreamRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioStreamRequestImplFromJson(json);

  @override
  final String api;
  @override
  final String method;
  @override
  final String version;
  @override
  final String id;
  @override
  final int seekPosition;

  @override
  String toString() {
    return 'AudioStreamRequest(api: $api, method: $method, version: $version, id: $id, seekPosition: $seekPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioStreamRequestImpl &&
            (identical(other.api, api) || other.api == api) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seekPosition, seekPosition) ||
                other.seekPosition == seekPosition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, api, method, version, id, seekPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioStreamRequestImplCopyWith<_$AudioStreamRequestImpl> get copyWith =>
      __$$AudioStreamRequestImplCopyWithImpl<_$AudioStreamRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioStreamRequestImplToJson(
      this,
    );
  }
}

abstract class _AudioStreamRequest implements AudioStreamRequest {
  const factory _AudioStreamRequest(
      {required final String api,
      required final String method,
      required final String version,
      required final String id,
      required final int seekPosition}) = _$AudioStreamRequestImpl;

  factory _AudioStreamRequest.fromJson(Map<String, dynamic> json) =
      _$AudioStreamRequestImpl.fromJson;

  @override
  String get api;
  @override
  String get method;
  @override
  String get version;
  @override
  String get id;
  @override
  int get seekPosition;
  @override
  @JsonKey(ignore: true)
  _$$AudioStreamRequestImplCopyWith<_$AudioStreamRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
