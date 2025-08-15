# 网络层封装

这个网络层基于 Dio 构建，为应用提供统一的网络请求接口，支持拦截器、错误处理、日志记录等功能。

## 核心组件

### 1. ApiClient
统一的 API 客户端，支持 GET、POST、PUT、DELETE、PATCH 等请求方法。

```dart
final apiClient = ref.read(apiClientProvider);

// GET 请求
final response = await apiClient.get<Map<String, dynamic>>(
  '/api/users',
  fromJson: (data) => data as Map<String, dynamic>,
);

// POST 请求
final response = await apiClient.post<User>(
  '/api/users',
  data: {'name': 'John', 'email': 'john@example.com'},
  fromJson: (data) => User.fromJson(data),
);
```

### 2. ApiResponse
统一的响应包装类，使用 Freezed 生成。

```dart
response.when(
  success: (data, statusCode, message, extra) {
    // 处理成功响应
    print('Data: $data');
  },
  error: (message, statusCode, errorCode, error, extra) {
    // 处理错误响应
    print('Error: $message');
  },
);
```

### 3. NetworkException
统一的网络异常处理。

```dart
try {
  final response = await apiClient.get('/api/data');
} on NetworkException catch (e) {
  final errorMessage = NetworkExceptionHandler.getErrorMessage(e);
  print('Network error: $errorMessage');
}
```

## 拦截器

### 1. LoggingInterceptor
记录请求和响应日志。

### 2. AuthInterceptor
自动添加认证信息到请求中。

### 3. ConnectivityInterceptor
检查网络连接状态。

## Providers

### 1. 通用网络服务
```dart
final apiClient = ref.read(apiClientProvider);
```

### 2. QuickConnect 专用网络服务
```dart
final quickConnectApiClient = ref.read(quickConnectApiClientProvider);
```

## 使用示例

### 在 Widget 中使用
```dart
class UserListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<ApiResponse<List<User>>>(
      future: ref.read(apiClientProvider).get<List<User>>(
        '/api/users',
        fromJson: (data) => (data as List)
            .map((item) => User.fromJson(item))
            .toList(),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.when(
            success: (users, _, __, ___) => ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(users[index].name),
              ),
            ),
            error: (message, _, __, ___, ____) => Center(
              child: Text('Error: $message'),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
```

### 在 Repository 中使用
```dart
class UserRepository {
  UserRepository(this._apiClient);
  
  final ApiClient _apiClient;

  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        '/api/users/$id',
        fromJson: (data) => data as Map<String, dynamic>,
      );
      
      return response.when(
        success: (data, _, __, ___) => Right(User.fromJson(data)),
        error: (message, _, __, ___, ____) => Left(NetworkFailure(message)),
      );
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
```

## 配置

网络层的配置在 `providers/network_providers.dart` 中进行：

```dart
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  // 添加拦截器
  dio.interceptors.addAll([
    ConnectivityInterceptor(connectivity: ref.read(connectivityProvider)),
    AuthInterceptor(ref),
    LoggingInterceptor(),
  ]);

  return dio;
});
```

## 最佳实践

1. **使用类型安全的 fromJson 回调**来确保响应数据的正确解析
2. **统一错误处理**，使用 ApiResponse.when() 方法
3. **合理设置超时时间**，根据不同的请求类型调整
4. **使用 Riverpod Providers**进行依赖注入
5. **在 Repository 层**使用网络层，而不是直接在 UI 层使用
