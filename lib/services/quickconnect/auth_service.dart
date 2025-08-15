import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants/quickconnect_constants.dart';
import 'models/login_result.dart';
import 'utils/logger.dart';

/// QuickConnect 认证服务
class QuickConnectAuthService {
  static const String _tag = 'AuthService';

  /// 登录群晖 Auth API 获取 SID
  static Future<LoginResult> login({
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

      // 1. 输入验证
      final validationResult = _validateLoginInputs(username, password);
      if (validationResult != null) {
        return validationResult;
      }

      // 2. 构建登录参数
      final params = _buildLoginParams(username, password, otpCode);
      AppLogger.network('发送登录请求参数: ${params.toString()}', tag: _tag);

      // 3. 发送登录请求
      final response = await _sendLoginRequest(baseUrl, params);
      if (response == null) {
        return LoginResult.failure(errorMessage: '网络请求失败');
      }

      // 4. 处理登录响应
      return _handleLoginResponse(response);
      
    } catch (e) {
      AppLogger.error('登录过程中发生异常: $e', tag: _tag);
      return LoginResult.failure(errorMessage: '登录异常: $e');
    }
  }

  /// 验证登录输入参数
  static LoginResult? _validateLoginInputs(String username, String password) {
    if (username.trim().isEmpty || password.trim().isEmpty) {
      AppLogger.error('用户名或密码不能为空', tag: _tag);
      return LoginResult.failure(errorMessage: '用户名或密码不能为空');
    }
    return null;
  }

  /// 构建登录请求参数
  static Map<String, String> _buildLoginParams(String username, String password, String? otpCode) {
    final params = <String, String>{
      'api': 'SYNO.API.Auth',
      'version': QuickConnectConstants.apiVersion3.toString(),
      'method': 'login',
      'account': username.trim(),
      'passwd': password.trim(),
      'session': QuickConnectConstants.sessionFileStation,
      'format': QuickConnectConstants.formatSid,
    };

    if (otpCode != null && otpCode.isNotEmpty) {
      params['otp_code'] = otpCode.trim();
      AppLogger.info('包含OTP验证码', tag: _tag);
    }

    return params;
  }

  /// 发送登录请求
  static Future<http.Response?> _sendLoginRequest(String baseUrl, Map<String, String> params) async {
    try {
      final url = Uri.parse('$baseUrl/webapi/auth.cgi');
      AppLogger.network('登录API地址: $url', tag: _tag);

      final response = await http.post(url, body: params)
          .timeout(QuickConnectConstants.loginTimeout);

      AppLogger.network('收到登录响应，状态码: ${response.statusCode}', tag: _tag);
      AppLogger.debug('响应内容: ${response.body}', tag: _tag);

      return response;
    } catch (e) {
      AppLogger.error('发送登录请求失败: $e', tag: _tag);
      return null;
    }
  }

  /// 处理登录响应
  static LoginResult _handleLoginResponse(http.Response response) {
    if (response.statusCode != 200) {
      AppLogger.error('HTTP 请求失败，状态码: ${response.statusCode}', tag: _tag);
      return LoginResult.failure(errorMessage: '网络请求失败，状态码: ${response.statusCode}');
    }

    try {
      final data = jsonDecode(response.body);
      
      if (data['success'] == true) {
        return _handleSuccessfulLogin(data);
      } else {
        return _handleFailedLogin(data);
      }
    } catch (e) {
      AppLogger.error('解析登录响应失败: $e', tag: _tag);
      return LoginResult.failure(errorMessage: '响应格式错误');
    }
  }

  /// 处理成功登录
  static LoginResult _handleSuccessfulLogin(Map<String, dynamic> data) {
    final sid = data['data']['sid'];
    AppLogger.success('登录成功! SID: $sid', tag: _tag);
    return LoginResult.success(sid: sid);
  }

  /// 处理失败登录
  static LoginResult _handleFailedLogin(Map<String, dynamic> data) {
    final errorCode = data['error']?['code'];
    final errorInfo = data['error']?['errors'];
    
    AppLogger.error('登录失败', tag: _tag);
    AppLogger.error('错误代码: $errorCode', tag: _tag);
    
    // 检查是否需要二次验证
    if (errorCode == 403 && errorInfo != null) {
      return _handleTwoFactorAuth(errorInfo);
    }
    
    // 其他错误情况
    final errorMsg = data['error']?['errors']?['passwd'] ?? '未知错误';
    return LoginResult.failure(errorMessage: '登录失败: $errorMsg');
  }

  /// 处理二次验证
  static LoginResult _handleTwoFactorAuth(Map<String, dynamic> errorInfo) {
    final token = errorInfo['token'];
    final types = errorInfo['types'] as List<dynamic>?;
    
    if (token != null) {
      AppLogger.info('获取到验证令牌: ${token.substring(0, 20)}...', tag: _tag);
    }
    
    if (types != null && types.isNotEmpty) {
      final requiredTypes = types.map((t) => t['type']).toList();
      AppLogger.warning('需要二次验证类型: ${requiredTypes.join(', ')}', tag: _tag);
      
      if (requiredTypes.contains('otp') || requiredTypes.contains('authenticator')) {
        AppLogger.info('需要输入 OTP 验证码', tag: _tag);
        return LoginResult.requireOTP(errorMessage: '需要输入二次验证码 (OTP)');
      }
    }
    
    AppLogger.error('未知的二次验证要求', tag: _tag);
    return LoginResult.failure(errorMessage: '需要二次验证，但类型未知');
  }

  /// 使用指定地址进行 OTP 登录
  static Future<LoginResult> loginWithOTPAtAddress({
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
