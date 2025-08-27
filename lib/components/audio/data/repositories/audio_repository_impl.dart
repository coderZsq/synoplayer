import '../../../../base/error/result.dart';
import '../../../../base/error/exceptions.dart';
import '../datasources/audio_datasource.dart';
import '../../domain/repositories/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioDatasource _datasource;

  AudioRepositoryImpl(this._datasource);

  @override
  Future<Result<String>> getAudioStreamUrl(String songId) async {
    try {
      final url = await _datasource.getAudioStreamUrl(songId);
      if (url == null) {
        return const Failure(BusinessException('无法获取音频流地址'));
      }
      return Success(url);
    } catch (e) {
      return Failure(BusinessException('获取音频流地址失败: $e'));
    }
  }
}
