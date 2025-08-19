# Clean Architecture 迁移指南

## 概述

本项目已成功重构为 Clean Architecture 架构模式，实现了关注点分离、依赖倒置和可测试性等核心原则。

## 新的目录结构

```
lib/
├── core/                           # 核心基础设施层
│   ├── architecture/               # 架构相关文档
│   │   └── clean_architecture_layers.md
│   ├── config/                     # 配置管理
│   ├── constants/                  # 常量定义
│   ├── design_system/              # 设计系统
│   ├── error/                      # 错误处理
│   │   ├── failures.dart          # 失败类型定义
│   │   └── exceptions.dart        # 异常类型定义
│   ├── network/                    # 网络层
│   │   ├── network_info.dart      # 网络信息接口
│   │   └── network_providers.dart # 网络 Provider
│   ├── providers/                  # 全局 Provider
│   ├── router/                     # 路由管理
│   ├── services/                   # 核心服务
│   └── utils/                      # 工具类
├── features/                       # 功能模块层
│   └── quickconnect/              # QuickConnect 功能
│       ├── data/                   # 数据层
│       │   ├── datasources/       # 数据源
│       │   │   ├── quickconnect_remote_datasource.dart
│       │   │   └── quickconnect_local_datasource.dart
│       │   ├── models/            # 数据模型
│       │   │   └── quickconnect_model.dart
│       │   └── repositories/      # 仓库实现
│       │       └── quickconnect_repository_impl.dart
│       ├── domain/                 # 领域层
│       │   ├── entities/          # 业务实体
│       │   │   └── quickconnect_entity.dart
│       │   ├── repositories/      # 仓库接口
│       │   │   └── quickconnect_repository.dart
│       │   └── usecases/          # 用例
│       │       ├── resolve_address_usecase.dart
│       │       └── login_usecase.dart
│       ├── presentation/           # 表现层
│       │   └── providers/         # 状态管理
│       │       └── quickconnect_providers.dart
│       └── index.dart             # 模块导出
├── shared/                         # 共享组件层
│   ├── widgets/                    # 共享组件
│   ├── models/                     # 共享模型
│   └── utils/                      # 共享工具
└── main.dart                      # 应用入口
```

## 架构分层说明

### 1. Core Layer (核心层)
- **职责**: 提供应用的基础设施和工具
- **包含**: 网络、错误处理、配置、路由等
- **特点**: 不依赖任何其他层，被所有层依赖

### 2. Features Layer (功能层)
- **职责**: 实现具体的业务功能
- **结构**: 每个功能模块都遵循 Clean Architecture 的内部结构
- **分层**: 
  - **Domain**: 业务逻辑和规则
  - **Data**: 数据访问和存储
  - **Presentation**: 用户界面和状态管理

### 3. Shared Layer (共享层)
- **职责**: 提供跨功能模块的共享组件
- **包含**: 通用组件、工具、常量等

## 依赖方向

```
Presentation → Domain ← Data
     ↓           ↑        ↓
     └─── Core ←──────────┘
```

- **Domain 层**: 不依赖任何其他层
- **Data 层**: 依赖 Domain 层
- **Presentation 层**: 依赖 Domain 层
- **Core 层**: 被所有层依赖，但不依赖任何层

## 迁移完成的功能

### ✅ QuickConnect 功能模块
- **Domain 层**: 实体、仓库接口、用例
- **Data 层**: 数据模型、数据源接口、仓库实现
- **Presentation 层**: Provider 状态管理

### ✅ 核心基础设施
- **错误处理**: 统一的失败和异常类型
- **网络层**: 网络信息接口和 Provider
- **架构文档**: 详细的架构说明和迁移指南

## 下一步工作

### 1. 实现数据源
需要实现以下数据源：
- `QuickConnectRemoteDataSource` 的具体实现
- `QuickConnectLocalDataSource` 的具体实现

### 2. 集成现有代码
将现有的 QuickConnect 服务代码迁移到新的架构中：
- 移动现有的 API 实现到数据源
- 移动现有的服务逻辑到用例
- 更新 Provider 以使用新的架构

### 3. 添加测试
为每个层添加对应的测试：
- 单元测试：用例、仓库、数据源
- Widget 测试：表现层组件
- 集成测试：端到端流程

### 4. 完善错误处理
- 实现全局错误处理机制
- 添加用户友好的错误提示
- 实现错误上报和分析

## 使用示例

### 在 Widget 中使用新的架构

```dart
class QuickConnectWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressResolution = ref.watch(addressResolutionNotifierProvider);
    final loginState = ref.watch(loginNotifierProvider);
    
    return Column(
      children: [
        // 地址解析
        ElevatedButton(
          onPressed: () {
            ref.read(addressResolutionNotifierProvider.notifier)
               .resolveAddress('demo');
          },
          child: const Text('解析地址'),
        ),
        
        // 显示解析结果
        addressResolution.when(
          data: (serverInfo) => Text('服务器: ${serverInfo?.externalDomain}'),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('错误: $error'),
        ),
        
        // 登录
        ElevatedButton(
          onPressed: () {
            ref.read(loginNotifierProvider.notifier).login(
              serverUrl: 'https://demo.synology.me',
              username: 'admin',
              password: 'password',
            );
          },
          child: const Text('登录'),
        ),
        
        // 显示登录结果
        loginState.when(
          data: (result) => Text(
            result?.isSuccess == true ? '登录成功' : '登录失败',
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('错误: $error'),
        ),
      ],
    );
  }
}
```

## 最佳实践

### 1. 依赖注入
- 使用 Riverpod 进行依赖管理
- 避免在 Widget 中直接创建对象
- 通过 Provider 获取依赖

### 2. 错误处理
- 使用 Either 类型处理成功/失败
- 在用例层进行输入验证
- 在仓库层处理数据源错误

### 3. 状态管理
- 使用 AsyncNotifier 管理异步状态
- 在 Provider 中处理业务逻辑
- 避免在 Widget 中直接调用仓库

### 4. 测试
- 每层都有对应的测试
- 使用 Mock 对象进行单元测试
- 测试覆盖所有业务场景

## 总结

通过这次重构，项目获得了以下好处：

1. **清晰的架构**: 每层职责明确，依赖关系清晰
2. **可测试性**: 每层都可以独立测试
3. **可维护性**: 代码结构清晰，易于理解和修改
4. **可扩展性**: 新功能可以按照相同的架构模式添加
5. **团队协作**: 统一的架构模式便于团队协作

接下来需要继续完善数据源实现，并逐步迁移现有的业务逻辑到新的架构中。
