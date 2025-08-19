import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'equatable_freezed_example.freezed.dart';
part 'equatable_freezed_example.g.dart';

/// 示例 1: 使用 Freezed 自动实现 Equatable
/// 
/// Freezed 会自动为所有生成的类实现 Equatable，
/// 无需手动实现 == 操作符和 hashCode
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

/// 示例 2: 自定义类与 Freezed 一起使用 Equatable
/// 
/// 对于非 Freezed 类，可以手动继承 Equatable
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

  /// 创建副本的方法
  UserProfile copyWith({
    String? userId,
    String? displayName,
    String? bio,
    DateTime? lastSeen,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}

/// 示例 3: 联合类型 (Union Types) 自动支持 Equatable
@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult.success({
    required User user,
    required String token,
    required DateTime expiresAt,
  }) = AuthSuccess;

  const factory AuthResult.failure({
    required String error,
    String? errorCode,
    Map<String, dynamic>? details,
  }) = AuthFailure;

  const factory AuthResult.pending({
    required String message,
    Duration? estimatedTime,
  }) = AuthPending;
}

/// 示例 4: 嵌套的 Freezed 类
@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success({
    required T data,
    required int statusCode,
    String? message,
    Map<String, dynamic>? metadata,
  }) = ApiSuccess<T>;

  const factory ApiResponse.error({
    required String error,
    required int statusCode,
    String? errorCode,
    Map<String, dynamic>? details,
  }) = ApiError<T>;
}

/// 示例 5: 使用 Equatable 进行集合操作
class EquatableUsageExamples {
  /// 演示 Freezed 类的相等性比较
  static void demonstrateFreezedEquality() {
    print('=== Freezed 类相等性演示 ===');
    
    // 创建两个相同的用户
    final user1 = const User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      isActive: true,
    );
    
    final user2 = const User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      isActive: true,
    );
    
    // 验证相等性
    print('user1 == user2: ${user1 == user2}'); // true
    print('user1.hashCode == user2.hashCode: ${user1.hashCode == user2.hashCode}'); // true
    
    // 在集合中使用
    final users = <User>{user1, user2};
    print('集合中的用户数量: ${users.length}'); // 1 (去重)
  }

  /// 演示自定义 Equatable 类的相等性比较
  static void demonstrateCustomEquatableEquality() {
    print('\n=== 自定义 Equatable 类相等性演示 ===');
    
    final profile1 = const UserProfile(
      userId: '1',
      displayName: 'John Doe',
      bio: 'Software Developer',
      lastSeen: null,
    );
    
    final profile2 = const UserProfile(
      userId: '1',
      displayName: 'John Doe',
      bio: 'Software Developer',
      lastSeen: null,
    );
    
    // 验证相等性
    print('profile1 == profile2: ${profile1 == profile2}'); // true
    print('profile1.hashCode == profile2.hashCode: ${profile1.hashCode == profile2.hashCode}'); // true
    
    // 在集合中使用
    final profiles = <UserProfile>{profile1, profile2};
    print('集合中的档案数量: ${profiles.length}'); // 1 (去重)
  }

  /// 演示联合类型的相等性比较
  static void demonstrateUnionTypeEquality() {
    print('\n=== 联合类型相等性演示 ===');
    
    final success1 = const AuthResult.success(
      user: User(id: '1', name: 'John', email: 'john@example.com'),
      token: 'token123',
      expiresAt: DateTime(2024, 12, 31),
    );
    
    final success2 = const AuthResult.success(
      user: User(id: '1', name: 'John', email: 'john@example.com'),
      token: 'token123',
      expiresAt: DateTime(2024, 12, 31),
    );
    
    final failure = const AuthResult.failure(
      error: 'Invalid credentials',
      errorCode: 'AUTH_001',
    );
    
    // 验证相等性
    print('success1 == success2: ${success1 == success2}'); // true
    print('success1 == failure: ${success1 == failure}'); // false
    
    // 在集合中使用
    final results = <AuthResult>{success1, success2, failure};
    print('集合中的结果数量: ${results.length}'); // 2 (去重)
  }

  /// 演示泛型类的相等性比较
  static void demonstrateGenericEquality() {
    print('\n=== 泛型类相等性演示 ===');
    
    final response1 = const ApiResponse.success(
      data: 'Hello World',
      statusCode: 200,
      message: 'Success',
    );
    
    final response2 = const ApiResponse.success(
      data: 'Hello World',
      statusCode: 200,
      message: 'Success',
    );
    
    final errorResponse = const ApiResponse.error(
      error: 'Not Found',
      statusCode: 404,
    );
    
    // 验证相等性
    print('response1 == response2: ${response1 == response2}'); // true
    print('response1 == errorResponse: ${response1 == errorResponse}'); // false
    
    // 在集合中使用
    final responses = <ApiResponse<String>>{response1, response2, errorResponse};
    print('集合中的响应数量: ${responses.length}'); // 2 (去重)
  }

  /// 演示实际使用场景
  static void demonstratePracticalUsage() {
    print('\n=== 实际使用场景演示 ===');
    
    // 1. 在 Provider 状态比较中的使用
    final oldState = const AuthResult.success(
      user: User(id: '1', name: 'John', email: 'john@example.com'),
      token: 'old_token',
      expiresAt: DateTime(2024, 12, 31),
    );
    
    final newState = const AuthResult.success(
      user: User(id: '1', name: 'John', email: 'john@example.com'),
      token: 'new_token',
      expiresAt: DateTime(2024, 12, 31),
    );
    
    // 状态变化检测
    if (oldState != newState) {
      print('检测到状态变化，需要更新 UI');
    }
    
    // 2. 在缓存键生成中的使用
    final cacheKey1 = 'user_${oldState.hashCode}';
    final cacheKey2 = 'user_${newState.hashCode}';
    print('缓存键1: $cacheKey1');
    print('缓存键2: $cacheKey2');
    print('缓存键是否相同: ${cacheKey1 == cacheKey2}');
    
    // 3. 在测试中的使用
    print('\n=== 测试场景演示 ===');
    final testUser = const User(
      id: 'test_1',
      name: 'Test User',
      email: 'test@example.com',
    );
    
    // 验证对象创建
    assert(testUser.id == 'test_1');
    assert(testUser.name == 'Test User');
    assert(testUser.email == 'test@example.com');
    
    // 验证相等性
    final testUserCopy = testUser.copyWith();
    assert(testUser == testUserCopy);
    
    print('所有测试通过！');
  }
}

/// 主函数，运行所有演示
void main() {
  EquatableUsageExamples.demonstrateFreezedEquality();
  EquatableUsageExamples.demonstrateCustomEquatableEquality();
  EquatableUsageExamples.demonstrateUnionTypeEquality();
  EquatableUsageExamples.demonstrateGenericEquality();
  EquatableUsageExamples.demonstratePracticalUsage();
}
