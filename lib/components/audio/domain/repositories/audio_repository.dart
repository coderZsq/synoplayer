import '../../../../base/error/result.dart';
import '../../entities/audio_stream_info.dart';

abstract class AudioRepository {
  Future<Result<AudioStreamInfo>> getAudioStreamUrl(String songId);
}
