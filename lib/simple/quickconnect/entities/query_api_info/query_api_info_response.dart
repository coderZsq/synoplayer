import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_api_info_response.freezed.dart';
part 'query_api_info_response.g.dart';

@freezed
class QueryApiInfoResponse with _$QueryApiInfoResponse {
  const factory QueryApiInfoResponse({
    required Map<String, ApiInfo>? data,
    required bool? success,
  }) = _QueryApiInfoResponse;

  factory QueryApiInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$QueryApiInfoResponseFromJson(json);
}

@freezed
class ApiInfo with _$ApiInfo {
  const factory ApiInfo({
    required int? maxVersion,
    required int? minVersion,
    required String? path,
    String? requestFormat,
  }) = _ApiInfo;

  factory ApiInfo.fromJson(Map<String, dynamic> json) => _$ApiInfoFromJson(json);
}
