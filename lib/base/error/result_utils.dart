import 'result.dart';
import 'exceptions.dart';

/// Result 工具类，提供便捷的 Result 操作
class ResultUtils {
  /// 将多个 Result 合并为一个 Result
  /// 如果任何一个失败，返回第一个失败的结果
  static Result<List<T>> combine<T>(List<Result<T>> results) {
    final List<T> successResults = [];
    
    for (final result in results) {
      if (result.isFailure) {
        return Failure(result.error);
      }
      successResults.add(result.value);
    }
    
    return Success(successResults);
  }
  
  /// 将多个异步 Result 合并为一个 Result
  static Future<Result<List<T>>> combineAsync<T>(List<Future<Result<T>>> futures) async {
    final results = await Future.wait(futures);
    return combine(results);
  }
  
  /// 尝试多个操作，返回第一个成功的结果
  static Future<Result<T>> tryMultiple<T>(
    List<Future<Result<T>> Function()> operations,
  ) async {
    for (final operation in operations) {
      final result = await operation();
      if (result.isSuccess) {
        return result;
      }
    }
    
    // 如果所有操作都失败，返回最后一个失败结果
    final lastResult = await operations.last();
    return lastResult;
  }
  
  /// 重试操作，直到成功或达到最大重试次数
  static Future<Result<T>> retry<T>(
    Future<Result<T>> Function() operation, {
    int maxAttempts = 3,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    
    while (attempts < maxAttempts) {
      final result = await operation();
      
      if (result.isSuccess) {
        return result;
      }
      
      attempts++;
      
      if (attempts < maxAttempts) {
        await Future.delayed(delay * attempts);
      }
    }
    
    // 返回最后一次失败的结果
    return await operation();
  }
  
  /// 将 Result 转换为 Future，失败时抛出异常
  static Future<T> toFuture<T>(Result<T> result) async {
    if (result.isSuccess) {
      return result.value;
    }
    throw result.error;
  }
  
  /// 从 Future 创建 Result，捕获异常
  static Future<Result<T>> fromFuture<T>(Future<T> future) async {
    try {
      final result = await future;
      return Success(result);
    } catch (e) {
      if (e is AppException) {
        return Failure(e);
      }
      return Failure(ServerException('操作失败: ${e.toString()}'));
    }
  }
  
  /// 条件执行，根据条件决定是否执行操作
  static Future<Result<T?>> conditional<T>(
    bool condition,
    Future<Result<T>> Function() operation,
  ) async {
    if (!condition) {
      return const Success(null);
    }
    
    final result = await operation();
    if (result.isSuccess) {
      return Success(result.value);
    }
    
    return Failure(result.error);
  }
  
  /// 链式操作，前一个成功时执行下一个
  static Future<Result<R>> chain<T, R>(
    Future<Result<T>> first,
    Future<Result<R>> Function(T) next,
  ) async {
    final firstResult = await first;
    if (firstResult.isFailure) {
      return Failure(firstResult.error);
    }
    
    return await next(firstResult.value);
  }
}

/// Result 扩展方法
extension ResultListExtensions<T> on List<Result<T>> {
  /// 过滤出成功的结果
  List<T> get successValues {
    return where((result) => result.isSuccess)
        .map((result) => result.value)
        .toList();
  }
  
  /// 过滤出失败的结果
  List<AppException> get failureErrors {
    return where((result) => result.isFailure)
        .map((result) => result.error)
        .toList();
  }
  
  /// 检查是否所有结果都成功
  bool get allSuccess => every((result) => result.isSuccess);
  
  /// 检查是否有任何结果失败
  bool get hasFailure => any((result) => result.isFailure);
  
  /// 获取第一个失败的结果
  Result<T>? get firstFailure {
    try {
      return firstWhere((result) => result.isFailure);
    } catch (e) {
      return null;
    }
  }
}
