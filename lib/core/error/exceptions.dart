import 'package:dio/dio.dart';

/// 业务异常基类
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, {this.code});
  
  @override
  String toString() => message;
}

/// 网络异常
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code});
  
  factory NetworkException.fromDio(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const NetworkException('连接超时，请检查网络设置');
      case DioExceptionType.sendTimeout:
        return const NetworkException('请求超时，请稍后重试');
      case DioExceptionType.receiveTimeout:
        return const NetworkException('响应超时，请稍后重试');
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode;
        return NetworkException(_mapStatusCodeToMessage(statusCode), code: statusCode?.toString());
      case DioExceptionType.cancel:
        return const NetworkException('请求已取消');
      case DioExceptionType.connectionError:
        return const NetworkException('网络连接失败，请检查网络设置');
      case DioExceptionType.unknown:
        return NetworkException('网络错误：${dioException.message ?? "未知错误"}');
      default:
        return NetworkException('网络错误：${dioException.message ?? "未知错误"}');
    }
  }
  
  static String _mapStatusCodeToMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return '请求参数错误';
      case 401:
        return '身份验证失败，请重新登录';
      case 403:
        return '权限不足，无法访问';
      case 404:
        return '请求的资源不存在';
      case 500:
        return '服务器内部错误，请稍后重试';
      case 502:
        return '服务器网关错误';
      case 503:
        return '服务暂时不可用，请稍后重试';
      default:
        return '服务器响应异常 ($statusCode)';
    }
  }
}

/// 认证异常
class AuthException extends AppException {
  const AuthException(super.message, {super.code});
}

/// 服务器异常
class ServerException extends AppException {
  const ServerException(super.message, {super.code});
}

/// 验证异常
class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});
}

/// 业务逻辑异常
class BusinessException extends AppException {
  const BusinessException(super.message, {super.code});
}
