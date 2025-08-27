import 'dart:async';
import 'package:just_audio/just_audio.dart';
import '../entities/audio_player_info.dart';

/// 音频播放器状态变化回调
typedef AudioPlayerStateCallback = void Function(AudioPlayerInfo state);

/// 音频播放器服务
/// 负责管理音频播放器的状态和操作
class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // 私有状态
  AudioPlayerInfo _currentState = const AudioPlayerInfo();
  
  // 状态变化回调
  AudioPlayerStateCallback? _onStateChanged;
  
  // 流订阅管理
  late final StreamSubscription<PlayerState> _playerStateSubscription;
  late final StreamSubscription<Duration> _positionSubscription;
  late final StreamSubscription<Duration?> _durationSubscription;

  AudioPlayerService() {
    _initAudioPlayer();
  }

  /// 设置状态变化回调
  void setStateChangedCallback(AudioPlayerStateCallback callback) {
    _onStateChanged = callback;
    // 立即通知当前状态
    _notifyStateChanged();
  }

  /// 移除状态变化回调
  void removeStateChangedCallback() {
    _onStateChanged = null;
  }

  /// 获取当前状态
  AudioPlayerInfo get currentState => _currentState;

  /// 获取音频播放器实例
  AudioPlayer get audioPlayer => _audioPlayer;

  /// 初始化音频播放器
  void _initAudioPlayer() {
    _playerStateSubscription = _audioPlayer.playerStateStream.listen(_handlePlayerStateChange);
    _positionSubscription = _audioPlayer.positionStream.listen(_handlePositionChange);
    _durationSubscription = _audioPlayer.durationStream.listen(_handleDurationChange);
  }

  /// 处理播放器状态变化
  void _handlePlayerStateChange(PlayerState state) {
    final wasPlaying = _currentState.isPlaying;
    final wasLoading = _currentState.isLoading;
    
    final newState = _currentState.copyWith(
      isPlaying: state.playing,
      isLoading: state.processingState == ProcessingState.loading ||
                 state.processingState == ProcessingState.buffering,
      error: null, // 清除之前的错误
    );
    
    // 处理播放完成状态
    if (state.processingState == ProcessingState.completed) {
      _updateState(newState.copyWith(
        isPlaying: false,
        isLoading: false,
      ));
      return;
    }
    
    // 只有在状态真正发生变化时才更新
    if (wasPlaying != newState.isPlaying || wasLoading != newState.isLoading) {
      _updateState(newState);
    }
  }

  /// 处理位置变化
  void _handlePositionChange(Duration position) {
    // 只在位置变化超过500ms时才更新，平衡性能和响应性
    if ((position - _currentState.position).inMilliseconds.abs() > 500) {
      _updateState(_currentState.copyWith(position: position));
    }
  }

  /// 处理时长变化
  void _handleDurationChange(Duration? duration) {
    final newDuration = duration ?? Duration.zero;
    // 只在时长真正发生变化时才更新
    if (newDuration != _currentState.duration && newDuration.inSeconds > 0) {
      _updateState(_currentState.copyWith(duration: newDuration));
    }
  }

  /// 更新状态并通知监听器
  void _updateState(AudioPlayerInfo newState) {
    _currentState = newState;
    _notifyStateChanged();
  }

  /// 通知状态变化
  void _notifyStateChanged() {
    _onStateChanged?.call(_currentState);
  }

  /// 播放歌曲
  Future<void> playSongWithUrl(
    String songId, 
    String songTitle, 
    String audioUrl, 
    {String? authHeaders}
  ) async {
    try {
      // 更新状态为加载中
      _updateState(_currentState.copyWith(
        currentSongId: songId,
        currentSongTitle: songTitle,
        isLoading: true,
        error: null,
      ));

      // 停止当前播放
      await _audioPlayer.stop();
      
      // 设置音频源并播放
      final headers = <String, String>{};
      if (authHeaders != null && authHeaders.isNotEmpty) {
        headers['Cookie'] = authHeaders;
      }
      
      await _audioPlayer.setUrl(audioUrl, headers: headers);
      await _audioPlayer.play();
      
      // 播放成功后，状态会通过监听器自动更新
    } catch (e) {
      _updateState(_currentState.copyWith(
        isLoading: false,
        error: '播放出错: $e',
      ));
    }
  }

  /// 暂停播放
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  /// 恢复播放
  Future<void> resume() async {
    await _audioPlayer.play();
  }

  /// 停止播放
  Future<void> stop() async {
    await _audioPlayer.stop();
    _updateState(_currentState.copyWith(
      currentSongId: null,
      currentSongTitle: null,
      isPlaying: false,
      isLoading: false,
      position: Duration.zero,
      duration: Duration.zero,
      error: null,
    ));
  }

  /// 跳转到指定位置
  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  /// 清理资源
  void dispose() {
    _playerStateSubscription.cancel();
    _positionSubscription.cancel();
    _durationSubscription.cancel();
    _audioPlayer.dispose();
  }
}
