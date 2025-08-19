# Clean Architecture 分层说明

## 架构概述

本项目采用 Clean Architecture 架构模式，将代码分为四个主要层次：

```
lib/
├── core/                    # 核心基础设施层
├── features/               # 功能模块层
├── shared/                 # 共享组件层
└── main.dart              # 应用入口
```

## 分层结构

### 1. Core Layer (核心层)
**位置**: `lib/core/`
**职责**: 提供应用的基础设施和工具

```
core/
├── config/                 # 配置管理
├── constants/              # 常量定义
├── design_system/          # 设计系统
├── error/                  # 错误处理
├── network/                # 网络层
├── providers/              # 全局 Provider
├── router/                 # 路由管理
├── services/               # 核心服务
├── utils/                  # 工具类
└── architecture/           # 架构相关文档
```

### 2. Features Layer (功能层)
**位置**: `lib/features/`
**职责**: 实现具体的业务功能

每个功能模块都遵循 Clean Architecture 的内部结构：

```
features/
└── feature_name/
    ├── data/               # 数据层
    │   ├── datasources/    # 数据源
    │   ├── models/         # 数据模型
    │   └── repositories/   # 仓库实现
    ├── domain/             # 领域层
    │   ├── entities/       # 业务实体
    │   ├── repositories/   # 仓库接口
    │   └── usecases/      # 用例
    └── presentation/       # 表现层
        ├── pages/          # 页面
        ├── providers/      # 状态管理
        └── widgets/        # 组件
```

### 3. Shared Layer (共享层)
**位置**: `lib/shared/`
**职责**: 提供跨功能模块的共享组件

```
shared/
├── widgets/                # 共享组件
├── models/                 # 共享模型
├── utils/                  # 共享工具
└── constants/              # 共享常量
```

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

## 迁移指南

### 阶段 1: 创建新结构
1. 创建新的目录结构
2. 移动现有代码到对应层次
3. 更新导入路径

### 阶段 2: 重构现有代码
1. 分离业务逻辑和 UI 逻辑
2. 创建 Repository 接口和实现
3. 实现 UseCase 模式

### 阶段 3: 优化和测试
1. 添加单元测试
2. 优化依赖注入
3. 完善错误处理

## 最佳实践

1. **依赖注入**: 使用 Riverpod 进行依赖管理
2. **错误处理**: 统一的错误处理机制
3. **测试**: 每层都有对应的测试
4. **文档**: 保持文档与代码同步
5. **命名**: 遵循一致的命名约定
