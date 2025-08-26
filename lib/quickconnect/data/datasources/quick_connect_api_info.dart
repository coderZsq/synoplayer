import '../../entities/query_api_info/query_api_info_response.dart';

class QuickConnectApiInfo {
  QuickConnectApiInfo._();
  static final QuickConnectApiInfo _instance = QuickConnectApiInfo._();
  factory QuickConnectApiInfo() => _instance;

  QueryApiInfoResponse? apiInfo;

  final String info = 'SYNO.API.Info';
  final String auth = 'SYNO.API.Auth';
  final String song = 'SYNO.AudioStation.Song';
  final String stream = 'SYNO.AudioStation.Stream';

  String get authVersion => apiInfo?.data?[auth]?.maxVersion?.toString() ?? '1';
  String get songVersion => apiInfo?.data?[song]?.maxVersion?.toString() ?? '1';
  String get streamVersion => apiInfo?.data?[stream]?.maxVersion?.toString() ?? '1';
}


