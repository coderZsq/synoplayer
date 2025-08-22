import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_request.freezed.dart';
part 'auth_login_request.g.dart';

@freezed
class AuthLoginRequest with _$AuthLoginRequest {
  const factory AuthLoginRequest({
    required String api,
    required String method,
    required String account,
    required String passwd,
    required String session,
    required String format,
    String? otp_code,
    required String version,
  }) = _AuthLoginRequest;

  @override
  Map<String, dynamic> toJson() {
    return {
      'api': api,
      'method': method,
      'account': account,
      'passwd': passwd,
      'session': session,
      'format': format,
      'otp_code': otp_code,
      'version': version,
    };
  }

  factory AuthLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginRequestFromJson(json);
}
