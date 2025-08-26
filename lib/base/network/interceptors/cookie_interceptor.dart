import 'package:dio/dio.dart';

class CookieInterceptor extends Interceptor {
  static String? _sessionId;

  CookieInterceptor();

  /// 设置sessionId，在登录成功后调用
  static void setSessionId(String sessionId) {
    _sessionId = sessionId;
    print('🔍 CookieInterceptor: 设置sessionId: $sessionId');
  }

  /// 清除sessionId，在登出时调用
  static void clearSessionId() {
    _sessionId = null;
    print('🔍 CookieInterceptor: 清除sessionId');
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 获取存储的sessionId并设置为cookie
    // 注意：这里不能使用async，所以我们需要同步获取
    // 或者使用其他方式来处理
    _setCookieIfAvailable(options);
    handler.next(options);
  }

  void _setCookieIfAvailable(RequestOptions options) {
    if (_sessionId != null && _sessionId!.isNotEmpty) {
      // 设置cookie: id=sid
      options.headers['Cookie'] = 'id=$_sessionId';
      print('🔍 CookieInterceptor: 设置Cookie: id=$_sessionId');
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 检查响应中是否包含Set-Cookie头
    final setCookie = response.headers.map['set-cookie'];
    if (setCookie != null && setCookie.isNotEmpty) {
      // 可以在这里处理服务器返回的cookie
      print('🔍 CookieInterceptor: 收到Set-Cookie: $setCookie');
    }
    
    handler.next(response);
  }
}
