import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_server_info_response.freezed.dart';
part 'get_server_info_response.g.dart';

@freezed
class GetServerInfoResponse with _$GetServerInfoResponse {
  const factory GetServerInfoResponse({
    required String command,
    required String errinfo,
    required int errno,
    required List<String> sites,
    required int suberrno,
     required int version,
  }) = _GetServerInfoResponse;

  factory GetServerInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$GetServerInfoResponseFromJson(json);
}