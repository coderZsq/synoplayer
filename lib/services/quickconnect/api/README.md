# QuickConnect API 抽象层

## 概述

本目录包含 QuickConnect 服务的 API 抽象层，将所有 HTTP 请求接口抽象化，便于单元测试和依赖注入。

## 文件结构

```
api/
├── quickconnect_api_interface.dart    # 抽象接口定义
├── quickconnect_api_impl.dart        # 具体实现类
├── quickconnect_api_mock.dart        # Mock 实现类
└── README.md                         # 本文档
```

## 核心组件

### 1. QuickConnectApiInterface

抽象接口，定义了所有 QuickConnect 需要的 HTTP 请求方法：

- `requestTunnel()` - 隧道请求
- `requestServerInfo()` - 服务器信息请求
- `requestLogin()` - 登录认证请求
- `testConnection()` - 连接测试
- `testMultipleConnections()` - 批量连接测试

### 2. QuickConnectApiImpl

具体实现类，使用 `ApiClient` 发送真实的 HTTP 请求。

### 3. QuickConnectApiMock

Mock 实现类，用于单元测试，提供可控的模拟数据和行为。

## 使用方式

### 在生产环境中使用

```dart
// 通过 Riverpod Provider 注入
final api = ref.watch(quickConnectApiProvider);
final authService = QuickConnectAuthService(api);

// 使用服务
final result = await authService.login(
  baseUrl: 'https://example.synology.me:5001',
  username: 'user',
  password: 'pass',
);
```

### 在单元测试中使用

```dart
import 'package:synoplayer/services/quickconnect/api/quickconnect_api_mock.dart';

void main() {
  test('登录功能测试', () async {
    // 创建 Mock API
    final mockApi = QuickConnectApiMockFactory.createSuccess();
    final authService = QuickConnectAuthService(mockApi);

    // 测试登录
    final result = await authService.login(
      baseUrl: 'https://test.com',
      username: 'user',
      password: 'pass',
    );

    expect(result.isSuccess, isTrue);
  });
}
```

### Mock 工厂使用

```dart
// 成功场景
final successMock = QuickConnectApiMockFactory.createSuccess();

// 失败场景
final failureMock = QuickConnectApiMockFactory.createFailure();

// OTP 验证场景
final otpMock = QuickConnectApiMockFactory.createOTPRequired();

// 超时场景
final timeoutMock = QuickConnectApiMockFactory.createTimeout();

// 自定义响应场景
final customMock = QuickConnectApiMockFactory.createCustom(
  tunnelResponse: customTunnelData,
  serverInfoResponse: customServerInfo,
  loginResult: customLoginResult,
  connectionTestResult: customConnectionResult,
);
```

## 依赖注入配置

在 `quickconnect_api_providers.dart` 中配置：

```dart
@riverpod
QuickConnectApiInterface quickConnectApi(QuickConnectApiRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return QuickConnectApiImpl(apiClient);
}
```

## 测试场景覆盖

Mock 实现支持以下测试场景：

1. **成功场景**
   - 正常登录成功
   - 连接测试成功
   - 地址解析成功

2. **失败场景**
   - 网络请求失败
   - 认证失败
   - 连接超时

3. **特殊场景**
   - OTP 二次验证
   - 无效凭据
   - 服务器错误

4. **自定义场景**
   - 自定义响应数据
   - 自定义延迟时间
   - 自定义错误信息

## 优势

1. **可测试性**：通过抽象接口，可以轻松创建 Mock 实现进行单元测试
2. **可维护性**：HTTP 请求逻辑集中管理，易于维护和修改
3. **可扩展性**：新增接口只需要在抽象接口中定义，然后在实现类中添加
4. **依赖注入**：支持 Riverpod 依赖注入，便于管理对象生命周期
5. **类型安全**：所有接口都有明确的类型定义，编译时检查错误

## 注意事项

1. 新增 API 接口时，需要同时更新：
   - `QuickConnectApiInterface`（抽象接口）
   - `QuickConnectApiImpl`（具体实现）
   - `QuickConnectApiMock`（Mock 实现）

2. Mock 实现应该尽可能覆盖真实场景，包括成功和失败情况

3. 所有 HTTP 相关的逻辑都应该在 API 层处理，服务层只处理业务逻辑

4. 使用 Riverpod Provider 进行依赖注入，避免直接创建实例
