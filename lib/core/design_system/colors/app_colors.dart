import 'package:flutter/material.dart';

/// 应用颜色系统
/// 
/// 提供统一的颜色规范，支持亮色和暗色主题
abstract class AppColors {
  
  // ==================== 品牌色彩 ====================
  
  /// 主品牌色
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryVariant = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF0D47A1);
  
  /// 次要品牌色
  static const Color secondary = Color(0xFF757575);
  static const Color secondaryVariant = Color(0xFF424242);
  static const Color secondaryLight = Color(0xFF90CAF9);
  static const Color secondaryDark = Color(0xFF1565C0);
  
  /// 强调色
  static const Color accent = Color(0xFF03DAC6);
  static const Color accentVariant = Color(0xFF018786);
  
  // ==================== 功能色彩 ====================
  
  /// 成功色
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);
  
  /// 警告色
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);
  
  /// 错误色
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFC62828);
  
  /// 信息色
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);
  
  // ==================== 中性色彩 ====================
  
  /// 灰度色阶
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
  
  /// 黑白色
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // ==================== 透明度色彩 ====================
  
  /// 透明度变体
  static Color primaryWithOpacity(double opacity) => 
      primary.withValues(alpha: opacity);
  static Color secondaryWithOpacity(double opacity) => 
      secondary.withValues(alpha: opacity);
  static Color successWithOpacity(double opacity) => 
      success.withValues(alpha: opacity);
  static Color warningWithOpacity(double opacity) => 
      warning.withValues(alpha: opacity);
  static Color errorWithOpacity(double opacity) => 
      error.withValues(alpha: opacity);
  static Color blackWithOpacity(double opacity) => 
      black.withValues(alpha: opacity);
  static Color whiteWithOpacity(double opacity) => 
      white.withValues(alpha: opacity);
  
  // ==================== 亮色主题色彩 ====================
  
  /// 亮色主题背景色
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  
  /// 亮色主题文本色
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextDisabled = Color(0xFFBDBDBD);
  static const Color lightTextHint = Color(0xFF9E9E9E);
  
  /// 亮色主题边框色
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightDivider = Color(0xFFEEEEEE);
  
  // ==================== 暗色主题色彩 ====================
  
  /// 暗色主题背景色
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);
  
  /// 暗色主题文本色
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextDisabled = Color(0xFF757575);
  static const Color darkTextHint = Color(0xFF9E9E9E);
  
  /// 暗色主题边框色
  static const Color darkBorder = Color(0xFF424242);
  static const Color darkDivider = Color(0xFF333333);
  
  // ==================== 颜色工具方法 ====================
  
  /// 根据主题获取背景色
  static Color backgroundFor(Brightness brightness) {
    return brightness == Brightness.light 
        ? lightBackground 
        : darkBackground;
  }
  
  /// 根据主题获取表面色
  static Color surfaceFor(Brightness brightness) {
    return brightness == Brightness.light 
        ? lightSurface 
        : darkSurface;
  }
  
  /// 根据主题获取卡片色
  static Color cardFor(Brightness brightness) {
    return brightness == Brightness.light 
        ? lightCard 
        : darkCard;
  }
  
  /// 根据主题获取主要文本色
  static Color textPrimaryFor(Brightness brightness) {
    return brightness == Brightness.light 
        ? lightTextPrimary 
        : darkTextPrimary;
  }
  
  /// 根据主题获取次要文本色
  static Color textSecondaryFor(Brightness brightness) {
    return brightness == Brightness.light 
        ? lightTextSecondary 
        : darkTextSecondary;
  }
  
  /// 根据主题获取边框色
  static Color borderFor(Brightness brightness) {
    return brightness == Brightness.light 
        ? lightBorder 
        : darkBorder;
  }
  
  /// 根据主题获取分割线色
  static Color dividerFor(Brightness brightness) {
    return brightness == Brightness.light 
        ? lightDivider 
        : darkDivider;
  }
  
  /// 判断颜色是否为亮色
  static bool isLight(Color color) {
    return color.computeLuminance() > 0.5;
  }
  
  /// 获取颜色的对比色（黑或白）
  static Color contrastColor(Color color) {
    return isLight(color) ? black : white;
  }
  
  /// 混合两个颜色
  static Color mix(Color color1, Color color2, double ratio) {
    return Color.lerp(color1, color2, ratio) ?? color1;
  }
  
  /// 调整颜色亮度
  static Color adjustBrightness(Color color, double factor) {
    final hsl = HSLColor.fromColor(color);
    final adjustedLightness = (hsl.lightness * factor).clamp(0.0, 1.0);
    return hsl.withLightness(adjustedLightness).toColor();
  }
  
  /// 调整颜色饱和度
  static Color adjustSaturation(Color color, double factor) {
    final hsl = HSLColor.fromColor(color);
    final adjustedSaturation = (hsl.saturation * factor).clamp(0.0, 1.0);
    return hsl.withSaturation(adjustedSaturation).toColor();
  }
}

/// 颜色扩展方法
extension ColorExtensions on Color {
  /// 转换为十六进制字符串
  String toHex() {
    return '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
  
  /// 调整透明度
  Color withOpacity(double opacity) {
    return withValues(alpha: opacity);
  }
  
  /// 变亮
  Color lighten(double factor) {
    return AppColors.adjustBrightness(this, 1 + factor);
  }
  
  /// 变暗
  Color darken(double factor) {
    return AppColors.adjustBrightness(this, 1 - factor);
  }
  
  /// 调整饱和度
  Color saturate(double factor) {
    return AppColors.adjustSaturation(this, 1 + factor);
  }
  
  /// 降低饱和度
  Color desaturate(double factor) {
    return AppColors.adjustSaturation(this, 1 - factor);
  }
  
  /// 是否为亮色
  bool get isLight => AppColors.isLight(this);
  
  /// 获取对比色
  Color get contrastColor => AppColors.contrastColor(this);
}
