import 'package:flutter/foundation.dart';

/// 功能开关配置管理
/// 
/// 用于控制应用中的各种功能开关，包括 Retrofit 迁移开关
class FeatureFlags {
  static const String _tag = 'FeatureFlags';
  
  // ==================== 网络层功能开关 ====================
  
  /// 是否启用 Retrofit API
  /// 
  /// 默认关闭，确保安全
  /// 可以通过配置文件、环境变量或远程配置动态控制
  static bool get useRetrofitApi {
    // 开发环境可以通过环境变量控制
    if (kDebugMode) {
      const useRetrofit = bool.fromEnvironment('USE_RETROFIT_API', defaultValue: true);
      return useRetrofit;
    }
    
    // 生产环境默认关闭
    return false;
  }
  
  /// 是否启用 Retrofit 降级机制
  /// 
  /// 当 Retrofit 失败时，是否自动降级到旧实现
  static bool get enableRetrofitFallback {
    // 开发环境默认启用降级
    if (kDebugMode) {
      return true;
    }
    
    // 生产环境默认启用降级，确保稳定性
    return true;
  }
  
  /// 是否启用 Retrofit 性能监控
  /// 
  /// 监控 Retrofit 和旧实现的性能对比
  static bool get enableRetrofitPerformanceMonitoring {
    // 开发环境启用监控
    if (kDebugMode) {
      return true;
    }
    
    // 生产环境默认关闭，避免性能开销
    return false;
  }
  
  // ==================== 其他功能开关 ====================
  
  /// 是否启用详细日志
  static bool get enableVerboseLogging {
    return kDebugMode;
  }
  
  /// 是否启用网络请求缓存
  static bool get enableNetworkCache {
    return true; // 生产环境也启用缓存
  }
  
  /// 是否启用错误上报
  static bool get enableErrorReporting {
    return !kDebugMode; // 生产环境启用错误上报
  }
  
  // ==================== 环境相关配置 ====================
  
  /// 当前环境名称
  static String get environment {
    if (kDebugMode) {
      return 'development';
    } else if (kProfileMode) {
      return 'staging';
    } else {
      return 'production';
    }
  }
  
  /// 是否处于开发模式
  static bool get isDevelopment => kDebugMode;
  
  /// 是否处于生产模式
  static bool get isProduction => !kDebugMode && !kProfileMode;
  
  /// 是否处于测试模式
  static bool get isTest => kProfileMode;
}
