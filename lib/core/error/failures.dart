import 'package:equatable/equatable.dart';

/// 失败基类
/// 
/// 表示操作失败的情况
/// 用于在领域层和表现层之间传递错误信息
abstract class Failure extends Equatable {
  const Failure([this.message = '未知错误']);

  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Failure: $message';
}

/// 服务器失败
class ServerFailure extends Failure {
  const ServerFailure([super.message = '服务器错误']);
}

/// 网络失败
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = '网络错误']);
}

/// 缓存失败
class CacheFailure extends Failure {
  const CacheFailure([super.message = '缓存错误']);
}

/// 验证失败
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = '验证失败']);
}

/// 认证失败
class AuthFailure extends Failure {
  const AuthFailure([super.message = '认证失败']);
}

/// 权限失败
class PermissionFailure extends Failure {
  const PermissionFailure([super.message = '权限不足']);
}

/// 未知失败
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = '未知错误']);
}

/// 超时失败
class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = '操作超时']);
}

/// 数据格式失败
class DataFormatFailure extends Failure {
  const DataFormatFailure([super.message = '数据格式错误']);
}

/// 资源不存在失败
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = '资源不存在']);
}

/// 资源已存在失败
class AlreadyExistsFailure extends Failure {
  const AlreadyExistsFailure([super.message = '资源已存在']);
}

/// 业务逻辑失败
class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure([super.message = '业务逻辑错误']);
}

/// 配置失败
class ConfigurationFailure extends Failure {
  const ConfigurationFailure([super.message = '配置错误']);
}

/// 依赖注入失败
class DependencyInjectionFailure extends Failure {
  const DependencyInjectionFailure([super.message = '依赖注入失败']);
}
