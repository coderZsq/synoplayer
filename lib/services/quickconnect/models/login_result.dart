import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_result.freezed.dart';
part 'login_result.g.dart';

/// 登录结果模型
@freezed
class LoginResult with _$LoginResult {
  const factory LoginResult.success({
    required String sid,
    String? availableAddress,
  }) = LoginResultSuccess;

  const factory LoginResult.failure({
    required String errorMessage,
  }) = LoginResultFailure;

  const factory LoginResult.requireOTP({
    required String errorMessage,
  }) = LoginResultRequireOTP;

  const factory LoginResult.requireOTPWithAddress({
    required String errorMessage,
    required String availableAddress,
  }) = LoginResultRequireOTPWithAddress;

  const LoginResult._();

  factory LoginResult.fromJson(Map<String, dynamic> json) => 
      _$LoginResultFromJson(json);

  /// 检查是否为成功登录
  bool get isSuccess => this is LoginResultSuccess;
  
  /// 检查是否需要二次验证
  bool get requireOTP => this is LoginResultRequireOTP || this is LoginResultRequireOTPWithAddress;
  
  /// 获取错误信息
  String? get errorMessage {
    return when(
      success: (_, __) => null,
      failure: (errorMessage) => errorMessage,
      requireOTP: (errorMessage) => errorMessage,
      requireOTPWithAddress: (errorMessage, _) => errorMessage,
    );
  }
  
  /// 获取会话ID
  String? get sid {
    return when(
      success: (sid, _) => sid,
      failure: (_) => null,
      requireOTP: (_) => null,
      requireOTPWithAddress: (_, __) => null,
    );
  }
  
  /// 获取可用地址
  String? get availableAddress {
    return when(
      success: (_, address) => address,
      failure: (_) => null,
      requireOTP: (_) => null,
      requireOTPWithAddress: (_, address) => address,
    );
  }
}
