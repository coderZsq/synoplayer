import '../../../../base/error/result.dart';
import '../../entities/audio_stream/audio_stream_info.dart';
import '../../entities/song_list_all/song_list_all_response.dart';

abstract class AudioRepository {
  Future<Result<SongListAllResponse>> getAudioStationSongListAll({
    required int offset,
    required int limit
  });

  Future<Result<AudioStreamInfo>> getAudioStreamUrl(String songId);
}
