import '../../entities/song_list_all/song_list_all_response.dart';
import '../repositories/quick_connect_repository.dart';
import '../../../core/error/exceptions.dart';

class GetSongListUseCase {
  final QuickConnectRepository repository;

  GetSongListUseCase(this.repository);

  Future<SongListAllResponse> call() async {
    try {
      return await repository.getAudioStationSongListAll();
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw ServerException('获取歌曲列表失败: ${e.toString()}');
    }
  }
}
