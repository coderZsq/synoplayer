// 核心模块导出
// 
// 集中导出所有核心功能，包括：
// - 路由管理 (GoRouter配置)
// - 网络层 (Dio配置、拦截器、异常处理)
// - 错误处理 (全局错误处理、错误边界)
// - 状态管理 (全局状态、认证状态)
// - 工具库 (日志、扩展方法等)
// - 服务层 (主题、凭据等业务无关服务)

export 'router/app_router.dart';
export 'error/error_handler.dart';
export 'network/index.dart';
export 'providers/app_providers.dart';
export 'providers/auth_providers.dart';
export 'services/theme/app_theme.dart';
export 'services/theme/app_theme_v2.dart';
export 'utils/logger.dart';
