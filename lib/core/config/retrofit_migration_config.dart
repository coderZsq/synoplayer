import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature_flags.dart';

/// 迁移阶段枚举
enum MigrationPhase {
  /// 阶段 0: 完全使用旧实现
  legacyOnly,
  
  /// 阶段 1: 隧道请求使用 Retrofit
  tunnelRetrofit,
  
  /// 阶段 2: 服务器信息请求使用 Retrofit
  serverInfoRetrofit,
  
  /// 阶段 3: 登录请求使用 Retrofit
  loginRetrofit,
  
  /// 阶段 4: 连接测试使用 Retrofit
  connectionTestRetrofit,
  
  /// 阶段 5: 完全使用 Retrofit
  retrofitOnly,
}

/// Retrofit 迁移配置管理
/// 
/// 支持运行时配置和 A/B 测试，确保迁移过程可控
class RetrofitMigrationConfig {
  static const String _tag = 'RetrofitMigrationConfig';
  static const String _useRetrofitKey = 'use_retrofit_api';
  static const String _migrationPhaseKey = 'retrofit_migration_phase';
  
  // ==================== 配置管理 ====================
  
  /// 获取当前迁移阶段
  static Future<MigrationPhase> getCurrentPhase() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final phaseIndex = prefs.getInt(_migrationPhaseKey) ?? 1; // 默认使用 tunnelRetrofit 阶段
      return MigrationPhase.values[phaseIndex];
    } catch (e) {
      debugPrint('获取迁移阶段失败: $e');
      return MigrationPhase.tunnelRetrofit; // 默认使用 tunnelRetrofit 阶段
    }
  }
  
  /// 设置迁移阶段
  static Future<void> setCurrentPhase(MigrationPhase phase) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_migrationPhaseKey, phase.index);
      debugPrint('设置迁移阶段: ${phase.name}');
    } catch (e) {
      debugPrint('设置迁移阶段失败: $e');
    }
  }
  
  /// 获取是否启用 Retrofit
  static Future<bool> isRetrofitEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_useRetrofitKey) ?? false;
    } catch (e) {
      debugPrint('获取 Retrofit 状态失败: $e');
      return false;
    }
  }
  
  /// 设置是否启用 Retrofit
  static Future<void> setRetrofitEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_useRetrofitKey, enabled);
      debugPrint('设置 Retrofit 状态: $enabled');
    } catch (e) {
      debugPrint('设置 Retrofit 状态失败: $e');
    }
  }
  
  // ==================== 功能开关逻辑 ====================
  
  /// 检查特定功能是否应该使用 Retrofit
  static Future<bool> shouldUseRetrofitForFeature(String featureName) async {
    // 首先检查全局开关
    if (!await isRetrofitEnabled()) {
      return false;
    }
    
    // 然后检查迁移阶段
    final currentPhase = await getCurrentPhase();
    
    return switch (featureName) {
      'tunnel' => currentPhase.index >= MigrationPhase.tunnelRetrofit.index,
      'serverInfo' => currentPhase.index >= MigrationPhase.serverInfoRetrofit.index,
      'login' => currentPhase.index >= MigrationPhase.loginRetrofit.index,
      'connectionTest' => currentPhase.index >= MigrationPhase.connectionTestRetrofit.index,
      _ => false,
    };
  }
  
  /// 检查是否应该使用 Retrofit 降级机制
  static Future<bool> shouldEnableFallback() async {
    // 开发环境默认启用降级
    if (kDebugMode) {
      return true;
    }
    
    // 生产环境根据迁移阶段决定
    final currentPhase = await getCurrentPhase();
    return currentPhase.index < MigrationPhase.retrofitOnly.index;
  }
  
  // ==================== A/B 测试支持 ====================
  
  /// 获取 A/B 测试分组
  static Future<String> getABTestGroup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final group = prefs.getString('ab_test_group');
      if (group != null) {
        return group;
      }
      
      // 随机分配测试分组
      final randomGroup = _generateRandomGroup();
      await prefs.setString('ab_test_group', randomGroup);
      return randomGroup;
    } catch (e) {
      debugPrint('获取 A/B 测试分组失败: $e');
      return 'control';
    }
  }
  
  /// 生成随机测试分组
  static String _generateRandomGroup() {
    final random = DateTime.now().millisecondsSinceEpoch % 100;
    if (random < 50) {
      return 'control'; // 50% 使用旧实现
    } else if (random < 75) {
      return 'retrofit_partial'; // 25% 使用部分 Retrofit
    } else {
      return 'retrofit_full'; // 25% 使用完整 Retrofit
    }
  }
  
  /// 根据 A/B 测试分组决定是否启用 Retrofit
  static Future<bool> shouldEnableRetrofitForABTest() async {
    final group = await getABTestGroup();
    
    return switch (group) {
      'control' => false,
      'retrofit_partial' => true,
      'retrofit_full' => true,
      _ => false,
    };
  }
  
  // ==================== 性能监控配置 ====================
  
  /// 是否启用性能监控
  static bool get enablePerformanceMonitoring {
    return FeatureFlags.enableRetrofitPerformanceMonitoring;
  }
  
  /// 性能监控采样率 (0.0 - 1.0)
  static double get performanceMonitoringSampleRate {
    if (kDebugMode) {
      return 1.0; // 开发环境 100% 采样
    } else if (kProfileMode) {
      return 0.5; // 测试环境 50% 采样
    } else {
      return 0.1; // 生产环境 10% 采样
    }
  }
  
  // ==================== 环境配置 ====================
  
  /// 获取环境特定的配置
  static Map<String, dynamic> getEnvironmentConfig() {
    return switch (FeatureFlags.environment) {
      'development' => {
        'enableVerboseLogging': true,
        'enablePerformanceMonitoring': true,
        'enableFallback': true,
        'migrationPhase': MigrationPhase.tunnelRetrofit.index,
      },
      'staging' => {
        'enableVerboseLogging': false,
        'enablePerformanceMonitoring': true,
        'enableFallback': true,
        'migrationPhase': MigrationPhase.serverInfoRetrofit.index,
      },
      'production' => {
        'enableVerboseLogging': false,
        'enablePerformanceMonitoring': false,
        'enableFallback': true,
        'migrationPhase': MigrationPhase.legacyOnly.index,
      },
      _ => {
        'enableVerboseLogging': false,
        'enablePerformanceMonitoring': false,
        'enableFallback': true,
        'migrationPhase': MigrationPhase.legacyOnly.index,
      },
    };
  }
  
  // ==================== 配置验证 ====================
  
  /// 验证当前配置是否有效
  static Future<bool> validateConfiguration() async {
    try {
      final currentPhase = await getCurrentPhase();
      final isEnabled = await isRetrofitEnabled();
      
      // 检查配置一致性
      if (isEnabled && currentPhase == MigrationPhase.legacyOnly) {
        debugPrint('配置不一致: 启用了 Retrofit 但迁移阶段为 legacyOnly');
        return false;
      }
      
      if (!isEnabled && currentPhase != MigrationPhase.legacyOnly) {
        debugPrint('配置不一致: 禁用了 Retrofit 但迁移阶段不是 legacyOnly');
        return false;
      }
      
      return true;
    } catch (e) {
      debugPrint('配置验证失败: $e');
      return false;
    }
  }
  
  /// 重置配置到默认状态
  static Future<void> resetToDefault() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_useRetrofitKey);
      await prefs.remove(_migrationPhaseKey);
      await prefs.remove('ab_test_group');
      debugPrint('配置已重置到默认状态');
    } catch (e) {
      debugPrint('重置配置失败: $e');
    }
  }
}
