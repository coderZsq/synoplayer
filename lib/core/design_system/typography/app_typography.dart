import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

/// 应用字体排版系统
/// 
/// 提供统一的文字样式规范，包括字体大小、行高、字重等
abstract class AppTypography {
  
  // ==================== 字体配置 ====================
  
  /// 主要字体家族
  static const String primaryFontFamily = 'SF Pro Display';
  
  /// 辅助字体家族
  static const String secondaryFontFamily = 'SF Pro Text';
  
  /// 等宽字体家族（用于代码显示）
  static const String monospaceFontFamily = 'SF Mono';
  
  // ==================== 字重定义 ====================
  
  /// 字重常量
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  
  // ==================== 字体大小定义 ====================
  
  /// 字体大小常量
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;
  static const double fontSize36 = 36.0;
  static const double fontSize40 = 40.0;
  static const double fontSize48 = 48.0;
  
  // ==================== 行高定义 ====================
  
  /// 行高比例
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;
  static const double lineHeightLoose = 1.8;
  
  // ==================== 字间距定义 ====================
  
  /// 字间距
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingExtraWide = 1.0;
  
  // ==================== 标题样式 ====================
  
  /// 大标题（H1）
  static TextStyle get h1 => _createTextStyle(
        fontSize: fontSize48,
        fontWeight: bold,
        height: lineHeightTight,
        letterSpacing: letterSpacingTight,
      );
  
  /// 中标题（H2）
  static TextStyle get h2 => _createTextStyle(
        fontSize: fontSize40,
        fontWeight: bold,
        height: lineHeightTight,
        letterSpacing: letterSpacingTight,
      );
  
  /// 小标题（H3）
  static TextStyle get h3 => _createTextStyle(
        fontSize: fontSize32,
        fontWeight: semiBold,
        height: lineHeightTight,
        letterSpacing: letterSpacingNormal,
      );
  
