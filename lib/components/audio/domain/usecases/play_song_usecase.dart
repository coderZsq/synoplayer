import '../../../../base/error/result.dart';
import '../../../../base/error/exceptions.dart';
import '../repositories/audio_repository.dart';
import '../../data/datasources/audio_datasource.dart';

class PlaySongUseCase {
  final AudioRepository _audioRepository;
  final AudioDatasource _audioDatasource;

  PlaySongUseCase(this._audioRepository, this._audioDatasource);

  Future<Result<Map<String, dynamic>>> execute(String songId, String songTitle) async {
    try {
      // 获取音频流URL
      final urlResult = await _audioRepository.getAudioStreamUrl(songId);
      if (urlResult.isFailure) {
        return Failure(urlResult.error);
      }

      final audioUrl = urlResult.value;
      final authHeaders = _audioDatasource.getAuthHeaders();
      
      // 返回音频URL和认证头，由service层处理播放
      return Success({
        'songId': songId,
        'songTitle': songTitle,
        'audioUrl': audioUrl,
        'authHeaders': authHeaders,
      });
    } catch (e) {
      return Failure(BusinessException('播放歌曲失败: $e'));
    }
  }
}
