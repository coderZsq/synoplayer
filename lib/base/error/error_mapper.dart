import 'package:dio/dio.dart';
import 'exceptions.dart';

/// 错误映射器 - 将各种异常转换为用户友好的消息
class ErrorMapper {
  /// 将异常映射为用户友好的错误消息
  static String mapToUserMessage(dynamic error) {
    if (error is AppException) {
      return error.message;
    }
    
    if (error is DioException) {
      return NetworkException.fromDio(error).message;
    }
    
    if (error is String) {
      return error;
    }
    
    // 处理其他类型的异常
    return _mapGenericError(error);
  }
  
  /// 将异常包装为业务异常
  static AppException wrapException(dynamic error) {
    if (error is AppException) {
      return error;
    }
    
    if (error is DioException) {
      return NetworkException.fromDio(error);
    }
    
    if (error is String) {
      return ServerException(error);
    }
    
    return ServerException(_mapGenericError(error));
  }
  
  /// 映射通用错误
  static String _mapGenericError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    
    // 网络相关错误
    if (errorString.contains('network') || 
        errorString.contains('connection') ||
        errorString.contains('socket')) {
      return '网络连接异常，请检查网络设置';
    }
    
    // 超时错误
    if (errorString.contains('timeout')) {
      return '操作超时，请稍后重试';
    }
    
    // JSON 解析错误
    if (errorString.contains('json') || 
        errorString.contains('parse') ||
        errorString.contains('format')) {
      return '数据格式错误，请稍后重试';
    }
    
    // 默认错误消息
    return '操作失败，请稍后重试';
  }
  
  /// 根据错误类型获取错误代码
  static String? getErrorCode(dynamic error) {
    if (error is AppException) {
      return error.code;
    }
    
    if (error is DioException) {
      return error.response?.statusCode?.toString();
    }
    
    return null;
  }
  
  /// 判断是否为网络错误
  static bool isNetworkError(dynamic error) {
    return error is NetworkException || 
           error is DioException ||
           (error.toString().toLowerCase().contains('network'));
  }
  
  /// 判断是否为认证错误
  static bool isAuthError(dynamic error) {
    if (error is AuthException) return true;
    
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      return statusCode == 401 || statusCode == 403;
    }
    
    return false;
  }
  
  /// 判断是否为可重试的错误
  static bool isRetryableError(dynamic error) {
    if (error is NetworkException) return true;
    
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      // 5xx 服务器错误和网络错误可以重试
      return statusCode == null || (statusCode >= 500 && statusCode < 600);
    }
    
    return false;
  }
  
  /// 获取错误类型描述
  static String getErrorTypeDescription(dynamic error) {
    if (error is NetworkException) {
      return '网络错误';
    }
    
    if (error is AuthException) {
      return '认证错误';
    }
    
    if (error is ValidationException) {
      return '验证错误';
    }
    
    if (error is BusinessException) {
      return '业务错误';
    }
    
    if (error is ServerException) {
      return '服务器错误';
    }
    
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        if (statusCode >= 400 && statusCode < 500) {
          return statusCode == 401 || statusCode == 403 
              ? '认证错误' 
              : '请求错误';
        }
        if (statusCode >= 500) {
          return '服务器错误';
        }
      }
      return '网络错误';
    }
    
    return '未知错误';
  }
}
