import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../base/di/providers.dart';
import '../services/audio_player_service.dart';
import '../domain/usecases/play_song_usecase.dart';
import '../data/repositories/audio_repository_impl.dart';
import '../data/datasources/audio_datasource.dart';

part 'audio_player_provider.g.dart';

// 音频播放状态数据类
class AudioPlayerState {
  final String? currentSongId;
  final String? currentSongTitle;
  final bool isPlaying;
  final bool isLoading;
  final Duration position;
  final Duration duration;
  final String? error;

  const AudioPlayerState({
    this.currentSongId,
    this.currentSongTitle,
    this.isPlaying = false,
    this.isLoading = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.error,
  });

  AudioPlayerState copyWith({
    String? currentSongId,
    String? currentSongTitle,
    bool? isPlaying,
    bool? isLoading,
    Duration? position,
    Duration? duration,
    String? error,
  }) {
    return AudioPlayerState(
      currentSongId: currentSongId ?? this.currentSongId,
      currentSongTitle: currentSongTitle ?? this.currentSongTitle,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      error: error ?? this.error,
    );
  }
}

@riverpod
class AudioPlayerNotifier extends _$AudioPlayerNotifier {
  late final AudioPlayerService _audioPlayerService;
  late final PlaySongUseCase _playSongUseCase;
  bool _callbackSet = false;
  
  @override
  AudioPlayerState build() {
    _audioPlayerService = ref.read(audioPlayerServiceProvider);
    
    // 创建依赖
    final connectionManager = ref.read(connectionManagerProvider);
    final audioDatasource = AudioDatasource(connectionManager);
    final audioRepository = AudioRepositoryImpl(audioDatasource);
    _playSongUseCase = PlaySongUseCase(audioRepository, _audioPlayerService, audioDatasource);
    
    // 只在第一次设置状态变化回调，避免重复设置
    if (!_callbackSet) {
      _audioPlayerService.setStateChangedCallback(() {
        _updateState();
      });
      _callbackSet = true;
    }
    
    return const AudioPlayerState();
  }

  // 更新状态
  void _updateState() {
    state = AudioPlayerState(
      currentSongId: _audioPlayerService.currentSongId,
      currentSongTitle: _audioPlayerService.currentSongTitle,
      isPlaying: _audioPlayerService.isPlaying,
      isLoading: _audioPlayerService.isLoading,
      position: _audioPlayerService.position,
      duration: _audioPlayerService.duration,
      error: _audioPlayerService.error,
    );
  }

  Future<void> playSong(String songId, String songTitle) async {
    final result = await _playSongUseCase.execute(songId, songTitle);
    if (result.isFailure) {
      // 处理错误状态
      print('播放歌曲失败: ${result.error}');
    }
    _updateState();
  }

  Future<void> pause() async {
    await _audioPlayerService.pause();
    _updateState();
  }

  Future<void> resume() async {
    await _audioPlayerService.resume();
    _updateState();
  }

  Future<void> stop() async {
    await _audioPlayerService.stop();
    _updateState();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayerService.seekTo(position);
  }
}
