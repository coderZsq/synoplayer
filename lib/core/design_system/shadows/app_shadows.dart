import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

/// 应用阴影系统
/// 
/// 提供统一的阴影规范，营造层次感和深度
abstract class AppShadows {
  
  // ==================== 基础阴影参数 ====================
  
  /// 阴影颜色（亮色主题）
  static const Color lightShadowColor = Color(0x1A000000); // 黑色 10% 透明度
  
  /// 阴影颜色（暗色主题）
  static const Color darkShadowColor = Color(0x40000000); // 黑色 25% 透明度
  
  /// 基础模糊半径
  static const double baseBlurRadius = 4.0;
  
  /// 基础偏移距离
  static const double baseOffset = 2.0;
  
  // ==================== 阴影级别 ====================
  
  /// 无阴影
  static const List<BoxShadow> none = [];
  
  /// 超小阴影（elevation 1）
  static List<BoxShadow> get xs => [
    BoxShadow(
      color: lightShadowColor,
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];
  
  /// 小阴影（elevation 2）
  static List<BoxShadow> get sm => [
    BoxShadow(
      color: lightShadowColor,
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  /// 中等阴影（elevation 4）
  static List<BoxShadow> get md => [
    BoxShadow(
      color: lightShadowColor,
      offset: const Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: lightShadowColor.withValues(alpha: 0.06),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];
  
  /// 大阴影（elevation 6）
  static List<BoxShadow> get lg => [
    BoxShadow(
      color: lightShadowColor,
      offset: const Offset(0, 6),
      blurRadius: 10,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: lightShadowColor.withValues(alpha: 0.06),
      offset: const Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];
  
  /// 超大阴影（elevation 8）
  static List<BoxShadow> get xl => [
    BoxShadow(
      color: lightShadowColor,
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: lightShadowColor.withValues(alpha: 0.06),
      offset: const Offset(0, 6),
      blurRadius: 10,
      spreadRadius: -4,
    ),
  ];
  
  /// 双倍大阴影（elevation 12）
  static List<BoxShadow> get xxl => [
    BoxShadow(
      color: lightShadowColor,
      offset: const Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -6,
    ),
    BoxShadow(
      color: lightShadowColor.withValues(alpha: 0.08),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -6,
    ),
  ];
  
  /// 三倍大阴影（elevation 16）
  static List<BoxShadow> get xxxl => [
    BoxShadow(
      color: lightShadowColor,
      offset: const Offset(0, 16),
      blurRadius: 32,
      spreadRadius: -8,
    ),
    BoxShadow(
      color: lightShadowColor.withValues(alpha: 0.1),
      offset: const Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -8,
    ),
  ];
  
  // ==================== 暗色主题阴影 ====================
  
  /// 暗色主题超小阴影
  static List<BoxShadow> get darkXs => [
    BoxShadow(
      color: darkShadowColor,
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];
  
  /// 暗色主题小阴影
  static List<BoxShadow> get darkSm => [
    BoxShadow(
      color: darkShadowColor,
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];
  
  /// 暗色主题中等阴影
  static List<BoxShadow> get darkMd => [
    BoxShadow(
      color: darkShadowColor,
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: darkShadowColor.withValues(alpha: 0.15),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: -1,
    ),
  ];
  
  /// 暗色主题大阴影
  static List<BoxShadow> get darkLg => [
    BoxShadow(
      color: darkShadowColor,
      offset: const Offset(0, 6),
      blurRadius: 12,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: darkShadowColor.withValues(alpha: 0.15),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: -2,
    ),
  ];
  
  /// 暗色主题超大阴影
  static List<BoxShadow> get darkXl => [
    BoxShadow(
      color: darkShadowColor,
      offset: const Offset(0, 8),
      blurRadius: 20,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: darkShadowColor.withValues(alpha: 0.15),
      offset: const Offset(0, 6),
      blurRadius: 12,
      spreadRadius: -4,
    ),
  ];
  
  // ==================== 特定用途阴影 ====================
  
  /// 卡片阴影
  static List<BoxShadow> get card => sm;
  
  /// 悬浮卡片阴影
  static List<BoxShadow> get cardHover => md;
  
  /// 按钮阴影
  static List<BoxShadow> get button => xs;
  
  /// 悬浮按钮阴影
  static List<BoxShadow> get buttonHover => sm;
  
  /// 按下按钮阴影
  static List<BoxShadow> get buttonPressed => none;
  
  /// 浮动操作按钮阴影
  static List<BoxShadow> get fab => lg;
  
  /// 对话框阴影
  static List<BoxShadow> get dialog => xl;
  
  /// 底部弹窗阴影
  static List<BoxShadow> get bottomSheet => lg;
  
  /// 导航栏阴影
  static List<BoxShadow> get navigationBar => xs;
  
  /// 应用栏阴影
  static List<BoxShadow> get appBar => xs;
  
  /// 输入框阴影
  static List<BoxShadow> get input => none;
  
  /// 聚焦输入框阴影
  static List<BoxShadow> get inputFocus => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.2),
      offset: const Offset(0, 0),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];
  
  /// 图片阴影
  static List<BoxShadow> get image => sm;
  
  /// 头像阴影
  static List<BoxShadow> get avatar => xs;
  
  /// 标签阴影
  static List<BoxShadow> get chip => xs;
  
  /// 提示阴影
  static List<BoxShadow> get tooltip => md;
  
  /// 菜单阴影
  static List<BoxShadow> get menu => lg;
  
  /// 抽屉阴影
  static List<BoxShadow> get drawer => xl;
  
  // ==================== 彩色阴影 ====================
  
  /// 主色调阴影
  static List<BoxShadow> get primary => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.3),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
  
  /// 成功色阴影
  static List<BoxShadow> get success => [
    BoxShadow(
      color: AppColors.success.withValues(alpha: 0.3),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
  
  /// 警告色阴影
  static List<BoxShadow> get warning => [
    BoxShadow(
      color: AppColors.warning.withValues(alpha: 0.3),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
  
  /// 错误色阴影
  static List<BoxShadow> get error => [
    BoxShadow(
      color: AppColors.error.withValues(alpha: 0.3),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
  
  // ==================== 工具方法 ====================
  
  /// 根据主题获取阴影
  static List<BoxShadow> forTheme(
    List<BoxShadow> lightShadows,
    List<BoxShadow> darkShadows,
    Brightness brightness,
  ) {
    return brightness == Brightness.light ? lightShadows : darkShadows;
  }
  
  /// 根据主题获取卡片阴影
  static List<BoxShadow> cardForTheme(Brightness brightness) {
    return brightness == Brightness.light ? card : darkSm;
  }
  
  /// 根据主题获取按钮阴影
  static List<BoxShadow> buttonForTheme(Brightness brightness) {
    return brightness == Brightness.light ? button : darkXs;
  }
  
  /// 根据主题获取对话框阴影
  static List<BoxShadow> dialogForTheme(Brightness brightness) {
    return brightness == Brightness.light ? dialog : darkXl;
  }
  
  /// 创建自定义阴影
  static List<BoxShadow> custom({
    required Color color,
    required Offset offset,
    required double blurRadius,
    double spreadRadius = 0,
  }) {
    return [
      BoxShadow(
        color: color,
        offset: offset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ];
  }
  
  /// 创建多层阴影
  static List<BoxShadow> layered(List<BoxShadow> shadows) {
    return shadows;
  }
  
  /// 调整阴影强度
  static List<BoxShadow> adjustIntensity(
    List<BoxShadow> shadows,
    double factor,
  ) {
    return shadows.map((shadow) {
      return BoxShadow(
        color: shadow.color.withValues(
          alpha: (shadow.color.alpha * factor).clamp(0.0, 1.0),
        ),
        offset: shadow.offset * factor,
        blurRadius: shadow.blurRadius * factor,
        spreadRadius: shadow.spreadRadius * factor,
      );
    }).toList();
  }
  
  /// 改变阴影颜色
  static List<BoxShadow> withColor(
    List<BoxShadow> shadows,
    Color color,
  ) {
    return shadows.map((shadow) {
      return shadow.copyWith(color: color);
    }).toList();
  }
}

/// 阴影扩展方法
extension ShadowExtensions on List<BoxShadow> {
  /// 调整阴影强度
  List<BoxShadow> withIntensity(double factor) {
    return AppShadows.adjustIntensity(this, factor);
  }
  
  /// 改变阴影颜色
  List<BoxShadow> withColor(Color color) {
    return AppShadows.withColor(this, color);
  }
  
  /// 添加主题适配
  List<BoxShadow> adaptToTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return withIntensity(1.5); // 暗色主题增强阴影
    }
    return this;
  }
}

/// Widget 阴影扩展方法
extension WidgetShadowExtensions on Widget {
  /// 添加容器阴影
  Widget withShadow(
    List<BoxShadow> boxShadow, {
    Color? color,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: this,
    );
  }
  
  /// 添加卡片阴影
  Widget withCardShadow({Brightness? brightness}) {
    final theme = brightness ?? Brightness.light;
    return withShadow(AppShadows.cardForTheme(theme));
  }
  
  /// 添加按钮阴影
  Widget withButtonShadow({Brightness? brightness}) {
    final theme = brightness ?? Brightness.light;
    return withShadow(AppShadows.buttonForTheme(theme));
  }
  
  /// 添加主色调阴影
  Widget withPrimaryShadow() {
    return withShadow(AppShadows.primary);
  }
  
  /// 添加成功色阴影
  Widget withSuccessShadow() {
    return withShadow(AppShadows.success);
  }
  
  /// 添加警告色阴影
  Widget withWarningShadow() {
    return withShadow(AppShadows.warning);
  }
  
  /// 添加错误色阴影
  Widget withErrorShadow() {
    return withShadow(AppShadows.error);
  }
}

/// 阴影动画工具类
class ShadowAnimations {
  /// 悬浮效果动画
  static List<BoxShadow> hover(
    List<BoxShadow> baseShadow,
    double progress,
  ) {
    return baseShadow.map((shadow) {
      return BoxShadow(
        color: shadow.color.withValues(
          alpha: shadow.color.alpha + (0.1 * progress),
        ),
        offset: Offset(
          shadow.offset.dx,
          shadow.offset.dy + (2 * progress),
        ),
        blurRadius: shadow.blurRadius + (4 * progress),
        spreadRadius: shadow.spreadRadius,
      );
    }).toList();
  }
  
  /// 按下效果动画
  static List<BoxShadow> press(
    List<BoxShadow> baseShadow,
    double progress,
  ) {
    return baseShadow.map((shadow) {
      return BoxShadow(
        color: shadow.color.withValues(
          alpha: shadow.color.alpha * (1 - progress * 0.5),
        ),
        offset: Offset(
          shadow.offset.dx * (1 - progress * 0.5),
          shadow.offset.dy * (1 - progress * 0.5),
        ),
        blurRadius: shadow.blurRadius * (1 - progress * 0.3),
        spreadRadius: shadow.spreadRadius,
      );
    }).toList();
  }
  
  /// 脉冲效果动画
  static List<BoxShadow> pulse(
    List<BoxShadow> baseShadow,
    double progress,
  ) {
    final pulseIntensity = math.sin(progress * math.pi * 2) * 0.5 + 0.5;
    return baseShadow.map((shadow) {
      return BoxShadow(
        color: shadow.color.withValues(
          alpha: shadow.color.alpha + (0.2 * pulseIntensity),
        ),
        offset: shadow.offset,
        blurRadius: shadow.blurRadius + (6 * pulseIntensity),
        spreadRadius: shadow.spreadRadius + (2 * pulseIntensity),
      );
    }).toList();
  }
}
