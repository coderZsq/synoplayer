import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'network_exceptions.freezed.dart';

/// 网络异常类型
@freezed
class NetworkException with _$NetworkException implements Exception {
  const factory NetworkException.requestCancelled() = RequestCancelled;
  
  const factory NetworkException.unauthorisedRequest({
    String? message,
  }) = UnauthorisedRequest;
  
  const factory NetworkException.badRequest({
    String? message,
  }) = BadRequest;
  
  const factory NetworkException.notFound({
    String? message,
  }) = NotFound;
  
  const factory NetworkException.methodNotAllowed() = MethodNotAllowed;
  
  const factory NetworkException.notAcceptable() = NotAcceptable;
  
  const factory NetworkException.requestTimeout() = RequestTimeout;
  
  const factory NetworkException.sendTimeout() = SendTimeout;
  
  const factory NetworkException.receiveTimeout() = ReceiveTimeout;
  
  const factory NetworkException.conflict() = Conflict;
  
  const factory NetworkException.internalServerError({
    String? message,
  }) = InternalServerError;
  
  const factory NetworkException.notImplemented() = NotImplemented;
  
  const factory NetworkException.serviceUnavailable() = ServiceUnavailable;
  
  const factory NetworkException.noInternetConnection() = NoInternetConnection;
  
  const factory NetworkException.formatException({
    String? message,
  }) = FormatException;
  
  const factory NetworkException.unableToProcess({
    String? message,
  }) = UnableToProcess;
  
  const factory NetworkException.defaultError({
    required String error,
    int? statusCode,
  }) = DefaultError;
  
  const factory NetworkException.unexpectedError({
    String? message,
  }) = UnexpectedError;
}

/// 网络异常处理工具类
class NetworkExceptionHandler {
  /// 从 DioException 转换为 NetworkException
  static NetworkException fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return const NetworkException.requestCancelled();
        
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException.requestTimeout();
        
      case DioExceptionType.sendTimeout:
        return const NetworkException.sendTimeout();
        
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode;
        final message = dioException.response?.data?['message'] ?? 
                       dioException.message;
        
        switch (statusCode) {
          case 400:
            return NetworkException.badRequest(message: message);
          case 401:
            return NetworkException.unauthorisedRequest(message: message);
          case 404:
            return NetworkException.notFound(message: message);
          case 405:
            return const NetworkException.methodNotAllowed();
          case 406:
            return const NetworkException.notAcceptable();
          case 408:
            return const NetworkException.requestTimeout();
          case 409:
            return const NetworkException.conflict();
          case 500:
            return NetworkException.internalServerError(message: message);
          case 501:
            return const NetworkException.notImplemented();
          case 503:
            return const NetworkException.serviceUnavailable();
          default:
            return NetworkException.defaultError(
              error: message ?? 'Unknown error',
              statusCode: statusCode,
            );
        }
        
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return const NetworkException.noInternetConnection();
    }
  }
  
  /// 获取用户友好的错误信息
  static String getErrorMessage(NetworkException exception) {
    return exception.when(
      requestCancelled: () => '请求已取消',
      unauthorisedRequest: (message) => message ?? '未授权访问',
      badRequest: (message) => message ?? '请求参数错误',
      notFound: (message) => message ?? '请求的资源不存在',
      methodNotAllowed: () => '请求方法不被允许',
      notAcceptable: () => '服务器无法提供请求的内容类型',
      requestTimeout: () => '请求超时，请检查网络连接',
      sendTimeout: () => '发送数据超时',
      receiveTimeout: () => '接收数据超时',
      conflict: () => '请求冲突',
      internalServerError: (message) => message ?? '服务器内部错误',
      notImplemented: () => '服务器不支持该功能',
      serviceUnavailable: () => '服务暂时不可用',
      noInternetConnection: () => '网络连接不可用，请检查网络设置',
      formatException: (message) => message ?? '数据格式错误',
      unableToProcess: (message) => message ?? '无法处理请求',
      defaultError: (error, statusCode) => 
        '请求失败${statusCode != null ? ' (状态码: $statusCode)' : ''}: $error',
      unexpectedError: (message) => message ?? '发生未知错误',
    );
  }
}
