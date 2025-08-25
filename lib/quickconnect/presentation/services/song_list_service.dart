import '../../domain/usecases/get_song_list_usecase.dart';
import '../../entities/song_list_all/song_list_all_response.dart';

class SongListService {
  final GetSongListUseCase _getSongListUseCase;

  SongListService(this._getSongListUseCase);

  Future<SongListAllResponse> getSongList() async {
    return await _getSongListUseCase();
  }
}
