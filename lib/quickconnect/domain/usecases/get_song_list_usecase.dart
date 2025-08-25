import '../../entities/song_list_all/song_list_all_response.dart';
import '../repositories/quick_connect_repository.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/result.dart';

class GetSongListUseCase {
  final QuickConnectRepository repository;

  GetSongListUseCase(this.repository);

  Future<Result<SongListAllResponse>> call() async {
    try {
      final result = await repository.getAudioStationSongListAll();
      return result;
    } catch (e) {
      if (e is AppException) {
        return Failure(e);
      }
      return Failure(ServerException('获取歌曲列表失败: ${e.toString()}'));
    }
  }
}
