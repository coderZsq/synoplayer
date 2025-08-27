import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../base/di/providers.dart';
import '../services/audio_service.dart';
import '../../entities/audio_player_info.dart';

part 'audio_player_provider.g.dart';

@riverpod
class AudioPlayerNotifier extends _$AudioPlayerNotifier {
  late final AudioService _audioService;
  Timer? _stateUpdateTimer;
  bool _isTimerActive = false;
  
  @override
  FutureOr<AudioPlayerInfo> build() async {
    _audioService = ref.read(audioServiceProvider);
    
    // 设置状态变化回调
    _audioService.setStateChangedCallback((state) {
      _updateState();
    });
    
    // 返回初始状态
    return _audioService.getCurrentState();
  }

  void _startStateUpdateTimer() {
    if (_isTimerActive) return;
    
    _isTimerActive = true;
    _stateUpdateTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!_isTimerActive) {
        timer.cancel();
        return;
      }
      _updateState();
    });
  }

  void _stopStateUpdateTimer() {
    _isTimerActive = false;
    _stateUpdateTimer?.cancel();
    _stateUpdateTimer = null;
  }

  Future<void> playSong(String songId, String songTitle) async {
    final result = await _audioService.playSong(songId, songTitle);
    if (result.isFailure) {
      // 处理错误状态
      print('播放歌曲失败: ${result.error}');
      state = AsyncValue.error(result.error, StackTrace.current);
    } else {
      // 播放成功后启动定时器
      _startStateUpdateTimer();
      // 立即更新一次状态
      _updateState();
    }
  }

  Future<void> pause() async {
    await _audioService.pause();
    _updateState();
  }

  Future<void> resume() async {
    await _audioService.resume();
    // 恢复播放时重新启动定时器
    _startStateUpdateTimer();
    _updateState();
  }

  Future<void> stop() async {
    await _audioService.stop();
    // 停止播放时停止定时器
    _stopStateUpdateTimer();
    _updateState();
  }

  Future<void> seekTo(Duration position) async {
    await _audioService.seekTo(position);
  }

  // 更新状态 - 从 AudioService 获取当前状态
  void _updateState() {
    final currentState = _audioService.getCurrentState();
    
    // 如果播放完成且没有在加载，停止定时器
    if (!currentState.isPlaying && !currentState.isLoading && currentState.currentSongId != null) {
      _stopStateUpdateTimer();
    }
    
    state = AsyncValue.data(currentState);
  }

  // 清理资源
  void dispose() {
    _stopStateUpdateTimer();
  }
}
