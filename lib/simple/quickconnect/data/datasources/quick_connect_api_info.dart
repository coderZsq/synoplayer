import '../../entities/query_api_info_response.dart';

class QuickConnectApiInfo {
  QuickConnectApiInfo._();
  static final QuickConnectApiInfo _instance = QuickConnectApiInfo._();
  factory QuickConnectApiInfo() => _instance;

  QueryApiInfoResponse? apiInfo;

  final String info = 'SYNO.API.Info';
  final String auth = 'SYNO.API.Auth';

  get authVersion => apiInfo?.data?[auth]?.maxVersion.toString();
}


