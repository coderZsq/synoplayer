// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioPlayerInfoImpl _$$AudioPlayerInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$AudioPlayerInfoImpl(
      currentSongId: json['currentSongId'] as String?,
      currentSongTitle: json['currentSongTitle'] as String?,
      isPlaying: json['isPlaying'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
      position: json['position'] == null
          ? Duration.zero
          : Duration(microseconds: (json['position'] as num).toInt()),
      duration: json['duration'] == null
          ? Duration.zero
          : Duration(microseconds: (json['duration'] as num).toInt()),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$AudioPlayerInfoImplToJson(
        _$AudioPlayerInfoImpl instance) =>
    <String, dynamic>{
      'currentSongId': instance.currentSongId,
      'currentSongTitle': instance.currentSongTitle,
      'isPlaying': instance.isPlaying,
      'isLoading': instance.isLoading,
      'position': instance.position.inMicroseconds,
      'duration': instance.duration.inMicroseconds,
      'error': instance.error,
    };
