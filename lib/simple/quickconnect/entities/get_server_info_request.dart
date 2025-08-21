import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_server_info_request.freezed.dart';
part 'get_server_info_request.g.dart';

@freezed
class GetServerInfoRequest with _$GetServerInfoRequest {
  const factory GetServerInfoRequest({
    required String id,
    required String serverID,
    required String command,
  }) = _QuickConnectRequest;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serverID': serverID,
      'command': command,
    };
  }

  factory GetServerInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$GetServerInfoRequestFromJson(json);
}
