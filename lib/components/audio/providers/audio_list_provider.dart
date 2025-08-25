// 歌曲列表状态管理
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../quickconnect/entities/song_list_all/song_list_all_response.dart';

part 'audio_list_provider.g.dart';

@riverpod
class SongListNotifier extends _$SongListNotifier {
  @override
  FutureOr<SongListData?> build() {
    return null;
  }

  Future<void> getSongList() async {
    state = const AsyncValue.loading();
    try {
      final songListService = ref.read(songListServiceProvider);
      final result = await songListService.getSongList();
      if (result.isSuccess) {
        state = AsyncValue.data(result.value.data);
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