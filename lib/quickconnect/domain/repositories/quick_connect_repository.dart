import 'package:synoplayer/components/audio/entities/song_list_all/song_list_all_response.dart';
import '../../../base/error/result.dart';

import '../../entities/auth_login/auth_login_response.dart';
import '../../entities/get_server_info/get_server_info_response.dart';

abstract class QuickConnectRepository {
  Future<Result<GetServerInfoResponse>> getServerInfo({
    required String serverID,
    String? site,
  });

  Future<Result<bool>> queryApiInfo({
    required String relayDn,
    required int relayPort,
  });

  Future<Result<AuthLoginResponse>> authLogin({
    required String account,
    required String passwd,
    String? otp_code,
  });
}
