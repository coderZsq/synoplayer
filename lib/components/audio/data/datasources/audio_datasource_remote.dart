import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../entities/song_list_all/song_list_all_response.dart';

part 'audio_datasource_remote.g.dart';

@RestApi()
abstract class AudioDataSourceRemote {
  factory AudioDataSourceRemote(Dio dio, {String baseUrl}) = _AudioDataSourceRemote;

  @GET('/webapi/AudioStation/song.cgi')
  Future<SongListAllResponse> getAudioStationSongListAll({
    @Query('api') required String api,
    @Query('method') required String method,
    @Query('library') required String library,
    @Query('offset') required int offset,
    @Query('limit') required int limit,
    @Query('_sid') required String sid,
    @Query('version') required String version,
  });
}