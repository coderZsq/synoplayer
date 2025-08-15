import 'package:flutter/material.dart';

/// 应用间距系统
/// 
/// 提供统一的间距规范，确保界面布局的一致性
abstract class AppSpacing {
  
  // ==================== 基础间距单位 ====================
  
  /// 基础间距单位（4px）
  static const double unit = 4.0;
  
  // ==================== 间距常量 ====================
  
  /// 超小间距
  static const double xs = unit; // 4px
  
  /// 小间距
  static const double sm = unit * 2; // 8px
  
  /// 中等间距
  static const double md = unit * 3; // 12px
  
  /// 大间距
  static const double lg = unit * 4; // 16px
  
  /// 超大间距
  static const double xl = unit * 5; // 20px
  
  /// 双倍大间距
  static const double xxl = unit * 6; // 24px
  
  /// 三倍大间距
  static const double xxxl = unit * 8; // 32px
  
  /// 四倍大间距
  static const double xxxxl = unit * 10; // 40px
  
  /// 五倍大间距
  static const double xxxxxl = unit * 12; // 48px
  
  // ==================== 特定用途间距 ====================
  
  /// 页面边距
  static const double pagePadding = lg; // 16px
  
  /// 卡片内边距
  static const double cardPadding = lg; // 16px
  
  /// 列表项内边距
  static const double listItemPadding = md; // 12px
  
  /// 按钮内边距（水平）
  static const double buttonPaddingHorizontal = xl; // 20px
  
  /// 按钮内边距（垂直）
  static const double buttonPaddingVertical = md; // 12px
  
  /// 输入框内边距
  static const double inputPadding = md; // 12px
  
  /// 章节间距
  static const double sectionSpacing = xxl; // 24px
  
  /// 组件间距
  static const double componentSpacing = lg; // 16px
  
  /// 元素间距
  static const double elementSpacing = sm; // 8px
  
  /// 行间距
  static const double lineSpacing = xs; // 4px
  
  // ==================== EdgeInsets 辅助方法 ====================
  
  /// 全方向相同间距
  static EdgeInsets all(double value) => EdgeInsets.all(value);
  
  /// 水平间距
  static EdgeInsets horizontal(double value) => 
      EdgeInsets.symmetric(horizontal: value);
  
  /// 垂直间距
  static EdgeInsets vertical(double value) => 
      EdgeInsets.symmetric(vertical: value);
  
  /// 对称间距
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  
  /// 自定义四边间距
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      );
  
  // ==================== 预定义 EdgeInsets ====================
  
  /// 零间距
  static const EdgeInsets zero = EdgeInsets.zero;
  
  /// 超小间距
  static EdgeInsets get allXs => all(xs);
  static EdgeInsets get horizontalXs => horizontal(xs);
  static EdgeInsets get verticalXs => vertical(xs);
  
  /// 小间距
  static EdgeInsets get allSm => all(sm);
  static EdgeInsets get horizontalSm => horizontal(sm);
  static EdgeInsets get verticalSm => vertical(sm);
  
  /// 中等间距
  static EdgeInsets get allMd => all(md);
  static EdgeInsets get horizontalMd => horizontal(md);
  static EdgeInsets get verticalMd => vertical(md);
  
  /// 大间距
  static EdgeInsets get allLg => all(lg);
  static EdgeInsets get horizontalLg => horizontal(lg);
  static EdgeInsets get verticalLg => vertical(lg);
  
  /// 超大间距
  static EdgeInsets get allXl => all(xl);
  static EdgeInsets get horizontalXl => horizontal(xl);
  static EdgeInsets get verticalXl => vertical(xl);
  
  /// 双倍大间距
  static EdgeInsets get allXxl => all(xxl);
  static EdgeInsets get horizontalXxl => horizontal(xxl);
  static EdgeInsets get verticalXxl => vertical(xxl);
  
  // ==================== 组合间距 ====================
  
  /// 页面内边距
  static EdgeInsets get page => all(pagePadding);
  
  /// 卡片内边距
  static EdgeInsets get card => all(cardPadding);
  
  /// 列表项内边距
  static EdgeInsets get listItem => all(listItemPadding);
  
  /// 按钮内边距
  static EdgeInsets get button => symmetric(
        horizontal: buttonPaddingHorizontal,
        vertical: buttonPaddingVertical,
      );
  
  /// 输入框内边距
  static EdgeInsets get input => all(inputPadding);
  
  /// 小按钮内边距
  static EdgeInsets get smallButton => symmetric(
        horizontal: md,
        vertical: sm,
      );
  
  /// 大按钮内边距
  static EdgeInsets get largeButton => symmetric(
        horizontal: xxl,
        vertical: lg,
      );
  
  /// 页面标题间距
  static EdgeInsets get pageTitle => only(bottom: sectionSpacing);
  
  /// 章节标题间距
  static EdgeInsets get sectionTitle => only(
        top: sectionSpacing,
        bottom: componentSpacing,
      );
  
  /// 表单字段间距
  static EdgeInsets get formField => only(bottom: componentSpacing);
  
  // ==================== SizedBox 辅助方法 ====================
  
  /// 水平间距盒子
  static Widget horizontalSpace(double width) => SizedBox(width: width);
  
  /// 垂直间距盒子
  static Widget verticalSpace(double height) => SizedBox(height: height);
  
  /// 预定义水平间距盒子
  static Widget get hXs => horizontalSpace(xs);
  static Widget get hSm => horizontalSpace(sm);
  static Widget get hMd => horizontalSpace(md);
  static Widget get hLg => horizontalSpace(lg);
  static Widget get hXl => horizontalSpace(xl);
  static Widget get hXxl => horizontalSpace(xxl);
  static Widget get hXxxl => horizontalSpace(xxxl);
  
  /// 预定义垂直间距盒子
  static Widget get vXs => verticalSpace(xs);
  static Widget get vSm => verticalSpace(sm);
  static Widget get vMd => verticalSpace(md);
  static Widget get vLg => verticalSpace(lg);
  static Widget get vXl => verticalSpace(xl);
  static Widget get vXxl => verticalSpace(xxl);
  static Widget get vXxxl => verticalSpace(xxxl);
  
  // ==================== Divider 辅助方法 ====================
  
  /// 水平分割线
  static Widget horizontalDivider({
    double? height,
    double? thickness,
    Color? color,
    double? indent,
    double? endIndent,
  }) => Divider(
        height: height ?? lg,
        thickness: thickness,
        color: color,
        indent: indent,
        endIndent: endIndent,
      );
  
  /// 垂直分割线
  static Widget verticalDivider({
    double? width,
    double? thickness,
    Color? color,
    double? indent,
    double? endIndent,
  }) => VerticalDivider(
        width: width ?? lg,
        thickness: thickness,
        color: color,
        indent: indent,
        endIndent: endIndent,
      );
  
  // ==================== 响应式间距 ====================
  
  /// 根据屏幕尺寸调整间距
  static double responsive(BuildContext context, {
    double mobile = md,
    double tablet = lg,
    double desktop = xl,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return mobile;
    } else if (screenWidth < 1024) {
      return tablet;
    } else {
      return desktop;
    }
  }
  
  /// 响应式页面内边距
  static EdgeInsets responsivePage(BuildContext context) {
    final spacing = responsive(context);
    return all(spacing);
  }
  
  /// 响应式组件间距
  static EdgeInsets responsiveComponent(BuildContext context) {
    final spacing = responsive(
      context,
      mobile: sm,
      tablet: md,
      desktop: lg,
    );
    return all(spacing);
  }
}

