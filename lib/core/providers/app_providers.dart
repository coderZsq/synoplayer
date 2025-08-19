import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/credentials/credentials_service.dart';
import '../services/theme/theme_service.dart';
import '../network/providers/network_providers.dart';

// 重新导出主题相关的 providers
export '../services/theme/theme_service.dart';

part 'app_providers.g.dart';

/// 应用全局依赖管理
/// 
/// 集中管理所有全局依赖，包括：
/// - 网络服务
/// - 本地存储服务
/// - 主题服务
/// - 认证服务
@riverpod
class AppDependencies extends _$AppDependencies {
  @override
  Future<void> build() async {
    // 初始化全局依赖
    // 这里可以添加应用启动时的初始化逻辑
  }

  /// 获取凭据服务
  CredentialsService get credentialsService => ref.read(credentialsServiceProvider);
  
  /// 获取主题服务
  ThemeService get themeService => ref.read(themeServiceProvider);
  
  /// 获取网络客户端
  get dioClient => ref.read(dioProvider);
}

/// 凭据服务 Provider
@riverpod
CredentialsService credentialsService(Ref ref) {
  return CredentialsService();
}

/// 主题服务 Provider
@riverpod
ThemeService themeService(Ref ref) {
  return ThemeService();
}

/// 应用状态管理
@riverpod
class AppState extends _$AppState {
  @override
  AppStateData build() {
    return const AppStateData();
  }

  /// 更新应用状态
  void updateState(AppStateData newState) {
    state = newState;
  }

  /// 设置应用初始化状态
  void setInitialized(bool initialized) {
    state = state.copyWith(isInitialized: initialized);
  }

  /// 设置网络状态
  void setNetworkStatus(NetworkStatus status) {
    state = state.copyWith(networkStatus: status);
  }

  /// 设置认证状态
  void setAuthStatus(AuthStatus status) {
    state = state.copyWith(authStatus: status);
  }
}

/// 应用状态数据
class AppStateData {
  const AppStateData({
    this.isInitialized = false,
    this.networkStatus = NetworkStatus.unknown,
    this.authStatus = AuthStatus.unknown,
    this.lastError,
  });

  final bool isInitialized;
  final NetworkStatus networkStatus;
  final AuthStatus authStatus;
  final String? lastError;

  AppStateData copyWith({
    bool? isInitialized,
    NetworkStatus? networkStatus,
    AuthStatus? authStatus,
    String? lastError,
  }) {
    return AppStateData(
      isInitialized: isInitialized ?? this.isInitialized,
      networkStatus: networkStatus ?? this.networkStatus,
      authStatus: authStatus ?? this.authStatus,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppStateData &&
        other.isInitialized == isInitialized &&
        other.networkStatus == networkStatus &&
        other.authStatus == authStatus &&
        other.lastError == lastError;
  }

  @override
  int get hashCode {
    return Object.hash(
      isInitialized,
      networkStatus,
      authStatus,
      lastError,
    );
  }

  @override
  String toString() {
    return 'AppStateData('
        'isInitialized: $isInitialized, '
        'networkStatus: $networkStatus, '
        'authStatus: $authStatus, '
        'lastError: $lastError)';
  }
}

/// 网络状态枚举
enum NetworkStatus {
  unknown,    // 未知状态
  connected,  // 已连接
  disconnected, // 未连接
  connecting, // 连接中
}

/// 认证状态枚举
enum AuthStatus {
  unknown,      // 未知状态
  authenticated, // 已认证
  unauthenticated, // 未认证
  authenticating, // 认证中
}

/// 应用配置 Provider
@riverpod
AppConfig appConfig(Ref ref) {
  return const AppConfig();
}

/// 应用配置类
class AppConfig {
  const AppConfig({
    this.appName = '群晖 QuickConnect',
    this.version = '1.0.0',
    this.buildNumber = 1,
    this.enableDebugMode = false,
    this.apiTimeout = const Duration(seconds: 30),
    this.maxRetryCount = 3,
  });

  final String appName;
  final String version;
  final int buildNumber;
  final bool enableDebugMode;
  final Duration apiTimeout;
  final int maxRetryCount;

  @override
  String toString() {
    return 'AppConfig('
        'appName: $appName, '
        'version: $version, '
        'buildNumber: $buildNumber, '
        'enableDebugMode: $enableDebugMode, '
        'apiTimeout: $apiTimeout, '
        'maxRetryCount: $maxRetryCount)';
  }
}
