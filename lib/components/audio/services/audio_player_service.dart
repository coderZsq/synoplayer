import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../../../quickconnect/presentation/services/quickconnect_service.dart';

class AudioPlayerService extends ChangeNotifier {
  final QuickConnectService _quickConnectService;
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  String? _currentSongId;
  String? _currentSongTitle;
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  String? _error;

  AudioPlayerService(this._quickConnectService) {
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

      // 获取音频流
      final result = await _quickConnectService.getAudioStream(id: songId);
      
      if (result.isSuccess) {
        final response = result.value;
        
        // 音频流接口直接返回音频数据，不需要解析JSON
        // 直接使用响应的URL作为音频源
        final audioUrl = response.requestOptions.uri.toString();
        
        if (audioUrl.isNotEmpty) {
          _currentSongId = songId;
          _currentSongTitle = songTitle;
          
          // 设置音频源并播放
          await _audioPlayer.setUrl(audioUrl);
          await _audioPlayer.play();
        } else {
          _error = '无法获取音频URL';
        }
      } else {
        _error = result.error?.message ?? '播放失败';
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
