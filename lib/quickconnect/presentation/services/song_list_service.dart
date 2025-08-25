import '../../domain/usecases/get_song_list_usecase.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import '../../../core/error/result.dart';

class SongListService {
  final GetSongListUseCase _getSongListUseCase;

  SongListService(this._getSongListUseCase);

  Future<Result<SongListAllResponse>> getSongList() async {
    return await _getSongListUseCase();
  }
}
