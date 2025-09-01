import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_player_info.freezed.dart';
part 'audio_player_info.g.dart';

@freezed
class AudioPlayerInfo with _$AudioPlayerInfo {
  const factory AudioPlayerInfo({
    String? currentSongId,
    String? currentSongTitle,
    @Default(false) bool isPlaying,
    @Default(false) bool isLoading,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration duration,
    @Default(1.0) double playbackSpeed,
    String? error,
  }) = _AudioPlayerInfo;

  factory AudioPlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioPlayerInfoFromJson(json);
}
