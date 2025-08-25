import 'package:synoplayer/quickconnect/entities/song_list_all/song_list_all_response.dart';

import '../../entities/auth_login/auth_login_response.dart';
import '../../entities/get_server_info/get_server_info_response.dart';

abstract class QuickConnectRepository {
  Future<GetServerInfoResponse> getServerInfo({
    required String serverID,
    String? site,
  });

  Future<bool> queryApiInfo({
    required String relayDn,
    required int relayPort,
  });

  Future<AuthLoginResponse> authLogin({
    required String account,
    required String passwd,
    String? otp_code,
  });

  Future<SongListAllResponse> getAudioStationSongListAll();
}
