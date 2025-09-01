// 歌曲列表状态管理
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import '../../../../base/di/providers.dart';

part 'audio_list_provider.g.dart';

@riverpod
class SongListNotifier extends _$SongListNotifier {
  static const int _pageSize = 20;
  bool _isSortedByName = true; // 默认按名称排序
  
  @override
  FutureOr<SongListData?> build() {
    return null;
  }

  Future<void> getSongList({bool isRefresh = false}) async {
    if (isRefresh) {
      state = const AsyncValue.loading();
    }
    
    try {
      final audioRepository = ref.read(audioRepositoryProvider);
      
      final result = await audioRepository.getAudioStationSongListAll(
        offset: 0, 
        limit: _pageSize
      );
      
      if (result.isSuccess) {
        final songListData = result.value.data;
        if (songListData != null && _isSortedByName) {
          // 如果启用了按名称排序，则对歌曲列表进行排序
          final sortedSongs = _sortSongsByName(songListData.songs ?? []);
          final sortedSongListData = songListData.copyWith(songs: sortedSongs);
          state = AsyncValue.data(sortedSongListData);
        } else {
          state = AsyncValue.data(songListData);
        }
      } else {
        state = AsyncValue.error(result.error, StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null) return;
    
    final currentSongs = currentState.songs ?? [];
    final total = currentState.total ?? 0;
    
    // 如果已经加载完所有数据，直接返回
    if (currentSongs.length >= total) return;
    
    try {
      final audioRepository = ref.read(audioRepositoryProvider);
      final result = await audioRepository.getAudioStationSongListAll(
        offset: currentSongs.length,
        limit: _pageSize,
      );
      
      if (result.isSuccess) {
        final newSongs = result.value.data?.songs ?? [];
        final updatedSongs = [...currentSongs, ...newSongs];
        
        // 如果启用了按名称排序，则对合并后的歌曲列表进行排序
        final finalSongs = _isSortedByName 
            ? _sortSongsByName(updatedSongs)
            : updatedSongs;
        
        state = AsyncValue.data(currentState.copyWith(
          songs: finalSongs,
          offset: currentSongs.length,
        ));
      }
    } catch (error, _) {
      // 加载更多失败时不影响当前状态
      // 可以在这里添加日志记录
    }
  }

  Future<void> refresh() async {
    // 强制刷新
    try {
      state = const AsyncValue.loading();
      
      final audioRepository = ref.read(audioRepositoryProvider);
      final result = await audioRepository.getAudioStationSongListAll(
        offset: 0,
        limit: _pageSize,
      );
      
      if (result.isSuccess) {
        final songListData = result.value.data;
        if (songListData != null && _isSortedByName) {
          // 如果启用了按名称排序，则对歌曲列表进行排序
          final sortedSongs = _sortSongsByName(songListData.songs ?? []);
          final sortedSongListData = songListData.copyWith(songs: sortedSongs);
          state = AsyncValue.data(sortedSongListData);
        } else {
          state = AsyncValue.data(songListData);
        }
      } else {
        state = AsyncValue.error(result.error, StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 切换按名称排序
  void toggleSortByName() {
    _isSortedByName = !_isSortedByName;
    
    final currentState = state.value;
    if (currentState != null && currentState.songs != null) {
      if (_isSortedByName) {
        // 启用排序，对当前歌曲列表进行排序
        final sortedSongs = _sortSongsByName(currentState.songs!);
        state = AsyncValue.data(currentState.copyWith(songs: sortedSongs));
      } else {
        // 禁用排序，重新获取原始顺序的歌曲列表
        getSongList(isRefresh: true);
      }
    }
  }

  /// 按名称对歌曲列表进行排序
  List<Song> _sortSongsByName(List<Song> songs) {
    final sortedSongs = List<Song>.from(songs);
    sortedSongs.sort((a, b) {
      final titleA = (a.title ?? '').toLowerCase();
      final titleB = (b.title ?? '').toLowerCase();
      return titleA.compareTo(titleB);
    });
    return sortedSongs;
  }

  /// 获取当前排序状态
  bool get isSortedByName => _isSortedByName;

  bool get hasMoreData {
    final currentState = state.value;
    if (currentState == null) return false;
    
    final currentSongs = currentState.songs ?? [];
    final total = currentState.total ?? 0;
    
    return currentSongs.length < total;
  }

  bool get isLoadingMore {
    // 可以通过检查当前状态来判断是否正在加载更多
    // 这里可以根据需要实现更复杂的逻辑
    return false;
  }
}