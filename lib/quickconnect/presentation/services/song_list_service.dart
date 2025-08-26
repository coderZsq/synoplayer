import '../../domain/usecases/get_song_list_usecase.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import '../../../base/error/result.dart';

class SongListService {
  final GetSongListUseCase _getSongListUseCase;

  SongListService(this._getSongListUseCase);

  Future<Result<SongListAllResponse>> getSongList({
    int offset = 0,
    int limit = 20,
  }) async {
    return await _getSongListUseCase(offset: offset, limit: limit);
  }
}
