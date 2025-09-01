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
  
  // 当前播放列表和索引
  List<String> _currentPlaylist = [];
  int _currentIndex = -1;
  
  // 歌曲信息映射
  Map<String, String> _songTitles = {};
  
  // 防止重复触发播放完成的标志
  bool _isAutoPlayingNext = false;

  AudioService(this._getSongListUseCase, this._playSongUseCase, this._audioPlayerService) {
    // 设置状态变化回调
    _audioPlayerService.setStateChangedCallback((state) {
      _onStateChanged?.call(state);
    });
    
    // 设置播放完成回调
    _audioPlayerService.setCompletedCallback(_onSongCompleted);
  }

  /// 设置状态变化回调
  void setStateChangedCallback(AudioPlayerStateCallback callback) {
    _onStateChanged = callback;
  }

  /// 播放完成后的处理
  void _onSongCompleted(String songId) async {
    print('🎵 播放完成回调被触发: songId=$songId, _isAutoPlayingNext=$_isAutoPlayingNext');
    
    // 防止重复触发
    if (_isAutoPlayingNext) {
      print('🚫 自动播放进行中，跳过重复触发');
      return;
    }
    
    // 如果当前歌曲在播放列表中，自动播放下一首
    if (_currentPlaylist.isNotEmpty && _currentIndex >= 0) {
      final nextIndex = _getNextSongIndex();
      print('📋 播放列表信息: 总数=${_currentPlaylist.length}, 当前索引=$_currentIndex, 下一首索引=$nextIndex');
      
      if (nextIndex >= 0) {
        print('▶️ 开始自动播放下一首');
        _isAutoPlayingNext = true;
        try {
          await _playNextSong(nextIndex);
        } catch (e) {
          print('❌ 自动播放下一首失败: $e');
        } finally {
          _isAutoPlayingNext = false;
          print('✅ 自动播放完成，重置标志');
        }
      } else {
        print('⚠️ 无法获取下一首索引');
      }
    } else {
      print('⚠️ 播放列表为空或当前索引无效: 播放列表长度=${_currentPlaylist.length}, 当前索引=$_currentIndex');
    }
  }

  /// 获取下一首歌曲的索引
  int _getNextSongIndex() {
    if (_currentPlaylist.isEmpty) return -1;
    
    // 循环播放：到达列表末尾时回到第一首
    final nextIndex = (_currentIndex + 1) % _currentPlaylist.length;
    return nextIndex;
  }

  /// 获取上一首歌曲的索引
  int _getPreviousSongIndex() {
    if (_currentPlaylist.isEmpty) return -1;
    
    // 循环播放：到达列表开头时回到最后一首
    final prevIndex = (_currentIndex - 1 + _currentPlaylist.length) % _currentPlaylist.length;
    return prevIndex;
  }

  /// 播放下一首歌曲
  Future<void> _playNextSong(int index) async {
    print('🎯 _playNextSong 被调用: index=$index, 播放列表长度=${_currentPlaylist.length}');
    
    if (index < 0 || index >= _currentPlaylist.length) {
      print('❌ 索引无效: index=$index');
      return;
    }
    
    // 获取歌曲信息并播放
    final songId = _currentPlaylist[index];
    final songTitle = await _getSongTitle(songId);
    print('🎵 准备播放: songId=$songId, songTitle=$songTitle');
    
    if (songTitle != null) {
      // 先更新索引，再播放
      _currentIndex = index;
      print('📝 更新当前索引为: $_currentIndex');
      await playSong(songId, songTitle);
    } else {
      print('❌ 无法获取歌曲标题');
    }
  }

  /// 获取歌曲标题
  Future<String?> _getSongTitle(String songId) async {
    try {
      // 从歌曲标题映射中获取
      if (_songTitles.containsKey(songId)) {
        return _songTitles[songId];
      }
      
      // 如果映射中没有，返回默认标题
      return '歌曲 $songId';
    } catch (e) {
      return null;
    }
  }

  /// 设置播放列表
  void setPlaylist(List<String> songIds) {
    _currentPlaylist = List.from(songIds);
    _currentIndex = -1;
  }

  /// 设置播放列表（包含歌曲标题）
  void setPlaylistWithTitles(Map<String, String> songTitles) {
    _songTitles = Map.from(songTitles);
    _currentPlaylist = songTitles.keys.toList();
    _currentIndex = -1;
  }

  /// 手动播放下一首歌曲
  Future<void> playNext() async {
    if (_currentPlaylist.isEmpty) return;
    
    // 防止与自动播放冲突
    if (_isAutoPlayingNext) return;
    
    final nextIndex = _getNextSongIndex();
    if (nextIndex >= 0) {
      await _playNextSong(nextIndex);
    }
  }

  /// 手动播放上一首歌曲
  Future<void> playPrevious() async {
    if (_currentPlaylist.isEmpty) return;
    
    // 防止与自动播放冲突
    if (_isAutoPlayingNext) return;
    
    final prevIndex = _getPreviousSongIndex();
    if (prevIndex >= 0) {
      await _playNextSong(prevIndex);
    }
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
    print('🎵 AudioService: 开始播放歌曲, songId=$songId, songTitle=$songTitle');
    print('📋 AudioService: 当前播放列表信息 - 长度=${_currentPlaylist.length}, 当前索引=$_currentIndex');
    
    // 重置自动播放标志，确保新的播放能正常触发播放完成回调
    _isAutoPlayingNext = false;
    print('🔄 AudioService: 重置自动播放标志');
    
    final result = await _playSongUseCase(songId);
    
    if (result.isSuccess) {
      final audioInfo = result.value;
      
      // 更新当前播放索引（只在播放列表不为空时）
      if (_currentPlaylist.isNotEmpty) {
        final newIndex = _currentPlaylist.indexOf(songId);
        if (newIndex >= 0) {
          _currentIndex = newIndex;
          print('📝 AudioService: 更新当前索引为: $_currentIndex');
        } else {
          print('⚠️ AudioService: 歌曲不在播放列表中: songId=$songId');
        }
      }
      
      print('🎵 AudioService: 调用AudioPlayerService播放歌曲');
      await _audioPlayerService.playSongWithUrl(
        songId,
        songTitle,
        audioInfo.url,
        authHeaders: audioInfo.authHeader,
      );
      print('✅ AudioService: 歌曲播放启动成功');
      return const Success(null);
    } else {
      print('❌ AudioService: 播放歌曲失败: ${result.error}');
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

  /// 设置播放倍速
  Future<void> setPlaybackSpeed(double speed) async {
    await _audioPlayerService.setPlaybackSpeed(speed);
  }

  /// 获取当前播放状态
  AudioPlayerInfo getCurrentState() {
    return _audioPlayerService.currentState;
  }
}
