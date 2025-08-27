import '../../../../base/error/result.dart';
import '../../../../base/error/exceptions.dart';
import '../repositories/audio_repository.dart';
import '../../entities/audio_stream/audio_stream_info.dart';

class PlayAudioUseCase {
  final AudioRepository _audioRepository;

  PlayAudioUseCase(this._audioRepository);

  Future<Result<AudioStreamInfo>> call(String songId) async {
    try {
      // 获取音频流信息（包含URL和认证头）
      final audioInfoResult = await _audioRepository.getAudioStreamUrl(songId);
      if (audioInfoResult.isFailure) {
        return Failure(audioInfoResult.error);
      }

      return audioInfoResult;
    } catch (e) {
      return Failure(BusinessException('播放歌曲失败: $e'));
    }
  }
}
