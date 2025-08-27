import '../../../../base/error/result.dart';
import '../../../../base/error/exceptions.dart';
import '../repositories/audio_repository.dart';
import '../../services/audio_player_service.dart';
import '../../data/datasources/audio_datasource.dart';

class PlaySongUseCase {
  final AudioRepository _audioRepository;
  final AudioPlayerService _audioPlayerService;
  final AudioDatasource _audioDatasource;

  PlaySongUseCase(this._audioRepository, this._audioPlayerService, this._audioDatasource);

  Future<Result<void>> execute(String songId, String songTitle) async {
    try {
      // 获取音频流URL
      final urlResult = await _audioRepository.getAudioStreamUrl(songId);
      if (urlResult.isFailure) {
        return urlResult.mapError((_) => urlResult.error);
      }

      final audioUrl = urlResult.value;
      final authHeaders = _audioDatasource.getAuthHeaders();
      
      // 调用音频服务播放
      await _audioPlayerService.playSongWithUrl(songId, songTitle, audioUrl, authHeaders: authHeaders);
      
      return const Success(null);
    } catch (e) {
      return Failure(BusinessException('播放歌曲失败: $e'));
    }
  }
}
