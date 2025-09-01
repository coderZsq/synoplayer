import '../../../../base/error/result.dart';
import '../../entities/audio_stream/audio_stream_info.dart';
import '../../entities/song_list_all/song_list_all_response.dart';

abstract class AudioRepository {
  Future<Result<SongListAllResponse>> getAudioStationSongListAll({
    required int offset,
    required int limit
  });

  Future<Result<AudioStreamInfo>> getAudioStreamUrl(String songId);

  /// 获取缓存的音频列表（不进行网络请求）
  Future<Result<SongListAllResponse?>> getCachedAudioList();

  /// 检查是否有有效的缓存
  Future<bool> hasValidCache();

  /// 清除缓存
  Future<void> clearCache();
}
