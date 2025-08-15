import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 主题管理服务
class ThemeService {
  static const _storage = FlutterSecureStorage();
  static const _themeKey = 'theme_mode';
  
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;
  
  /// 初始化主题设置
  Future<ThemeMode> initialize() async {
    final savedTheme = await _storage.read(key: _themeKey);
    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        case 'system':
        default:
          return ThemeMode.system;
      }
    }
    return ThemeMode.system;
  }
  
  /// 切换到亮色模式
  static Future<void> setLightMode() async {
    await _storage.write(key: _themeKey, value: 'light');
  }
  
  /// 切换到暗黑模式
  static Future<void> setDarkMode() async {
    await _storage.write(key: _themeKey, value: 'dark');
  }
  
  /// 跟随系统主题
  static Future<void> setSystemMode() async {
    await _storage.write(key: _themeKey, value: 'system');
  }
  
  /// 获取主题模式的描述
  static String getThemeModeDescription(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return '亮色模式';
      case ThemeMode.dark:
        return '暗黑模式';
      case ThemeMode.system:
        return '跟随系统';
    }
  }
  
  /// 获取主题模式的图标
  static IconData getThemeModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.auto_mode;
    }
  }
  
  /// 切换到下一个主题模式
  static ThemeMode getNextThemeMode(ThemeMode current) {
    switch (current) {
      case ThemeMode.light:
        return ThemeMode.dark;
      case ThemeMode.dark:
        return ThemeMode.system;
      case ThemeMode.system:
        return ThemeMode.light;
    }
  }
  
  /// 判断当前是否为暗黑模式
  static bool isDarkMode(ThemeMode mode, BuildContext context) {
    if (mode == ThemeMode.dark) return true;
    if (mode == ThemeMode.light) return false;
    // 跟随系统时检查系统主题
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}

/// 主题模式状态提供器
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

/// 主题状态管理器
class ThemeNotifier extends StateNotifier<ThemeMode> {
  final ThemeService _themeService = ThemeService();
  
  ThemeNotifier() : super(ThemeMode.system) {
    _initialize();
  }
  
  /// 初始化主题
  Future<void> _initialize() async {
    state = await _themeService.initialize();
  }
  
  /// 切换到亮色模式
  Future<void> setLightMode() async {
    await ThemeService.setLightMode();
    state = ThemeMode.light;
  }
  
  /// 切换到暗黑模式
  Future<void> setDarkMode() async {
    await ThemeService.setDarkMode();
    state = ThemeMode.dark;
  }
  
  /// 跟随系统主题
  Future<void> setSystemMode() async {
    await ThemeService.setSystemMode();
    state = ThemeMode.system;
  }
  
  /// 切换主题模式（循环切换）
  Future<void> toggleTheme() async {
    final nextMode = ThemeService.getNextThemeMode(state);
    switch (nextMode) {
      case ThemeMode.light:
        await setLightMode();
        break;
      case ThemeMode.dark:
        await setDarkMode();
        break;
      case ThemeMode.system:
        await setSystemMode();
        break;
    }
  }
  
  /// 获取当前主题描述
  String get description => ThemeService.getThemeModeDescription(state);
  
  /// 获取当前主题图标
  IconData get icon => ThemeService.getThemeModeIcon(state);
  
  /// 判断是否为暗黑模式
  bool isDarkMode(BuildContext context) => ThemeService.isDarkMode(state, context);
}

/// 主题配置
class AppThemes {
  /// 亮色主题
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        brightness: Brightness.light,
        primary: Colors.black87,
        secondary: Colors.grey[600]!,
        surface: Colors.white,
        background: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.2),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Colors.black87),
        headlineMedium: TextStyle(color: Colors.black87),
        headlineSmall: TextStyle(color: Colors.black87),
        titleLarge: TextStyle(color: Colors.black87),
        titleMedium: TextStyle(color: Colors.black87),
        titleSmall: TextStyle(color: Colors.black87),
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black54),
        bodySmall: TextStyle(color: Colors.black54),
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
      useMaterial3: true,
    );
  }
  
  /// 暗黑主题
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey[900],
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.grey[800]!,
        brightness: Brightness.dark,
        primary: Colors.white,
        secondary: Colors.grey[400]!,
        surface: Colors.grey[850]!,
        background: Colors.grey[900]!,
      ),
      cardTheme: CardThemeData(
        color: Colors.grey[850],
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white70),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      useMaterial3: true,
    );
  }
}
