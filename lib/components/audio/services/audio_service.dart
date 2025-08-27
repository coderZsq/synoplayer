import 'package:flutter/foundation.dart';
import '../domain/usecases/play_song_usecase.dart';
import '../../../../base/error/result.dart';
import 'audio_player_service.dart';
import '../entities/audio_player_info.dart';

class AudioService {
  final PlaySongUseCase _playSongUseCase;
  final AudioPlayerService _audioPlayerService;
  VoidCallback? _onStateChanged;

  AudioService(this._playSongUseCase, this._audioPlayerService) {
    // 设置状态变化回调
    _audioPlayerService.setStateChangedCallback(() {
      _onStateChanged?.call();
    });
  }

  /// 设置状态变化回调
  void setStateChangedCallback(VoidCallback callback) {
    _onStateChanged = callback;
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
