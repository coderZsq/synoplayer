# QuickConnect 服务

## 概述

QuickConnect 服务提供了与群晖 NAS 的 QuickConnect 功能交互的完整解决方案，包括地址解析、认证登录、连接测试等功能。

## 架构设计

### 核心组件

1. **QuickConnectApiAdapter** - API 适配器，智能选择使用 Retrofit 或旧实现
2. **QuickConnectService** - 主服务，统一入口
3. **QuickConnectAuthService** - 认证服务
4. **QuickConnectAddressResolver** - 地址解析服务
5. **QuickConnectConnectionService** - 连接测试服务
6. **QuickConnectSmartLoginService** - 智能登录服务

### 设计模式

- **适配器模式**: `QuickConnectApiAdapter` 统一新旧 API 实现
- **策略模式**: 根据配置动态选择 API 实现
- **降级机制**: Retrofit 失败时自动降级到旧实现
- **依赖注入**: 使用 Riverpod 进行依赖管理

## QuickConnectApiAdapter 使用指南

### 1. 基本使用

```dart
// 通过 Provider 获取适配器
final api = ref.watch(quickConnectApiProvider);

// 使用适配器进行地址解析
final tunnelResponse = await api.requestTunnel('your_quickconnect_id');
final serverInfo = await api.requestServerInfo('your_quickconnect_id');

// 使用适配器进行登录
final loginResult = await api.requestLogin(
  baseUrl: 'https://your.nas.com',
  username: 'username',
  password: 'password',
);

// 使用适配器测试连接
final connectionResult = await api.testConnection('https://your.nas.com');
```

### 2. 智能降级机制

`QuickConnectApiAdapter` 具有智能降级机制：

1. **优先使用 Retrofit**: 如果配置启用，首先尝试使用 Retrofit 实现
2. **自动降级**: 如果 Retrofit 失败，自动降级到旧实现
3. **无缝切换**: 用户无需关心底层实现，适配器自动处理

```dart
// 适配器内部逻辑
@override
Future<TunnelResponse?> requestTunnel(String quickConnectId) async {
  try {
    // 首先尝试使用 Retrofit 实现
    final shouldUseRetrofit = await RetrofitMigrationConfig.shouldUseRetrofitForFeature('tunnel');
    
    if (shouldUseRetrofit) {
      try {
        final result = await _requestTunnelWithRetrofit(quickConnectId);
        if (result != null) {
          return result;
        }
      } catch (e) {
        // Retrofit 失败，记录警告并降级
        AppLogger.warning('Retrofit 隧道请求失败，降级到旧实现: $e');
      }
    }
    
    // 降级到旧实现
    return await _requestTunnelWithLegacy(quickConnectId);
    
  } catch (e) {
    // 完全失败
    AppLogger.error('隧道请求完全失败: $e');
    return null;
  }
}
```

### 3. 配置控制

#### 功能开关

```dart
// 在 lib/core/config/feature_flags.dart 中配置
class FeatureFlags {
  static bool get useRetrofitApi {
    if (kDebugMode) {
      const useRetrofit = bool.fromEnvironment('USE_RETROFIT_API', defaultValue: true);
      return useRetrofit;
    }
    return false;
  }
}
```

#### 迁移阶段

```dart
// 在 lib/core/config/retrofit_migration_config.dart 中配置
enum MigrationPhase {
  legacyOnly,           // 仅使用旧实现
  tunnelRetrofit,       // 隧道请求使用 Retrofit
  serverInfoRetrofit,   // 服务器信息使用 Retrofit
  loginRetrofit,        // 登录请求使用 Retrofit
  connectionTestRetrofit, // 连接测试使用 Retrofit
  retrofitOnly,         // 完全使用 Retrofit
}
```

### 4. Provider 配置

```dart
// 在 lib/services/quickconnect/providers/quickconnect_api_providers.dart 中
@riverpod
QuickConnectApiInterface quickConnectApi(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final dio = ref.watch(dioProvider);
  final retrofitApi = QuickConnectRetrofitApi(dio);
  
  // 总是创建适配器，让适配器内部决定使用哪种实现
  return QuickConnectApiAdapter(
    apiClient: apiClient,
    retrofitApi: retrofitApi,
  );
}
```

