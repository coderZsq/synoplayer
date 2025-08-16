# Retrofit baseUrl 问题修复总结

## 问题描述

从日志中可以看出，Retrofit 实现时出现了 "No host specified in URI" 错误：

```
flutter: [2025-08-16T11:01:59.601968] [HTTP] ❌ ERROR[null] => PATH: /Serv.php
flutter: [2025-08-16T11:01:59.602391] [QuickConnectApiAdapter] Retrofit 隧道请求失败: DioException [unknown]: null
Error: Invalid argument(s): No host specified in URI /Serv.php
```

## 问题分析

问题出现在 Retrofit API 接口的 baseUrl 配置上：

1. **隧道请求和服务器信息请求**：使用相对路径 `/Serv.php`，但没有设置正确的 baseUrl
2. **登录请求和连接测试**：使用相对路径 `/webapi/auth.cgi` 和 `/webapi/query.cgi`，同样没有设置正确的 baseUrl
3. **Retrofit 实例创建**：在 Provider 中创建时没有设置 baseUrl

## 修复方案

### 1. 修复 Retrofit API 接口 (`quickconnect_retrofit_api.dart`)

为不同的 API 调用设置正确的 baseUrl：

```dart
/// 发送隧道请求获取中继服务器信息
/// 使用 QuickConnect 隧道服务 URL
@RestApi(baseUrl: "https://global.quickconnect.to")
@POST('/Serv.php')
Future<TunnelResponse> requestTunnel(
  @Body() Map<String, dynamic> requestBody,
);

/// 发送服务器信息请求
/// 使用 QuickConnect 服务器信息服务 URL
@RestApi(baseUrl: "https://cnc.quickconnect.cn")
@POST('/Serv.php')
Future<ServerInfoResponse> requestServerInfo(
  @Body() Map<String, dynamic> requestBody,
);

/// 发送 QuickConnect 全球服务器信息请求
/// 使用 QuickConnect 全球服务 URL
@RestApi(baseUrl: "https://global.quickconnect.to")
@POST('/Serv.php')
Future<QuickConnectServerInfoResponse> requestQuickConnectServerInfo(
  @Body() Map<String, dynamic> requestBody,
);
```

### 2. 修复适配器中的动态 baseUrl 调用 (`quickconnect_api_adapter.dart`)

对于需要动态 baseUrl 的方法（登录和连接测试），在调用时创建新的 Retrofit 实例：

```dart
/// 使用 Retrofit 实现登录请求
Future<LoginResult> _requestLoginWithRetrofit({
  required String baseUrl,
  required String username,
  required String password,
  String? otpCode,
}) async {
  try {
    // 为登录请求创建新的 Retrofit 实例，设置正确的 baseUrl
    final loginRetrofitApi = QuickConnectRetrofitApi(
      retrofitApi.dio,
      baseUrl: baseUrl,
    );

    final response = await loginRetrofitApi.requestLogin(
      'SYNO.API.Auth',
      QuickConnectConstants.apiVersion3.toString(),
      'login',
      username.trim(),
      password.trim(),
      QuickConnectConstants.sessionFileStation,
      QuickConnectConstants.formatSid,
      otpCode?.trim(),
    );

    return _handleLoginResponse(response);
  } catch (e) {
    // ... 错误处理
  }
}

/// 使用 Retrofit 实现连接测试
Future<ConnectionTestResult> _testConnectionWithRetrofit(String baseUrl) async {
  try {
    // 为连接测试创建新的 Retrofit 实例，设置正确的 baseUrl
    final testRetrofitApi = QuickConnectRetrofitApi(
      retrofitApi.dio,
      baseUrl: baseUrl,
    );
    
    await testRetrofitApi.testConnection(
      'SYNO.API.Info',
      '1',
      'query',
      'SYNO.API.Auth',
    );
    
    // ... 成功处理
  } catch (e) {
    // ... 错误处理
  }
}
```

### 3. 更新 Provider 配置 (`quickconnect_api_providers.dart`)

添加了注释说明 baseUrl 的动态设置机制：

```dart
/// QuickConnect API 提供者
@riverpod
QuickConnectApiInterface quickConnectApi(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final dio = ref.watch(dioProvider);
  
  // 创建 Retrofit API 实例，使用默认的 QuickConnect 服务 URL
  // 注意：具体的 baseUrl 会在调用时动态设置
  final retrofitApi = QuickConnectRetrofitApi(dio);
  
  return QuickConnectApiAdapter(
    apiClient: apiClient,
    retrofitApi: retrofitApi,
  );
}
```

## 修复后的架构

### 静态 baseUrl API
- **隧道请求**：`https://global.quickconnect.to/Serv.php`
- **服务器信息请求**：`https://cnc.quickconnect.cn/Serv.php`
- **全球服务器信息请求**：`https://global.quickconnect.to/Serv.php`

### 动态 baseUrl API
- **登录请求**：`{baseUrl}/webapi/auth.cgi`
- **连接测试**：`{baseUrl}/webapi/query.cgi`

其中 `{baseUrl}` 是动态传入的服务器地址，如：
- `https://SHUANGQUAN.direct.quickconnect.cn:5001`
- `https://synr-cn4.SHUANGQUAN.direct.quickconnect.cn:40625`

## 验证步骤

1. **代码生成**：运行 `flutter packages pub run build_runner build` 确保生成的代码正确
2. **功能测试**：测试各个 API 调用是否正常工作
3. **日志验证**：确认不再出现 "No host specified in URI" 错误

## 注意事项

1. **不要修改 .g.dart 文件**：这些是自动生成的文件，修改后会被覆盖
2. **baseUrl 优先级**：`@RestApi` 注解中的 baseUrl 会覆盖 Dio 实例的 baseUrl
3. **动态 baseUrl**：对于需要动态 baseUrl 的方法，必须在调用时创建新的 Retrofit 实例
4. **降级机制**：Retrofit 失败时会自动降级到旧实现，确保向后兼容

## 预期效果

修复后，Retrofit 实现应该能够：
1. 正确发送隧道请求到 `https://global.quickconnect.to/Serv.php`
2. 正确发送服务器信息请求到 `https://cnc.quickconnect.cn/Serv.php`
3. 正确发送登录请求到动态的服务器地址
4. 正确发送连接测试请求到动态的服务器地址

不再出现 "No host specified in URI" 错误，Retrofit 实现能够正常工作。
