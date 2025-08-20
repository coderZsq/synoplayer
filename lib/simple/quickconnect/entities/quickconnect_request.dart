import 'package:freezed_annotation/freezed_annotation.dart';

part 'quickconnect_request.freezed.dart';
part 'quickconnect_request.g.dart';

@freezed
class QuickConnectRequest with _$QuickConnectRequest {
  const factory QuickConnectRequest({
    @JsonKey(name: 'get_ca_fingerprints') required bool getCaFingerprints,
    required String id,
    @JsonKey(name: 'serverID') required String serverId,
    required String command,
    required String version,
  }) = _QuickConnectRequest;

  factory QuickConnectRequest.fromJson(Map<String, dynamic> json) =>
      _$QuickConnectRequestFromJson(json);
}
