import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/logger.dart';

/// 认证拦截器
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.ref);

  final Ref ref;
  static const String _tag = 'AuthInterceptor';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 为需要认证的请求添加认证信息
    if (_requiresAuth(options)) {
      _addAuthHeaders(options);
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 处理认证错误
    if (err.response?.statusCode == 401) {
      AppLogger.warning('认证失败，需要重新登录', tag: _tag);
      _handleAuthError(err);
    }
    handler.next(err);
  }

  /// 判断请求是否需要认证
  bool _requiresAuth(RequestOptions options) {
    // 可以根据 URL 或其他条件判断是否需要认证
    final path = options.path.toLowerCase();
    
    // QuickConnect 认证相关的请求不需要预先认证
    if (path.contains('/webapi/auth.cgi')) {
      return false;
    }
    
    // 其他 webapi 请求需要认证
    if (path.contains('/webapi/')) {
      return true;
    }
    
    return false;
  }

  /// 添加认证头信息
  void _addAuthHeaders(RequestOptions options) {
    try {
      // 从存储中获取认证信息（这里简化处理）
      // 实际实现中可以从 CredentialsService 获取
      // final credentials = await ref.read(credentialsProvider);
      
      // 如果有 SID，添加到请求参数中
      // if (credentials.sid != null) {
      //   options.queryParameters['_sid'] = credentials.sid;
      // }
      
      AppLogger.debug('添加认证信息到请求', tag: _tag);
    } catch (e) {
      AppLogger.error('添加认证信息失败: $e', tag: _tag);
    }
  }

  /// 处理认证错误
  void _handleAuthError(DioException err) {
    // 这里可以触发重新登录流程
    AppLogger.error('认证错误，可能需要重新登录', tag: _tag);
    
    // 可以发送事件通知应用层处理
    // ref.read(authNotifierProvider.notifier).logout();
  }
}