  /// 子标题（H4）
  static TextStyle get h4 => _createTextStyle(
        fontSize: fontSize28,
        fontWeight: semiBold,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  /// 小子标题（H5）
  static TextStyle get h5 => _createTextStyle(
        fontSize: fontSize24,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  /// 最小标题（H6）
  static TextStyle get h6 => _createTextStyle(
        fontSize: fontSize20,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  // ==================== 正文样式 ====================
  
  /// 大正文
  static TextStyle get bodyLarge => _createTextStyle(
        fontSize: fontSize18,
        fontWeight: regular,
        height: lineHeightRelaxed,
        letterSpacing: letterSpacingNormal,
      );
  
  /// 中等正文
  static TextStyle get bodyMedium => _createTextStyle(
        fontSize: fontSize16,
        fontWeight: regular,
        height: lineHeightRelaxed,
        letterSpacing: letterSpacingNormal,
      );
  
  /// 小正文
  static TextStyle get bodySmall => _createTextStyle(
        fontSize: fontSize14,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  // ==================== 标签样式 ====================
  
  /// 大标签
  static TextStyle get labelLarge => _createTextStyle(
        fontSize: fontSize16,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingWide,
      );
  
  /// 中等标签
  static TextStyle get labelMedium => _createTextStyle(
        fontSize: fontSize14,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingWide,
      );
  
  /// 小标签
  static TextStyle get labelSmall => _createTextStyle(
        fontSize: fontSize12,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingWide,
      );
  
  // ==================== 按钮样式 ====================
  
  /// 大按钮文字
  static TextStyle get buttonLarge => _createTextStyle(
        fontSize: fontSize18,
        fontWeight: semiBold,
        height: lineHeightTight,
        letterSpacing: letterSpacingWide,
      );
  
  /// 中等按钮文字
  static TextStyle get buttonMedium => _createTextStyle(
        fontSize: fontSize16,
        fontWeight: semiBold,
        height: lineHeightTight,
        letterSpacing: letterSpacingWide,
      );
  
  /// 小按钮文字
  static TextStyle get buttonSmall => _createTextStyle(
        fontSize: fontSize14,
        fontWeight: medium,
        height: lineHeightTight,
        letterSpacing: letterSpacingWide,
      );
  
  // ==================== 提示样式 ====================
  
  /// 标题提示
  static TextStyle get caption => _createTextStyle(
        fontSize: fontSize12,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  /// 小提示
  static TextStyle get overline => _createTextStyle(
        fontSize: fontSize10,
        fontWeight: medium,
        height: lineHeightTight,
        letterSpacing: letterSpacingExtraWide,
      );
  
  // ==================== 特殊样式 ====================
  
  /// 等宽字体（代码）
  static TextStyle get code => _createTextStyle(
        fontSize: fontSize14,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
        fontFamily: monospaceFontFamily,
      );
  
  /// 链接样式
  static TextStyle get link => _createTextStyle(
        fontSize: fontSize16,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
        decoration: TextDecoration.underline,
      );
  
  // ==================== 主题相关样式 ====================
  
  /// 获取亮色主题样式
  static TextStyle lightTextStyle(TextStyle base) {
    return base.copyWith(color: AppColors.lightTextPrimary);
  }
  
  /// 获取暗色主题样式
  static TextStyle darkTextStyle(TextStyle base) {
    return base.copyWith(color: AppColors.darkTextPrimary);
  }
  
  /// 根据主题获取样式
  static TextStyle adaptiveTextStyle(TextStyle base, Brightness brightness) {
    return brightness == Brightness.light 
        ? lightTextStyle(base)
        : darkTextStyle(base);
  }
  
  // ==================== 私有辅助方法 ====================
  
  /// 创建文本样式的私有方法
  static TextStyle _createTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    required double letterSpacing,
    String? fontFamily,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily ?? primaryFontFamily,
      decoration: decoration,
    );
  }
}

/// 文本样式扩展方法
extension TextStyleExtensions on TextStyle {
  /// 应用颜色
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }
  
  /// 应用字重
  TextStyle withWeight(FontWeight weight) {
    return copyWith(fontWeight: weight);
  }
  
  /// 应用字体大小
  TextStyle withSize(double size) {
    return copyWith(fontSize: size);
  }
  
  /// 应用行高
  TextStyle withHeight(double height) {
    return copyWith(height: height);
  }
  
  /// 应用字间距
  TextStyle withLetterSpacing(double spacing) {
    return copyWith(letterSpacing: spacing);
  }
  
  /// 应用装饰
  TextStyle withDecoration(TextDecoration decoration) {
    return copyWith(decoration: decoration);
  }
  
  /// 应用字体家族
  TextStyle withFontFamily(String fontFamily) {
    return copyWith(fontFamily: fontFamily);
  }
  
  /// 应用主题色彩
  TextStyle withPrimaryColor() {
    return copyWith(color: AppColors.primary);
  }
  
  /// 应用成功色
  TextStyle withSuccessColor() {
    return copyWith(color: AppColors.success);
  }
  
  /// 应用警告色
  TextStyle withWarningColor() {
    return copyWith(color: AppColors.warning);
  }
  
  /// 应用错误色
  TextStyle withErrorColor() {
    return copyWith(color: AppColors.error);
  }
  
  /// 应用次要文本色
  TextStyle withSecondaryColor(Brightness brightness) {
    return copyWith(
      color: brightness == Brightness.light 
          ? AppColors.lightTextSecondary
          : AppColors.darkTextSecondary,
    );
  }
  
  /// 应用禁用状态色
  TextStyle withDisabledColor(Brightness brightness) {
    return copyWith(
      color: brightness == Brightness.light 
          ? AppColors.lightTextDisabled
          : AppColors.darkTextDisabled,
    );
  }
  
  /// 加粗
  TextStyle get bold => copyWith(fontWeight: AppTypography.bold);
  
  /// 半粗
  TextStyle get semiBold => copyWith(fontWeight: AppTypography.semiBold);
  
  /// 中等字重
  TextStyle get medium => copyWith(fontWeight: AppTypography.medium);
  
  /// 常规字重
  TextStyle get regular => copyWith(fontWeight: AppTypography.regular);
  
  /// 细字重
  TextStyle get light => copyWith(fontWeight: AppTypography.light);
  
  /// 斜体
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  
  /// 下划线
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  
  /// 删除线
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
}

/// 响应式文本样式
class ResponsiveTextStyle {
  /// 根据屏幕宽度调整字体大小
  static TextStyle responsive(
    BuildContext context,
    TextStyle baseStyle, {
    double? minFontSize,
    double? maxFontSize,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseFontSize = baseStyle.fontSize ?? 16.0;
    
    // 基于屏幕宽度的缩放因子
    double scaleFactor;
    if (screenWidth < 600) {
      scaleFactor = 0.9; // 小屏设备
    } else if (screenWidth < 900) {
      scaleFactor = 1.0; // 中等屏设备
    } else {
      scaleFactor = 1.1; // 大屏设备
    }
    
    final adjustedFontSize = baseFontSize * scaleFactor;
    final clampedFontSize = adjustedFontSize.clamp(
      minFontSize ?? baseFontSize * 0.8,
      maxFontSize ?? baseFontSize * 1.2,
    );
    
    return baseStyle.copyWith(fontSize: clampedFontSize);
  }
}

/// 文本主题
class AppTextTheme {
  /// 获取完整的文本主题
  static TextTheme getTextTheme(Brightness brightness) {
    final Color textColor = AppColors.textPrimaryFor(brightness);
    final Color secondaryTextColor = AppColors.textSecondaryFor(brightness);
    
    return TextTheme(
      // 显示样式
      displayLarge: AppTypography.h1.withColor(textColor),
      displayMedium: AppTypography.h2.withColor(textColor),
      displaySmall: AppTypography.h3.withColor(textColor),
      
      // 标题样式
      headlineLarge: AppTypography.h4.withColor(textColor),
      headlineMedium: AppTypography.h5.withColor(textColor),
      headlineSmall: AppTypography.h6.withColor(textColor),
      
      // 正文样式
      bodyLarge: AppTypography.bodyLarge.withColor(textColor),
      bodyMedium: AppTypography.bodyMedium.withColor(textColor),
      bodySmall: AppTypography.bodySmall.withColor(secondaryTextColor),
      
      // 标签样式
      labelLarge: AppTypography.labelLarge.withColor(textColor),
      labelMedium: AppTypography.labelMedium.withColor(textColor),
      labelSmall: AppTypography.labelSmall.withColor(secondaryTextColor),
      
      // 标题样式（旧版兼容）
      titleLarge: AppTypography.h6.withColor(textColor),
      titleMedium: AppTypography.labelLarge.withColor(textColor),
      titleSmall: AppTypography.labelMedium.withColor(secondaryTextColor),
    );
  }
}
