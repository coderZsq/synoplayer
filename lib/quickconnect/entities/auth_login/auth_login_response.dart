import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_response.freezed.dart';
part 'auth_login_response.g.dart';

@freezed
class AuthLoginResponse with _$AuthLoginResponse {
  const factory AuthLoginResponse({
    required ErrorInfo? error,
    required bool? success,
    required LoginData? data,
  }) = _AuthLoginResponse;

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseFromJson(json);
}

extension AuthLoginResponseExt on AuthLoginResponse {
  /// 是否需要二次验证（OTP）
  bool get needOtp => error?.errors?.types?.any((element) => element.type == 'otp') ?? false;
  
  /// 是否登录成功（有 sid 表示成功）
  bool get isLoginSuccess => data?.sid != null && data!.sid!.isNotEmpty;
  
  /// 获取会话ID
  String? get sessionId => data?.sid;
}

@freezed
class ErrorInfo with _$ErrorInfo {
  const factory ErrorInfo({
    required int? code,
    required ErrorDetails? errors,
  }) = _ErrorInfo;

  factory ErrorInfo.fromJson(Map<String, dynamic> json) =>
      _$ErrorInfoFromJson(json);
}

@freezed
class ErrorDetails with _$ErrorDetails {
  const factory ErrorDetails({
    required String? token,
    required List<ErrorType>? types,
  }) = _ErrorDetails;

  factory ErrorDetails.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailsFromJson(json);
}

@freezed
class ErrorType with _$ErrorType {
  const factory ErrorType({
    required String? type,
  }) = _ErrorType;

  factory ErrorType.fromJson(Map<String, dynamic> json) =>
      _$ErrorTypeFromJson(json);
}

@freezed
class LoginData with _$LoginData {
  const factory LoginData({
    required String? account,
    required String? deviceId,
    required String? ikMessage,
    required bool? isPortalPort,
    required String? sid,
    required String? synotoken,
  }) = _LoginData;

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
}
