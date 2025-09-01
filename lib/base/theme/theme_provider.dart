import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart';

class ThemeNotifier extends StateNotifier<Brightness> {
  ThemeNotifier() : super(Brightness.light) {
    // 延迟初始化，确保平台调度器已经准备好
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSystemTheme();
    });
  }

  void _loadSystemTheme() {
    try {
      final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
      final currentBrightness = platformDispatcher.platformBrightness;
      
      // 设置初始状态
      if (state != currentBrightness) {
        state = currentBrightness;
      }
      
      // 监听系统主题变化
      platformDispatcher.onPlatformBrightnessChanged = () {
        final newBrightness = platformDispatcher.platformBrightness;
        if (state != newBrightness) {
          state = newBrightness;
        }
      };
    } catch (e) {
      // 如果获取失败，默认使用亮色主题
      state = Brightness.light;
    }
  }

  bool get isDarkMode => state == Brightness.dark;

  CupertinoThemeData get currentTheme {
    return isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, Brightness>((ref) {
  return ThemeNotifier();
});

final currentThemeProvider = Provider<CupertinoThemeData>((ref) {
  final themeNotifier = ref.watch(themeProvider.notifier);
  return themeNotifier.currentTheme;
});
