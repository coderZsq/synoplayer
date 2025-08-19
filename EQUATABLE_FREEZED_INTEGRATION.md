# Equatable 与 Freezed 集成使用指南

## 概述

本项目已经成功集成了 **Equatable** 和 **Freezed** 两个强大的 Dart 库，用于创建不可变的数据类和实现值相等性比较。

## 依赖配置

在 `pubspec.yaml` 中添加了以下依赖：

```yaml
dependencies:
  # 不可变数据类
  freezed_annotation: ^2.4.1
  
  # 值相等性比较
  equatable: ^2.0.5

dev_dependencies:
  # 代码生成
  build_runner: ^2.4.8
  freezed: ^2.4.6
  json_serializable: ^6.8.0
```

## 核心特性

### 1. Freezed 自动实现 Equatable

**重要说明**: Freezed 会自动为所有生成的类实现 Equatable，无需手动实现！

```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
    @Default(false) bool isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

Freezed 会自动生成：
- `==` 操作符
- `hashCode` 实现
- `copyWith` 方法
- `toString` 方法
- JSON 序列化/反序列化

### 2. 手动实现 Equatable（非 Freezed 类）

对于不需要 Freezed 的简单类，可以手动继承 Equatable：

```dart
class UserProfile extends Equatable {
  const UserProfile({
    required this.userId,
    required this.displayName,
    this.bio,
    this.lastSeen,
  });

  final String userId;
  final String displayName;
  final String? bio;
  final DateTime? lastSeen;

  @override
  List<Object?> get props => [userId, displayName, bio, lastSeen];
}
```

## 实际使用场景

### 1. 状态管理中的相等性比较

```dart
// 在 Riverpod Provider 中
class UserNotifier extends StateNotifier<User?> {
  void updateUser(User newUser) {
    // Freezed 自动实现相等性比较
    if (state != newUser) {
      state = newUser;
      // 只有在用户真正改变时才更新
    }
  }
}
```

### 2. 集合操作中的去重

```dart
final users = <User>{
  User(id: '1', name: 'John', email: 'john@example.com'),
  User(id: '1', name: 'John', email: 'john@example.com'), // 重复
  User(id: '2', name: 'Jane', email: 'jane@example.com'),
};

print(users.length); // 输出: 2 (自动去重)
```

### 3. 缓存键生成

```dart
class UserCache {
  final Map<String, User> _cache = {};
  
  void cacheUser(User user) {
    // 使用 hashCode 作为缓存键
    final key = 'user_${user.hashCode}';
    _cache[key] = user;
  }
}
```

### 4. 测试中的断言

```dart
test('should create user with correct data', () {
  final user1 = const User(
    id: '1',
    name: 'John',
    email: 'john@example.com',
  );
  
  final user2 = const User(
    id: '1',
    name: 'John',
    email: 'john@example.com',
  );
  
  // 相等性比较
  expect(user1, equals(user2));
  expect(user1.hashCode, equals(user2.hashCode));
});
```

## 项目中的实际应用

### 1. API 响应模型

```dart
@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success({
    required T data,
    required int statusCode,
    String? message,
    Map<String, dynamic>? extra,
  }) = ApiSuccess<T>;
  
  const factory ApiResponse.error({
    required String message,
    required int statusCode,
    String? errorCode,
    dynamic error,
    Map<String, dynamic>? extra,
  }) = ApiError<T>;
}
```

### 2. 认证状态管理

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.authenticated(LoginCredentials credentials) = AuthAuthenticated;
  const factory AuthState.authenticating() = AuthAuthenticating;
}
```

### 3. 网络异常处理

```dart
@freezed
class NetworkException with _$NetworkException implements Exception {
  const factory NetworkException.requestCancelled() = RequestCancelled;
  const factory NetworkException.unauthorisedRequest({String? message}) = UnauthorisedRequest;
  const factory NetworkException.badRequest({String? message}) = BadRequest;
  // ... 更多异常类型
}
```

## 最佳实践

### 1. 优先使用 Freezed

- 对于复杂的数据模型，优先使用 Freezed
- Freezed 自动实现 Equatable，无需额外代码
- 支持联合类型、泛型、JSON 序列化等高级特性

### 2. 手动 Equatable 的使用场景

- 简单的工具类
- 不需要 JSON 序列化的类
- 需要自定义相等性逻辑的类

### 3. 性能考虑

- Equatable 的相等性比较是高效的
- 在集合操作中自动去重
- 适合在状态管理中使用

### 4. 测试友好

- 生成的代码易于测试
- 相等性比较可以用于断言
- 支持深度比较

## 代码生成

运行以下命令生成必要的代码：

```bash
# 生成所有代码
flutter packages pub run build_runner build --delete-conflicting-outputs

# 监听文件变化，自动生成
flutter packages pub run build_runner watch
```

## 注意事项

1. **不要手动实现 Equatable**: Freezed 已经自动实现了
2. **保持不可变性**: 所有字段都应该是 final
3. **使用 const 构造函数**: 提高性能
4. **定期运行 build_runner**: 确保生成的代码是最新的

## 示例代码

查看 `lib/core/examples/equatable_freezed_example.dart` 文件，了解完整的使用示例。

## 总结

通过集成 Equatable 和 Freezed，我们获得了：

- **类型安全**: 编译时错误检查
- **不可变性**: 防止意外状态修改
- **值相等性**: 高效的相等性比较
- **代码生成**: 减少样板代码
- **测试友好**: 易于编写和维护测试
- **性能优化**: 自动优化和缓存

这种组合为 Flutter 应用提供了强大、高效、可维护的数据模型解决方案。
