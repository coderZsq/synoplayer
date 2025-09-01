// 歌曲列表状态管理
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import '../../../../base/di/providers.dart';

part 'audio_list_provider.g.dart';

@riverpod
class SongListNotifier extends _$SongListNotifier {
  static const int _pageSize = 20;
  
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
      
      // 使用音频仓库，它会先返回缓存数据
      final result = await audioRepository.getAudioStationSongListAll(
        offset: 0, 
        limit: _pageSize
      );
      
      if (result.isSuccess) {
        state = AsyncValue.data(result.value.data);
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
        
        state = AsyncValue.data(currentState.copyWith(
          songs: updatedSongs,
          offset: currentSongs.length,
        ));
      }
    } catch (error, _) {
      // 加载更多失败时不影响当前状态
      // 可以在这里添加日志记录
    }
  }

  Future<void> refresh() async {
    // 强制刷新，忽略缓存
    try {
      state = const AsyncValue.loading();
      
      final audioRepository = ref.read(audioRepositoryProvider);
      // 先清除缓存，然后重新请求
      await audioRepository.clearCache();
      
      final result = await audioRepository.getAudioStationSongListAll(
        offset: 0,
        limit: _pageSize,
      );
      
      if (result.isSuccess) {
        state = AsyncValue.data(result.value.data);
      } else {
        state = AsyncValue.error(result.error, StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 检查是否有缓存数据
  Future<bool> hasCachedData() async {
    try {
      final audioRepository = ref.read(audioRepositoryProvider);
      return await audioRepository.hasValidCache();
    } catch (e) {
      return false;
    }
  }

  /// 清除缓存
  Future<void> clearCache() async {
    try {
      final audioRepository = ref.read(audioRepositoryProvider);
      await audioRepository.clearCache();
    } catch (e) {
      // 清除缓存失败不影响主流程
    }
  }

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