### 5. 使用示例

#### 在 Widget 中使用

```dart
class QuickConnectWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quickConnectService = ref.watch(quickConnectServiceProvider);
    
    return ElevatedButton(
      onPressed: () async {
        try {
          // 解析地址
          final address = await quickConnectService.resolveAddress('demo');
          
          if (address != null) {
            // 测试连接
            final connectionResult = await quickConnectService.testConnection(address);
            
            if (connectionResult.isConnected) {
              // 进行登录
              final loginResult = await quickConnectService.login(
                baseUrl: address,
                username: 'username',
                password: 'password',
              );
              
              if (loginResult.isSuccess) {
                print('登录成功: ${loginResult.sid}');
              }
            }
          }
        } catch (e) {
          print('操作失败: $e');
        }
      },
      child: const Text('连接 QuickConnect'),
    );
  }
}
```

#### 在服务中使用

```dart
class MyService {
  MyService(this._quickConnectApi);
  
  final QuickConnectApiInterface _quickConnectApi;
  
  Future<void> performQuickConnectOperation() async {
    // 使用适配器进行各种操作
    final tunnelResponse = await _quickConnectApi.requestTunnel('id');
    final serverInfo = await _quickConnectApi.requestServerInfo('id');
    
    // 适配器会自动选择最佳实现
    // 无需关心底层是使用 Retrofit 还是旧实现
  }
}
```

## 测试

### 运行测试

```bash
# 运行所有 QuickConnect 相关测试
flutter test test/services/quickconnect/

# 运行特定测试文件
flutter test test/services/quickconnect/api/quickconnect_api_adapter_test.dart
```

### 测试覆盖

- ✅ 适配器基本功能测试
- ✅ 智能降级机制测试
- ✅ Retrofit 和旧实现切换测试
- ✅ 错误处理测试
- ✅ 性能监控测试

## 性能监控

### 启用性能监控

```dart
// 在配置中启用
class FeatureFlags {
  static bool get enableRetrofitPerformanceMonitoring {
    return kDebugMode; // 开发环境启用
  }
}
```

### 查看性能数据

```dart
// 在 UI 中查看性能数据
class PerformanceWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // 显示性能数据
        _showPerformanceData(context);
      },
      child: const Text('查看性能数据'),
    );
  }
}
```

## 故障排除

### 常见问题

1. **Retrofit 请求失败**
   - 检查网络连接
   - 验证 API 端点配置
   - 查看日志中的错误信息

2. **降级机制不工作**
   - 确认 `enableRetrofitFallback` 已启用
   - 检查旧实现是否正常工作
   - 查看日志中的降级信息

3. **性能问题**
   - 启用性能监控查看详细数据
   - 检查是否有重复请求
   - 验证缓存策略

### 调试技巧

1. **启用详细日志**
   ```dart
   // 在开发环境中启用详细日志
   if (kDebugMode) {
     AppLogger.setLogLevel(LogLevel.debug);
   }
   ```

2. **查看 Provider 状态**
   ```dart
   // 在调试模式下查看 Provider 状态
   ref.listen(quickConnectApiProvider, (previous, next) {
     print('API Provider 状态变化: $previous -> $next');
   });
   ```

3. **性能分析**
   ```dart
   // 使用 Flutter DevTools 分析性能
   // 或查看控制台中的性能日志
   ```

## 最佳实践

1. **总是使用适配器**: 不要直接使用具体实现，始终通过 `QuickConnectApiAdapter` 访问
2. **启用降级机制**: 在生产环境中启用降级机制，确保稳定性
3. **监控性能**: 定期查看性能数据，优化实现选择
4. **渐进式迁移**: 使用迁移阶段逐步启用 Retrofit 功能
5. **错误处理**: 妥善处理各种错误情况，提供用户友好的错误信息

## 更新日志

- **v1.0.0**: 初始版本，支持基本的 QuickConnect 功能
- **v1.1.0**: 添加 Retrofit 支持和智能降级机制
- **v1.2.0**: 改进性能监控和错误处理
- **v1.3.0**: 优化适配器逻辑，支持更灵活的配置