/// 间距扩展方法
extension SpacingExtensions on double {
  /// 转换为水平间距盒子
  Widget get horizontalSpace => SizedBox(width: this);
  
  /// 转换为垂直间距盒子
  Widget get verticalSpace => SizedBox(height: this);
  
  /// 转换为全方向内边距
  EdgeInsets get allPadding => EdgeInsets.all(this);
  
  /// 转换为水平内边距
  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: this);
  
  /// 转换为垂直内边距
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: this);
  
  /// 转换为顶部内边距
  EdgeInsets get topPadding => EdgeInsets.only(top: this);
  
  /// 转换为底部内边距
  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: this);
  
  /// 转换为左侧内边距
  EdgeInsets get leftPadding => EdgeInsets.only(left: this);
  
  /// 转换为右侧内边距
  EdgeInsets get rightPadding => EdgeInsets.only(right: this);
}

/// Widget 间距扩展方法
extension WidgetSpacingExtensions on Widget {
  /// 添加内边距
  Widget withPadding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }
  
  /// 添加外边距
  Widget withMargin(EdgeInsets margin) {
    return Container(margin: margin, child: this);
  }
  
  /// 添加全方向内边距
  Widget withAllPadding(double padding) {
    return withPadding(EdgeInsets.all(padding));
  }
  
  /// 添加水平内边距
  Widget withHorizontalPadding(double padding) {
    return withPadding(EdgeInsets.symmetric(horizontal: padding));
  }
  
  /// 添加垂直内边距
  Widget withVerticalPadding(double padding) {
    return withPadding(EdgeInsets.symmetric(vertical: padding));
  }
  
  /// 添加页面级内边距
  Widget withPagePadding() {
    return withPadding(AppSpacing.page);
  }
  
  /// 添加卡片级内边距
  Widget withCardPadding() {
    return withPadding(AppSpacing.card);
  }
  
  /// 添加组件级内边距
  Widget withComponentPadding() {
    return withAllPadding(AppSpacing.componentSpacing);
  }
}

/// 间距工具类
class SpacingUtils {
  /// 计算等分间距
  static List<Widget> evenlySpaced(
    List<Widget> children, {
    double spacing = AppSpacing.md,
    Axis axis = Axis.vertical,
  }) {
    if (children.isEmpty) return children;
    
    final spacedChildren = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(
          axis == Axis.vertical 
              ? AppSpacing.verticalSpace(spacing)
              : AppSpacing.horizontalSpace(spacing),
        );
      }
    }
    return spacedChildren;
  }
  
  /// 在列表中添加间距
  static List<Widget> addSpacing(
    List<Widget> children, {
    double spacing = AppSpacing.md,
    Axis axis = Axis.vertical,
  }) {
    return evenlySpaced(children, spacing: spacing, axis: axis);
  }
  
  /// 创建带间距的Column
  static Column spacedColumn({
    required List<Widget> children,
    double spacing = AppSpacing.md,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: evenlySpaced(children, spacing: spacing, axis: Axis.vertical),
    );
  }
  
  /// 创建带间距的Row
  static Row spacedRow({
    required List<Widget> children,
    double spacing = AppSpacing.md,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: evenlySpaced(children, spacing: spacing, axis: Axis.horizontal),
    );
  }
}
