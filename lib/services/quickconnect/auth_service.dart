import 'api/quickconnect_api_interface.dart';
import 'models/login_result.dart';
import '../../core/utils/logger.dart';

/// QuickConnect 认证服务
class QuickConnectAuthService {
  QuickConnectAuthService(this._api);
  
  final QuickConnectApiInterface _api;
  static const String _tag = 'AuthService';

  /// 登录群晖 Auth API 获取 SID
  Future<LoginResult> login({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.userAction('开始登录流程', tag: _tag);
      AppLogger.info('基础URL: $baseUrl', tag: _tag);
      AppLogger.info('用户名: $username', tag: _tag);
      AppLogger.info('是否提供OTP: ${otpCode != null && otpCode.isNotEmpty ? "是" : "否"}', tag: _tag);

      // 使用抽象 API 接口进行登录
      final result = await _api.requestLogin(
        baseUrl: baseUrl,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      return result;
      
    } catch (e) {
      AppLogger.error('登录过程中发生异常: $e', tag: _tag);
      return LoginResult.failure(errorMessage: '登录异常: $e');
    }
  }



  /// 使用指定地址进行 OTP 登录
  Future<LoginResult> loginWithOTPAtAddress({
    required String baseUrl,
    required String username,
    required String password,
    required String otpCode,
  }) async {
    try {
      AppLogger.userAction('使用 OTP 在指定地址登录: $baseUrl', tag: _tag);
      return await login(
        baseUrl: baseUrl,
        username: username,
        password: password,
        otpCode: otpCode,
      );
    } catch (e) {
      AppLogger.error('OTP 登录异常: $e', tag: _tag);
      return LoginResult.failure(errorMessage: 'OTP 登录异常: $e');
    }
  }
}
