// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_stream_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AudioStreamInfo _$AudioStreamInfoFromJson(Map<String, dynamic> json) {
  return _AudioStreamInfo.fromJson(json);
}

/// @nodoc
mixin _$AudioStreamInfo {
  String get url => throw _privateConstructorUsedError;
  String get authHeader => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioStreamInfoCopyWith<AudioStreamInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStreamInfoCopyWith<$Res> {
  factory $AudioStreamInfoCopyWith(
          AudioStreamInfo value, $Res Function(AudioStreamInfo) then) =
      _$AudioStreamInfoCopyWithImpl<$Res, AudioStreamInfo>;
  @useResult
  $Res call({String url, String authHeader});
}

/// @nodoc
class _$AudioStreamInfoCopyWithImpl<$Res, $Val extends AudioStreamInfo>
    implements $AudioStreamInfoCopyWith<$Res> {
  _$AudioStreamInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? authHeader = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      authHeader: null == authHeader
          ? _value.authHeader
          : authHeader // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioStreamInfoImplCopyWith<$Res>
    implements $AudioStreamInfoCopyWith<$Res> {
  factory _$$AudioStreamInfoImplCopyWith(_$AudioStreamInfoImpl value,
          $Res Function(_$AudioStreamInfoImpl) then) =
      __$$AudioStreamInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String authHeader});
}

/// @nodoc
class __$$AudioStreamInfoImplCopyWithImpl<$Res>
    extends _$AudioStreamInfoCopyWithImpl<$Res, _$AudioStreamInfoImpl>
    implements _$$AudioStreamInfoImplCopyWith<$Res> {
  __$$AudioStreamInfoImplCopyWithImpl(
      _$AudioStreamInfoImpl _value, $Res Function(_$AudioStreamInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? authHeader = null,
  }) {
    return _then(_$AudioStreamInfoImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      authHeader: null == authHeader
          ? _value.authHeader
          : authHeader // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioStreamInfoImpl implements _AudioStreamInfo {
  const _$AudioStreamInfoImpl({required this.url, required this.authHeader});

  factory _$AudioStreamInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioStreamInfoImplFromJson(json);

  @override
  final String url;
  @override
  final String authHeader;

  @override
  String toString() {
    return 'AudioStreamInfo(url: $url, authHeader: $authHeader)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioStreamInfoImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.authHeader, authHeader) ||
                other.authHeader == authHeader));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, authHeader);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioStreamInfoImplCopyWith<_$AudioStreamInfoImpl> get copyWith =>
      __$$AudioStreamInfoImplCopyWithImpl<_$AudioStreamInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioStreamInfoImplToJson(
      this,
    );
  }
}

abstract class _AudioStreamInfo implements AudioStreamInfo {
  const factory _AudioStreamInfo(
      {required final String url,
      required final String authHeader}) = _$AudioStreamInfoImpl;

  factory _AudioStreamInfo.fromJson(Map<String, dynamic> json) =
      _$AudioStreamInfoImpl.fromJson;

  @override
  String get url;
  @override
  String get authHeader;
  @override
  @JsonKey(ignore: true)
  _$$AudioStreamInfoImplCopyWith<_$AudioStreamInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
