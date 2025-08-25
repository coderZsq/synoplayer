// 歌曲列表状态管理
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/providers.dart';
import '../../../quickconnect/entities/song_list_all/song_list_all_response.dart';
import '../../../quickconnect/presentation/services/song_list_service.dart';

class SongListNotifier extends StateNotifier<AsyncValue<SongListAllResponse?>> {
  final SongListService _songListService;

  SongListNotifier(this._songListService) : super(const AsyncValue.loading());

  Future<void> getSongList() async {
    state = const AsyncValue.loading();
    try {
      final result = await _songListService.getSongList();
      if (result.isSuccess) {
        state = AsyncValue.data(result.value);
      } else {
        state = AsyncValue.error(result.error, StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void refresh() {
    getSongList();
  }
}

final songListNotifierProvider = StateNotifierProvider<SongListNotifier, AsyncValue<SongListAllResponse?>>((ref) {
  final songListService = ref.watch(songListServiceProvider);
  return SongListNotifier(songListService);
});