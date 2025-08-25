import 'exceptions.dart';

/// Result 类型，用于表示操作的成功或失败
sealed class Result<T> {
  const Result();
  
  /// 检查是否为成功状态
  bool get isSuccess => this is Success<T>;
  
  /// 检查是否为失败状态
  bool get isFailure => this is Failure<T>;
  
  /// 获取成功值，如果失败则抛出异常
  T get value {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }
    throw StateError('Cannot get value from Failure Result');
  }
  
  /// 获取错误，如果成功则抛出异常
  AppException get error {
    if (this is Failure<T>) {
      return (this as Failure<T>)._error;
    }
    throw StateError('Cannot get error from Success Result');
  }
  
  /// 映射成功值
  Result<R> map<R>(R Function(T) transform) {
    if (this is Success<T>) {
      return Success(transform((this as Success<T>).data));
    }
    return Failure<R>((this as Failure<T>)._error);
  }
  
  /// 映射失败值
  Result<T> mapError(AppException Function(AppException) transform) {
    if (this is Failure<T>) {
      return Failure(transform((this as Failure<T>)._error));
    }
    return this;
  }
  
  /// 处理成功和失败情况
  R fold<R>(
    R Function(T) onSuccess,
    R Function(AppException) onFailure,
  ) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    }
    return onFailure((this as Failure<T>)._error);
  }
  
  /// 当成功时执行操作
  Result<T> whenSuccess(void Function(T) action) {
    if (this is Success<T>) {
      action((this as Success<T>).data);
    }
    return this;
  }
  
  /// 当失败时执行操作
  Result<T> whenFailure(void Function(AppException) action) {
    if (this is Failure<T>) {
      action((this as Failure<T>)._error);
    }
    return this;
  }
}

/// 成功结果
class Success<T> extends Result<T> {
  final T data;
  
  const Success(this.data);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
  
  @override
  String toString() => 'Success($data)';
}

/// 失败结果
class Failure<T> extends Result<T> {
  final AppException _error;
  
  const Failure(this._error);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          _error == other._error;

  @override
  int get hashCode => _error.hashCode;
  
  @override
  String toString() => 'Failure($_error)';
}

/// Result 扩展方法
extension ResultExtensions<T> on Result<T> {
  /// 安全获取值，失败时返回默认值
  T getOrElse(T defaultValue) {
    return fold(
      (data) => data,
      (_) => defaultValue,
    );
  }
  
  /// 安全获取值，失败时返回 null
  T? getOrNull() {
    return fold(
      (data) => data,
      (_) => null,
    );
  }
  
  /// 转换为可空类型
  T? toNullable() {
    return fold(
      (data) => data,
      (_) => null,
    );
  }
}

/// 创建成功结果的便捷方法
Result<T> success<T>(T data) => Success(data);

/// 创建失败结果的便捷方法
Result<T> failure<T>(AppException error) => Failure(error);

/// 从可能抛出异常的函数创建 Result
Future<Result<T>> safeAsync<T>(Future<T> Function() operation) async {
  try {
    final result = await operation();
    return Success(result);
  } catch (e) {
    if (e is AppException) {
      return Failure(e);
    }
    return Failure(ServerException('操作失败: ${e.toString()}'));
  }
}

/// 从同步函数创建 Result
Result<T> safe<T>(T Function() operation) {
  try {
    final result = operation();
    return Success(result);
  } catch (e) {
    if (e is AppException) {
      return Failure(e);
    }
    return Failure(ServerException('操作失败: ${e.toString()}'));
  }
}
