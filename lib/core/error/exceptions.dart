/// 异常基类
/// 
/// 表示运行时异常
/// 用于在数据层捕获和处理错误
abstract class AppException {
  const AppException([this.errorMessage = '未知异常']);

  final String errorMessage;

  @override
  String toString() => 'AppException: $errorMessage';
}

/// 服务器异常
class ServerException extends AppException {
  const ServerException([String? errorMessage]) : super(errorMessage ?? '服务器异常');
}

/// 网络异常
class AppNetworkException extends AppException {
  const AppNetworkException([String? errorMessage]) : super(errorMessage ?? '网络异常');
}

/// 缓存异常
class CacheException extends AppException {
  const CacheException([String? errorMessage]) : super(errorMessage ?? '缓存异常');
}

/// 验证异常
class ValidationException extends AppException {
  const ValidationException([String? errorMessage]) : super(errorMessage ?? '验证异常');
}

/// 认证异常
class AuthException extends AppException {
  const AuthException([String? errorMessage]) : super(errorMessage ?? '认证异常');
}

/// 权限异常
class PermissionException extends AppException {
  const PermissionException([String? errorMessage]) : super(errorMessage ?? '权限异常');
}

/// 超时异常
class TimeoutException extends AppException {
  const TimeoutException([String? errorMessage]) : super(errorMessage ?? '操作超时');
}

/// 数据格式异常
class DataFormatException extends AppException {
  const DataFormatException([String? errorMessage]) : super(errorMessage ?? '数据格式异常');
}

/// 资源不存在异常
class NotFoundException extends AppException {
  const NotFoundException([String? errorMessage]) : super(errorMessage ?? '资源不存在');
}

/// 资源已存在异常
class AlreadyExistsException extends AppException {
  const AlreadyExistsException([String? errorMessage]) : super(errorMessage ?? '资源已存在');
}

/// 业务逻辑异常
class BusinessLogicException extends AppException {
  const BusinessLogicException([String? errorMessage]) : super(errorMessage ?? '业务逻辑异常');
}

/// 配置异常
class ConfigurationException extends AppException {
  const ConfigurationException([String? errorMessage]) : super(errorMessage ?? '配置异常');
}

/// 依赖注入异常
class DependencyInjectionException extends AppException {
  const DependencyInjectionException([String? errorMessage]) : super(errorMessage ?? '依赖注入异常');
}

/// HTTP 异常
class HttpException extends AppException {
  const HttpException({
    required this.statusCode,
    String? errorMessage,
  }) : super(errorMessage ?? 'HTTP 异常');

  final int statusCode;

  @override
  String toString() => 'HttpException: $statusCode - $errorMessage';
}

/// JSON 解析异常
class JsonParseException extends AppException {
  const JsonParseException([String? errorMessage]) : super(errorMessage ?? 'JSON 解析异常');
}

/// 序列化异常
class SerializationException extends AppException {
  const SerializationException([String? errorMessage]) : super(errorMessage ?? '序列化异常');
}

/// 反序列化异常
class DeserializationException extends AppException {
  const DeserializationException([String? errorMessage]) : super(errorMessage ?? '反序列化异常');
}
