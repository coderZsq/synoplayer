// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_player_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AudioPlayerInfo _$AudioPlayerInfoFromJson(Map<String, dynamic> json) {
  return _AudioPlayerInfo.fromJson(json);
}

/// @nodoc
mixin _$AudioPlayerInfo {
  String? get currentSongId => throw _privateConstructorUsedError;
  String? get currentSongTitle => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioPlayerInfoCopyWith<AudioPlayerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioPlayerInfoCopyWith<$Res> {
  factory $AudioPlayerInfoCopyWith(
          AudioPlayerInfo value, $Res Function(AudioPlayerInfo) then) =
      _$AudioPlayerInfoCopyWithImpl<$Res, AudioPlayerInfo>;
  @useResult
  $Res call(
      {String? currentSongId,
      String? currentSongTitle,
      bool isPlaying,
      bool isLoading,
      Duration position,
      Duration duration,
      String? error});
}

/// @nodoc
class _$AudioPlayerInfoCopyWithImpl<$Res, $Val extends AudioPlayerInfo>
    implements $AudioPlayerInfoCopyWith<$Res> {
  _$AudioPlayerInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSongId = freezed,
    Object? currentSongTitle = freezed,
    Object? isPlaying = null,
    Object? isLoading = null,
    Object? position = null,
    Object? duration = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      currentSongId: freezed == currentSongId
          ? _value.currentSongId
          : currentSongId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentSongTitle: freezed == currentSongTitle
          ? _value.currentSongTitle
          : currentSongTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioPlayerInfoImplCopyWith<$Res>
    implements $AudioPlayerInfoCopyWith<$Res> {
  factory _$$AudioPlayerInfoImplCopyWith(_$AudioPlayerInfoImpl value,
          $Res Function(_$AudioPlayerInfoImpl) then) =
      __$$AudioPlayerInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? currentSongId,
      String? currentSongTitle,
      bool isPlaying,
      bool isLoading,
      Duration position,
      Duration duration,
      String? error});
}

/// @nodoc
class __$$AudioPlayerInfoImplCopyWithImpl<$Res>
    extends _$AudioPlayerInfoCopyWithImpl<$Res, _$AudioPlayerInfoImpl>
    implements _$$AudioPlayerInfoImplCopyWith<$Res> {
  __$$AudioPlayerInfoImplCopyWithImpl(
      _$AudioPlayerInfoImpl _value, $Res Function(_$AudioPlayerInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSongId = freezed,
    Object? currentSongTitle = freezed,
    Object? isPlaying = null,
    Object? isLoading = null,
    Object? position = null,
    Object? duration = null,
    Object? error = freezed,
  }) {
    return _then(_$AudioPlayerInfoImpl(
      currentSongId: freezed == currentSongId
          ? _value.currentSongId
          : currentSongId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentSongTitle: freezed == currentSongTitle
          ? _value.currentSongTitle
          : currentSongTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioPlayerInfoImpl implements _AudioPlayerInfo {
  const _$AudioPlayerInfoImpl(
      {this.currentSongId,
      this.currentSongTitle,
      this.isPlaying = false,
      this.isLoading = false,
      this.position = Duration.zero,
      this.duration = Duration.zero,
      this.error});

  factory _$AudioPlayerInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioPlayerInfoImplFromJson(json);

  @override
  final String? currentSongId;
  @override
  final String? currentSongTitle;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final Duration position;
  @override
  @JsonKey()
  final Duration duration;
  @override
  final String? error;

  @override
  String toString() {
    return 'AudioPlayerInfo(currentSongId: $currentSongId, currentSongTitle: $currentSongTitle, isPlaying: $isPlaying, isLoading: $isLoading, position: $position, duration: $duration, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioPlayerInfoImpl &&
            (identical(other.currentSongId, currentSongId) ||
                other.currentSongId == currentSongId) &&
            (identical(other.currentSongTitle, currentSongTitle) ||
                other.currentSongTitle == currentSongTitle) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentSongId, currentSongTitle,
      isPlaying, isLoading, position, duration, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioPlayerInfoImplCopyWith<_$AudioPlayerInfoImpl> get copyWith =>
      __$$AudioPlayerInfoImplCopyWithImpl<_$AudioPlayerInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioPlayerInfoImplToJson(
      this,
    );
  }
}

abstract class _AudioPlayerInfo implements AudioPlayerInfo {
  const factory _AudioPlayerInfo(
      {final String? currentSongId,
      final String? currentSongTitle,
      final bool isPlaying,
      final bool isLoading,
      final Duration position,
      final Duration duration,
      final String? error}) = _$AudioPlayerInfoImpl;

  factory _AudioPlayerInfo.fromJson(Map<String, dynamic> json) =
      _$AudioPlayerInfoImpl.fromJson;

  @override
  String? get currentSongId;
  @override
  String? get currentSongTitle;
  @override
  bool get isPlaying;
  @override
  bool get isLoading;
  @override
  Duration get position;
  @override
  Duration get duration;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$AudioPlayerInfoImplCopyWith<_$AudioPlayerInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
