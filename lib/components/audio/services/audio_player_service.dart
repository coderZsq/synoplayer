import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../../../base/network/interceptors/cookie_interceptor.dart';
import '../../../quickconnect/data/datasources/quick_connect_api_info.dart';
import '../../../quickconnect/presentation/services/quickconnect_service.dart';
import '../../../quickconnect/domain/services/connection_manager.dart';

class AudioPlayerService extends ChangeNotifier {
  final QuickConnectService _quickConnectService;
  final ConnectionManager _connectionManager;
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  String? _currentSongId;
  String? _currentSongTitle;
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  String? _error;

  AudioPlayerService(this._quickConnectService, this._connectionManager) {
    _initAudioPlayer();
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

  void _initAudioPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      _isLoading = state.processingState == ProcessingState.loading ||
                   state.processingState == ProcessingState.buffering;
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _isPlaying = false;
        notifyListeners();
      }
    });
  }

  Future<void> playSong(String songId, String songTitle) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // 停止当前播放
      await _audioPlayer.stop();
      
      // 检查连接状态和baseUrl
      if (!_connectionManager.connected) {
        _error = '未连接到服务器，请先登录';
        return;
      }
      
      final baseUrl = _connectionManager.baseUrl;
      if (baseUrl == null || baseUrl.isEmpty) {
        _error = '无法获取服务器地址';
        return;
      }
      final apiInfo = QuickConnectApiInfo();
      // 构建完整的音频流URL，使用ConnectionManager中的baseUrl
      final audioUrl = '$baseUrl/webapi/AudioStation/stream.cgi?api=${apiInfo.stream}&method=stream&id=$songId&seek_position=0&version=${apiInfo.streamVersion}';
      
      if (audioUrl.isNotEmpty) {
        _currentSongId = songId;
        _currentSongTitle = songTitle;

        // 设置音频源并播放
        await _audioPlayer.setUrl(audioUrl, headers: {
            'Cookie': 'id=${CookieInterceptor.getSessionId()}'
        });
        await _audioPlayer.play();
      }
    } catch (e) {
      _error = '播放出错: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
    notifyListeners();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
