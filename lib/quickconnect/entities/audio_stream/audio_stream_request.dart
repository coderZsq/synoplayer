import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_stream_request.freezed.dart';
part 'audio_stream_request.g.dart';

@freezed
class AudioStreamRequest with _$AudioStreamRequest {
  const factory AudioStreamRequest({
    required String api,
    required String method,
    required String version,
    required String id,
    required int seekPosition,
  }) = _AudioStreamRequest;

  @override
  Map<String, dynamic> toJson() {
    return {
      'api': api,
      'method': method,
      'id': id,
      'seekPosition': seekPosition,
      'version': version,
    };
  }

  factory AudioStreamRequest.fromJson(Map<String, dynamic> json) =>
      _$AudioStreamRequestFromJson(json);
}
