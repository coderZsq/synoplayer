import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../../../base/network/interceptors/cookie_interceptor.dart';
import '../../../quickconnect/data/datasources/quick_connect_api_info.dart';
import '../../../quickconnect/domain/services/connection_manager.dart';

class AudioPlayerService {
  final ConnectionManager _connectionManager;
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  String? _currentSongId;
  String? _currentSongTitle;
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  String? _error;
  
  // 状态变化回调
  VoidCallback? _onStateChanged;

  AudioPlayerService(this._connectionManager) {
    _initAudioPlayer();
  }

  // 设置状态变化回调
  void setStateChangedCallback(VoidCallback callback) {
    print('AudioPlayerService - 设置状态变化回调');
    _onStateChanged = callback;
  }

  // 通知状态变化
  void _notifyStateChanged() {
    print('AudioPlayerService - _notifyStateChanged() 被调用，_onStateChanged: ${_onStateChanged != null}');
    _onStateChanged?.call();
  }

  // Getters
  String? get currentSongId => _currentSongId;
  String? get currentSongTitle => _currentSongTitle;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  Duration get position => _position;
  Duration get duration => _duration;
  String? get error => _error;
  AudioPlayer get audioPlayer => _audioPlayer;

  // 获取当前状态的快照
  Map<String, dynamic> get currentState => {
    'currentSongId': _currentSongId,
    'currentSongTitle': _currentSongTitle,
    'isPlaying': _isPlaying,
    'isLoading': _isLoading,
    'position': _position,
    'duration': _duration,
    'error': _error,
  };

  void _initAudioPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      final wasPlaying = _isPlaying;
      final wasLoading = _isLoading;
      
      _isPlaying = state.playing;
      _isLoading = state.processingState == ProcessingState.loading ||
                   state.processingState == ProcessingState.buffering;
      
      print('AudioPlayerService - 播放状态变化: playing=$_isPlaying, loading=$_isLoading, processingState=${state.processingState}');
      
      // 只有在状态真正发生变化时才通知
      if (wasPlaying != _isPlaying || wasLoading != _isLoading) {
        print('AudioPlayerService - 状态变化，通知监听器: playing=$_isPlaying, loading=$_isLoading');
        _notifyStateChanged();
      }
      
      // 处理播放完成状态
      if (state.processingState == ProcessingState.completed) {
        _isPlaying = false;
        _isLoading = false;
        print('AudioPlayerService - 播放完成');
        _notifyStateChanged();
      }
    });

    // 重新启用监听器，但使用更保守的更新策略
    _audioPlayer.positionStream.listen((position) {
      // 只在位置变化超过500ms时才更新，平衡性能和响应性
      if ((position - _position).inMilliseconds.abs() > 500) {
        _position = position;
        _notifyStateChanged();
      }
    });

    _audioPlayer.durationStream.listen((duration) {
      final newDuration = duration ?? Duration.zero;
      // 只在时长真正发生变化时才更新
      if (newDuration != _duration && newDuration.inSeconds > 0) {
        _duration = newDuration;
        _notifyStateChanged();
      }
    });
  }

  Future<void> playSong(String songId, String songTitle) async {
    try {
      print('AudioPlayerService - 开始播放歌曲: $songTitle (ID: $songId)');
      _isLoading = true;
      _error = null;
      _currentSongId = songId;
      _currentSongTitle = songTitle;
      print('AudioPlayerService - 设置状态: currentSongTitle=$_currentSongTitle, isLoading=$_isLoading');
      _notifyStateChanged();
      // notifyListeners(); // Removed ChangeNotifier dependency

      // 停止当前播放
      await _audioPlayer.stop();
      
      // 检查连接状态和baseUrl
      if (!_connectionManager.connected) {
        _error = '未连接到服务器，请先登录';
        _isLoading = false;
        print('AudioPlayerService - 连接错误: $_error');
        _notifyStateChanged();
        return;
      }
      
      final baseUrl = _connectionManager.baseUrl;
      if (baseUrl == null || baseUrl.isEmpty) {
        _error = '无法获取服务器地址';
        _isLoading = false;
        print('AudioPlayerService - baseUrl 错误: $_error');
        _notifyStateChanged();
        return;
      }
      
      final apiInfo = QuickConnectApiInfo();
      // 构建完整的音频流URL，使用ConnectionManager中的baseUrl
      final audioUrl = '$baseUrl/webapi/AudioStation/stream.cgi?api=${apiInfo.stream}&method=stream&id=$songId&seek_position=0&version=${apiInfo.streamVersion}';
      
      print('AudioPlayerService - 音频URL: $audioUrl');
      
      if (audioUrl.isNotEmpty) {
        // 设置音频源并播放
        await _audioPlayer.setUrl(audioUrl, headers: {
            'Cookie': 'id=${CookieInterceptor.getSessionId()}'
        });
        await _audioPlayer.play();
        
        print('AudioPlayerService - 音频播放已启动');
        // 播放成功后，状态会通过 _initAudioPlayer 中的监听器自动更新
      }
    } catch (e) {
      _error = '播放出错: $e';
      _isLoading = false;
      print('AudioPlayerService - 播放异常: $_error');
      _notifyStateChanged();
    }
    // 移除 finally 块，让状态通过监听器自动管理
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentSongId = null;
    _currentSongTitle = null;
    _isPlaying = false;
    _notifyStateChanged();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
