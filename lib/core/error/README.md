# 错误处理机制使用指南

## 概述

本项目的错误处理机制采用了多层架构设计，包括：

1. **异常分类系统** - 统一的异常类型定义
2. **错误映射器** - 将技术错误转换为用户友好的消息
3. **重试机制** - 网络层自动重试策略
4. **全局错误边界** - 应用级别的错误捕获和显示
5. **错误处理器** - 可扩展的错误处理逻辑

## 核心组件

### 1. 异常分类 (exceptions.dart)

```dart
// 业务异常基类
abstract class AppException implements Exception {
  final String message;
  final String? code;
}

// 具体异常类型
class NetworkException extends AppException { ... }
class AuthException extends AppException { ... }
class BusinessException extends AppException { ... }
class ServerException extends AppException { ... }
class ValidationException extends AppException { ... }
```

### 2. 错误映射器 (error_mapper.dart)

```dart
// 将异常转换为用户友好消息
String message = ErrorMapper.mapToUserMessage(error);

// 判断错误类型
bool isNetworkError = ErrorMapper.isNetworkError(error);
bool isAuthError = ErrorMapper.isAuthError(error);
bool isRetryable = ErrorMapper.isRetryableError(error);

// 获取错误类型描述
String typeDesc = ErrorMapper.getErrorTypeDescription(error);
```

### 3. 重试拦截器 (retry_interceptor.dart)

```dart
// 在 Dio 中添加重试拦截器
final dio = Dio();
dio.addRetryInterceptor(RetryInterceptorConfig.networkConfig);

// 或者使用预配置的 Dio
final dio = NetworkConfig.createNetworkRetryDio();
```

### 4. 全局错误处理 (global_error_handler.dart)

```dart
// 在 main.dart 中包装应用
void main() {
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref) {
          return GlobalErrorBoundary(
            child: MyApp(),
          );
        },
      ),
    ),
  );
}

// 添加自定义错误处理器
final handler = GlobalErrorHandler();
handler.addHandler(MyCustomErrorHandler());
```

## 使用示例

### 1. 在 Provider 中处理错误

```dart
@riverpod
class MyNotifier extends _$MyNotifier {
  Future<void> performOperation() async {
    try {
      state = const AsyncValue.loading();
      final result = await someAsyncOperation();
      state = AsyncValue.data(result);
    } catch (e, stackTrace) {
      // 使用错误映射器获取用户友好消息
      final errorMessage = ErrorMapper.mapToUserMessage(e);
      state = AsyncValue.error(errorMessage, stackTrace);
    }
  }
}
```

### 2. 在 Widget 中显示错误

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myProvider);
    
    return state.when(
      data: (data) => Text('Success: $data'),
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
```

### 3. 自定义错误处理器

```dart
class MyCustomErrorHandler implements ErrorHandler {
  @override
  void handleError(dynamic error, StackTrace stackTrace) {
    // 处理特定类型的错误
    if (error is BusinessException) {
      // 记录到分析服务
      AnalyticsService.recordError(error);
    }
    
    // 发送到错误报告服务
    ErrorReportingService.report(error, stackTrace);
  }
}

// 注册处理器
final handler = GlobalErrorHandler();
handler.addHandler(MyCustomErrorHandler());
```

### 4. 网络请求重试

```dart
// 自动重试配置
final dio = NetworkConfig.createDio(
  enableRetry: true,
  retryConfig: RetryInterceptorConfig.networkConfig,
);

// 或者使用预配置
final dio = NetworkConfig.createNetworkRetryDio();
final dio = NetworkConfig.createServerRetryDio();
```

## 配置选项

### 重试策略配置

```dart
const retryConfig = RetryInterceptorConfig(
  maxRetries: 3,                    // 最大重试次数
  baseDelayMs: 1000,               // 基础延迟时间（毫秒）
  maxDelayMs: 10000,               // 最大延迟时间（毫秒）
  backoffMultiplier: 2.0,          // 延迟增长因子
  useExponentialBackoff: true,     // 是否使用指数退避
  retryableStatusCodes: [500, 502, 503, 504], // 可重试的状态码
);
```

### 预定义重试策略

```dart
// 网络错误重试策略
RetryInterceptorConfig.networkConfig

// 服务器错误重试策略
RetryInterceptorConfig.serverConfig

// 默认重试策略
RetryInterceptorConfig.defaultConfig
```

## 最佳实践

1. **异常分类**: 根据业务逻辑合理分类异常类型
2. **用户友好**: 使用 ErrorMapper 将技术错误转换为用户可理解的消息
3. **重试策略**: 为不同类型的错误配置合适的重试策略
4. **错误边界**: 在应用顶层使用 GlobalErrorBoundary 捕获未处理的错误
5. **错误处理**: 实现自定义错误处理器处理特定业务逻辑
6. **日志记录**: 记录错误信息用于调试和监控

## 扩展点

- 实现自定义的 `ErrorHandler` 接口
- 扩展 `ErrorMapper` 添加新的错误类型映射
- 自定义重试策略和拦截器
- 集成第三方错误报告服务
- 添加错误统计和分析功能
