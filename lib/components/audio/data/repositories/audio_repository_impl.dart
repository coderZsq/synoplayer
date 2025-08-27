import '../../../../base/error/result.dart';
import '../../../../base/error/exceptions.dart';
import '../datasources/audio_datasource.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../entities/audio_stream_info.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioDatasource _datasource;

  AudioRepositoryImpl(this._datasource);

  @override
  Future<Result<AudioStreamInfo>> getAudioStreamUrl(String songId) async {
    try {
      final url = await _datasource.getAudioStreamUrl(songId);
      final authHeader = _datasource.getAuthHeaders();
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
