import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/logger.dart';

part 'theme_service.g.dart';

/// 主题模式枚举
enum AppThemeMode {
  light('light', '亮色模式', Icons.light_mode),
  dark('dark', '暗黑模式', Icons.dark_mode),
  system('system', '跟随系统', Icons.auto_mode);

  const AppThemeMode(this.value, this.description, this.icon);

  final String value;
  final String description;
  final IconData icon;

  /// 转换为 Flutter ThemeMode
  ThemeMode get themeMode => switch (this) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      };

  /// 从字符串创建
  static AppThemeMode fromString(String value) => switch (value) {
        'light' => AppThemeMode.light,
        'dark' => AppThemeMode.dark,
        _ => AppThemeMode.system,
      };

  /// 获取下一个主题模式（用于循环切换）
  AppThemeMode get next => switch (this) {
        AppThemeMode.light => AppThemeMode.dark,
        AppThemeMode.dark => AppThemeMode.system,
        AppThemeMode.system => AppThemeMode.light,
      };

  /// 判断是否为暗黑模式
  bool isDark(BuildContext context) {
    return switch (this) {
      AppThemeMode.dark => true,
      AppThemeMode.light => false,
      AppThemeMode.system => 
        MediaQuery.of(context).platformBrightness == Brightness.dark,
    };
  }
}

/// 主题服务 - 处理主题持久化
class ThemeService {
  static const _storage = FlutterSecureStorage();
  static const _themeKey = 'app_theme_mode';

  /// 保存主题模式
  Future<void> saveThemeMode(AppThemeMode mode) async {
    try {
      await _storage.write(key: _themeKey, value: mode.value);
      AppLogger.info('主题模式已保存: ${mode.description}');
    } catch (e) {
      AppLogger.error('保存主题模式失败: $e');
      rethrow;
    }
  }

  /// 读取保存的主题模式
  Future<AppThemeMode> loadThemeMode() async {
    try {
      final savedTheme = await _storage.read(key: _themeKey);
      if (savedTheme != null) {
        return AppThemeMode.fromString(savedTheme);
      }
      return AppThemeMode.system;
    } catch (e) {
      AppLogger.error('读取主题模式失败: $e');
      return AppThemeMode.system;
    }
  }

  /// 清除主题设置
  Future<void> clearThemeMode() async {
    try {
      await _storage.delete(key: _themeKey);
      AppLogger.info('主题设置已清除');
    } catch (e) {
      AppLogger.error('清除主题设置失败: $e');
    }
  }
}

/// 主题服务 Provider
@riverpod
ThemeService themeService(Ref ref) {
  return ThemeService();
}

/// 当前主题模式 Provider
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<AppThemeMode> build() async {
    final service = ref.read(themeServiceProvider);
    return await service.loadThemeMode();
  }

  /// 设置主题模式
  Future<void> setThemeMode(AppThemeMode mode) async {
    state = const AsyncValue.loading();
    
    try {
      final service = ref.read(themeServiceProvider);
      await service.saveThemeMode(mode);
      state = AsyncValue.data(mode);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 切换到亮色模式
  Future<void> setLightMode() => setThemeMode(AppThemeMode.light);

  /// 切换到暗黑模式
  Future<void> setDarkMode() => setThemeMode(AppThemeMode.dark);

  /// 跟随系统主题
  Future<void> setSystemMode() => setThemeMode(AppThemeMode.system);

  /// 循环切换主题模式
  Future<void> toggleTheme() async {
    final currentMode = state.valueOrNull ?? AppThemeMode.system;
    await setThemeMode(currentMode.next);
  }
}

/// Flutter ThemeMode Provider（用于 MaterialApp）
@riverpod
ThemeMode currentThemeMode(Ref ref) {
  final themeAsync = ref.watch(themeNotifierProvider);
  return themeAsync.valueOrNull?.themeMode ?? ThemeMode.system;
}

/// 当前是否为暗黑模式 Provider
@riverpod
bool isDarkMode(Ref ref, BuildContext context) {
  final themeAsync = ref.watch(themeNotifierProvider);
  final currentMode = themeAsync.valueOrNull ?? AppThemeMode.system;
  return currentMode.isDark(context);
}
