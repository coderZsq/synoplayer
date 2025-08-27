import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_stream_info.freezed.dart';
part 'audio_stream_info.g.dart';

@freezed
class AudioStreamInfo with _$AudioStreamInfo {
  const factory AudioStreamInfo({
    required String url,
    required String authHeader,
  }) = _AudioStreamInfo;

  factory AudioStreamInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioStreamInfoFromJson(json);
}
