import '../../domain/usecases/get_audio_list_usecase.dart';
import '../../domain/usecases/play_audio_usecase.dart';
import '../../../../../base/error/result.dart';
import '../../entities/audio_player/audio_player_info.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import 'audio_player_service.dart';

class AudioService {
  final GetAudioListUseCase _getSongListUseCase;
  final PlayAudioUseCase _playSongUseCase;
  final AudioPlayerService _audioPlayerService;
  AudioPlayerStateCallback? _onStateChanged;

  AudioService(this._getSongListUseCase, this._playSongUseCase, this._audioPlayerService) {
    // 设置状态变化回调
    _audioPlayerService.setStateChangedCallback((state) {
      _onStateChanged?.call(state);
    });
  }

  /// 设置状态变化回调
  void setStateChangedCallback(AudioPlayerStateCallback callback) {
    _onStateChanged = callback;
  }

  /// 获取歌曲列表
  Future<Result<SongListAllResponse>> getSongList({
    int offset = 0,
    int limit = 20,
  }) async {
    return await _getSongListUseCase(
      offset: offset,
      limit: limit,
    );
  }

  /// 播放歌曲
  Future<Result<void>> playSong(String songId, String songTitle) async {
    final result = await _playSongUseCase(songId);
    
    if (result.isSuccess) {
      final audioInfo = result.value;
      await _audioPlayerService.playSongWithUrl(
        songId,
        songTitle,
        audioInfo.url,
        authHeaders: audioInfo.authHeader,
      );
      return const Success(null);
    } else {
      return Failure(result.error);
    }
  }

  /// 暂停播放
  Future<void> pause() async {
    await _audioPlayerService.pause();
  }

  /// 恢复播放
  Future<void> resume() async {
    await _audioPlayerService.resume();
  }

  /// 停止播放
  Future<void> stop() async {
    await _audioPlayerService.stop();
  }

  /// 跳转到指定位置
  Future<void> seekTo(Duration position) async {
    await _audioPlayerService.seekTo(position);
  }

  /// 获取当前播放状态
  AudioPlayerInfo getCurrentState() {
    return _audioPlayerService.currentState;
  }
}
