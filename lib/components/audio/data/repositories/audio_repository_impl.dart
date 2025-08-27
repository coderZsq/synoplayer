import 'package:dio/dio.dart';
import 'package:synoplayer/components/audio/data/datasources/audio_datasource_remote.dart';

import '../../../../base/auth/storage/auth_storage_service.dart';
import '../../../../base/error/result.dart';
import '../../../../base/error/exceptions.dart';
import '../../../../quickconnect/data/datasources/quick_connect_api_info.dart';
import '../../../../quickconnect/domain/services/connection_manager.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import '../datasources/audio_datasource_local.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../entities/audio_stream/audio_stream_info.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AuthStorageService _authStorage;
  final ConnectionManager connectionManager;
  final AudioDataSourceRemote _dataSourceRemote;
  final AudioDataSourceLocal _dataSourceLocal;
  final Dio _dio;

  AudioRepositoryImpl(this._authStorage, this.connectionManager, this._dataSourceRemote, this._dataSourceLocal, this._dio);

  @override
  Future<Result<SongListAllResponse>> getAudioStationSongListAll({
    required int offset,
    required int limit
  }) async {
    try {
      final apiInfo = QuickConnectApiInfo();
      final sessionId = await _authStorage.getSessionId();
      if (sessionId == null || sessionId.isEmpty) {
        return Failure(AuthException('未登录或会话已过期'));
      }
      
      // 获取已连接的 baseUrl
      final baseUrl = connectionManager.baseUrl;
      if (baseUrl == null) {
        return Failure(BusinessException('未连接到服务器，请先建立连接'));
      }
      
      // 创建带有正确 baseUrl 的 AudioDataSourceRemote 实例
      final dataSourceRemote = AudioDataSourceRemote(_dio, baseUrl: baseUrl);
      
      final response = await dataSourceRemote.getAudioStationSongListAll(
          api: apiInfo.song,
          method: 'list',
          library: 'all',
          offset: offset,
          limit: limit,
          sid: sessionId,
          version: apiInfo.songVersion
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(NetworkException.fromDio(e));
    } catch (e) {
      return Failure(ServerException('获取歌曲列表失败: $e'));
    }
  }

  @override
  Future<Result<AudioStreamInfo>> getAudioStreamUrl(String songId) async {
    try {
      final url = await _dataSourceLocal.getAudioStreamUrl(songId);
      final authHeader = _dataSourceLocal.getAuthHeaders();
      if (url == null) {
        return const Failure(BusinessException('无法获取音频流地址'));
      }
      if (authHeader == null) {
        return const Failure(BusinessException('无法获取认证头'));
      }
      return Success(AudioStreamInfo(url: url, authHeader: authHeader));
    } catch (e) {
      return Failure(BusinessException('获取音频流地址失败: $e'));
    }
  }
}
