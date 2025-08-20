import 'package:freezed_annotation/freezed_annotation.dart';

part 'quickconnect_response.freezed.dart';
part 'quickconnect_response.g.dart';

@freezed
class QuickConnectResponse with _$QuickConnectResponse {
  const factory QuickConnectResponse({
    required String command,
    required String errinfo,
    @JsonKey(fromJson: _toString) required String errno,
    required List<String> sites,
    @JsonKey(fromJson: _toString) required String suberrno,
    @JsonKey(fromJson: _toString) required String version,
  }) = _QuickConnectResponse;

  factory QuickConnectResponse.fromJson(Map<String, dynamic> json) =>
      _$QuickConnectResponseFromJson(json);
}

// 添加安全的字符串解析方法
String _toString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}
