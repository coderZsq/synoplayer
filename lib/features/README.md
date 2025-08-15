# 功能模块架构说明

本项目采用功能驱动的组件化架构，按照业务功能进行模块划分。

## 🏗️ 架构设计原则

### 1. 功能模块化 (Feature-Driven)
- 每个功能模块独立封装，包含完整的业务逻辑
- 模块间通过明确的接口进行通信
- 支持独立开发、测试和维护

### 2. 组件化设计 (Component-Based)
- UI 组件职责单一，高度可复用
- 业务逻辑与 UI 展示分离
- 支持热插拔和独立测试

### 3. 语义化命名 (Semantic Naming)
- 文件和类名清晰表达其功能和用途
- 遵循 Flutter/Dart 命名约定
- 便于团队协作和代码维护

## 📁 文件结构

```
lib/
├── features/                          # 功能模块
│   ├── authentication/               # 认证功能模块
│   │   ├── pages/                    # 页面
│   │   │   └── login_page.dart       # 登录页面
│   │   └── widgets/                  # 组件
│   │       ├── login_form_widget.dart          # 登录表单组件
│   │       ├── quickconnect_resolver_widget.dart  # 地址解析组件
│   │       └── otp_verification_widget.dart    # OTP验证组件
│   └── dashboard/                    # 仪表板功能模块
│       ├── pages/                    # 页面
│       │   └── main_page.dart        # 主页面
│       └── widgets/                  # 组件
│           ├── welcome_card_widget.dart        # 欢迎卡片组件
│           ├── connection_info_widget.dart     # 连接信息组件
│           ├── feature_buttons_widget.dart     # 功能按钮组件
│           ├── theme_settings_widget.dart      # 主题设置组件
│           └── logout_section_widget.dart      # 退出登录组件
├── shared/                           # 共享组件
│   └── widgets/                      # 通用UI组件
│       ├── log_display_widget.dart   # 日志显示组件
│       └── smart_login_widget.dart   # 智能登录组件
├── services/                         # 服务层
├── core/                            # 核心功能
└── main.dart                        # 应用入口
```

## 🎯 功能模块详解

### Authentication 模块 (认证)

**职责**: 处理用户登录、身份验证相关功能

**组件说明**:
- `LoginPage`: 登录页面容器，负责状态管理和组件协调
- `QuickConnectResolverWidget`: QuickConnect地址解析和连接测试
- `LoginFormWidget`: 用户名密码登录表单
- `OtpVerificationWidget`: 二次验证（OTP）处理
- `SmartLoginWidget`: 智能登录功能（在shared中，可跨模块使用）

**特点**:
- 组件间通过回调函数通信
- 状态提升到页面级别管理
- 支持多种登录方式

### Dashboard 模块 (仪表板)

**职责**: 登录后的主界面和功能导航

**组件说明**:
- `MainPage`: 主页面容器，整合各个功能区域
- `WelcomeCardWidget`: 欢迎信息展示
- `ConnectionInfoWidget`: 连接详情展示
- `FeatureButtonsWidget`: 功能快捷入口
- `ThemeSettingsWidget`: 主题切换设置
- `LogoutSectionWidget`: 安全退出功能

**特点**:
- 卡片式布局设计
- 响应式UI适配
- 模块化功能入口

### Shared 模块 (共享)

**职责**: 跨模块使用的通用组件

**组件说明**:
- `LogDisplayWidget`: 通用日志显示组件
- `SmartLoginWidget`: 智能登录组件

**特点**:
- 高度可复用
- 无业务逻辑耦合
- 支持自定义配置

## 🔄 数据流设计

### 1. 状态管理
- 使用 Riverpod 进行全局状态管理
- 页面级状态使用 StatefulWidget
- 组件间通过 Props 和 Callbacks 通信

### 2. 事件流
```
User Action → Widget Event → Page Handler → Service Call → State Update → UI Re-render
```

### 3. 错误处理
- 组件级错误通过回调上报
- 全局错误通过 Provider 处理
- 用户友好的错误提示

## 🎨 设计模式

### 1. 组合模式 (Composition Pattern)
```dart
// 页面由多个功能组件组合而成
class LoginPage extends StatefulWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuickConnectResolverWidget(...),
        LoginFormWidget(...),
        LogDisplayWidget(...),
      ],
    );
  }
}
```

### 2. 回调模式 (Callback Pattern)
```dart
// 子组件通过回调向父组件通信
class LoginFormWidget extends StatelessWidget {
  final Function(String sid) onLoginSuccess;
  final Function(String message) onLog;
  
  // 在登录成功时调用回调
  void _handleLogin() async {
    // ... 登录逻辑
    onLoginSuccess(sid);
    onLog('登录成功');
  }
}
```

### 3. 策略模式 (Strategy Pattern)
```dart
// 智能登录支持多种登录策略
class SmartLoginWidget {
  Future<void> _performSmartLogin() {
    // 自动选择最优登录策略
    // 1. 直连地址登录
    // 2. 中继服务器登录
    // 3. 带OTP的登录
  }
}
```

## 📝 组件开发规范

### 1. 组件命名
- Widget 类名使用 `PascalCase` + `Widget` 后缀
- 文件名使用 `snake_case` + `_widget.dart` 后缀
- 组件功能要语义化明确

### 2. 组件结构
```dart
class ExampleWidget extends StatelessWidget {
  // 1. 构造函数和必需参数
  const ExampleWidget({
    super.key,
    required this.requiredParam,
    this.optionalParam,
  });

  // 2. 参数声明
  final String requiredParam;
  final String? optionalParam;

  // 3. 私有方法（按调用顺序）
  Widget _buildHeader() { ... }
  Widget _buildContent() { ... }
  Widget _buildFooter() { ... }

  // 4. build 方法
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildContent(),
        _buildFooter(),
      ],
    );
  }
}
```

### 3. 状态管理
- 优先使用 StatelessWidget
- 状态提升到最近的共同父组件
- 复杂状态使用 Riverpod Provider

### 4. 样式处理
- 使用 Theme 获取主题色彩
- 支持明暗主题切换
- 响应式布局设计

## 🚀 扩展指南

### 添加新功能模块
1. 在 `features/` 下创建新目录
2. 按照 `pages/` 和 `widgets/` 结构组织
3. 实现页面容器和功能组件
4. 更新路由配置

### 添加新组件
1. 确定组件属于哪个模块
2. 如果是通用组件，放在 `shared/widgets/`
3. 遵循组件开发规范
4. 编写组件文档和使用示例

### 重构现有组件
1. 保持接口兼容性
2. 逐步迁移调用方
3. 更新相关文档
4. 进行回归测试

## 🔧 开发工具

### 推荐 IDE 配置
- VS Code + Flutter 插件
- 启用 Format on Save
- 配置 Import Sorter

### 代码质量
- 遵循 Flutter/Dart 官方规范
- 使用 analysis_options.yaml 配置
- 定期运行 flutter analyze

### 测试策略
- 组件级单元测试
- 页面级集成测试
- 用户场景端到端测试

---

这种架构设计使代码更加模块化、可维护，同时保持了良好的可扩展性。每个组件都有明确的职责边界，便于团队协作开发。
