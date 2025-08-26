import '../../entities/song_list_all/song_list_all_response.dart';
import '../repositories/quick_connect_repository.dart';
import '../services/connection_manager.dart';
import '../../../base/error/exceptions.dart';
import '../../../base/error/result.dart';
import '../../../base/auth/storage/auth_storage_service.dart';

class GetSongListUseCase {
  final QuickConnectRepository repository;
  final AuthStorageService authStorage;
  final ConnectionManager connectionManager;

  GetSongListUseCase(this.repository, this.authStorage, this.connectionManager);

  Future<Result<SongListAllResponse>> call({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      // 从缓存中获取 quickConnectId
      final credentials = await authStorage.getLoginCredentials();
      final quickConnectId = credentials['quickConnectId'];
      
      if (quickConnectId == null || quickConnectId.isEmpty) {
        return Failure(BusinessException('未找到服务器连接信息，请先登录'));
      }
      
      // 如果已经连接，直接获取歌曲列表
      if (connectionManager.connected) {
        return await _getSongList(offset: offset, limit: limit);
      }
      
      // 获取服务器信息并建立连接
      final connectionResult = await connectionManager.establishConnection(quickConnectId);
      if (connectionResult.isFailure) {
        return Failure(connectionResult.error);
      }
      
      // 连接成功后获取歌曲列表
      return await _getSongList(offset: offset, limit: limit);
    } catch (e) {
      if (e is AppException) {
        return Failure(e);
      }
      return Failure(ServerException('获取歌曲列表失败: ${e.toString()}'));
    }
  }

  /// 获取歌曲列表
  Future<Result<SongListAllResponse>> _getSongList({
    int offset = 0,
    int limit = 20,
  }) async {
    final result = await repository.getAudioStationSongListAll(
      offset: offset,
      limit: limit,
    );
    return result;
  }
}
