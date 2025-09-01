import '../../../../base/network/interceptors/cookie_interceptor.dart';
import '../../../../base/network/quick_connect_api_info.dart';
import '../../../login/domain/services/connection_manager.dart';

/// 音频本地数据源 - 只负责真正的本地数据
class AudioDataSourceLocal {
  final ConnectionManager _connectionManager;
  final QuickConnectApiInfo _apiInfo;

  AudioDataSourceLocal(this._connectionManager) : _apiInfo = QuickConnectApiInfo();

  /// 获取音频流URL
  Future<String?> getAudioStreamUrl(String songId) async {
    if (!_connectionManager.connected) {
      return null;
    }

    final baseUrl = _connectionManager.baseUrl;
    if (baseUrl == null || baseUrl.isEmpty) {
      return null;
    }

    return '$baseUrl/webapi/AudioStation/stream.cgi?api=${_apiInfo.stream}&method=stream&id=$songId&seek_position=0&version=${_apiInfo.streamVersion}';
  }

  /// 获取认证头
  String? getAuthHeaders() {
    final sessionId = CookieInterceptor.getSessionId();
    if (sessionId == null || sessionId.isEmpty) return null;
    return 'id=$sessionId';
  }
}
