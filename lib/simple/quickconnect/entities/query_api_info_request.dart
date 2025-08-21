import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_api_info_request.freezed.dart';
part 'query_api_info_request.g.dart';

@freezed
class QueryApiInfoRequest with _$QueryApiInfoRequest {
  const factory QueryApiInfoRequest({
    required String api,
    required String method,
    required String version,
  }) = _QueryApiInfoRequest;

  @override
  Map<String, dynamic> toJson() {
    return {
      'api': api,
      'method': method,
      'version': version,
    };
  }

  factory QueryApiInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$QueryApiInfoRequestFromJson(json);
}