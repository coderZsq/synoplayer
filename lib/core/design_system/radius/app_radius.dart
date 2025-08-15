import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 应用圆角系统
/// 
/// 提供统一的圆角规范，确保界面元素的一致性
abstract class AppRadius {
  
  // ==================== 基础圆角值 ====================
  
  /// 无圆角
  static const double none = 0.0;
  
  /// 超小圆角
  static const double xs = 2.0;
  
  /// 小圆角
  static const double sm = 4.0;
  
  /// 中等圆角
  static const double md = 8.0;
  
  /// 大圆角
  static const double lg = 12.0;
  
  /// 超大圆角
  static const double xl = 16.0;
  
  /// 双倍大圆角
  static const double xxl = 20.0;
  
  /// 三倍大圆角
  static const double xxxl = 24.0;
  
  /// 四倍大圆角
  static const double xxxxl = 32.0;
  
  /// 圆形（最大圆角）
  static const double circular = 999.0;
  
  // ==================== 特定用途圆角 ====================
  
  /// 按钮圆角
  static const double button = md; // 8px
  
  /// 小按钮圆角
  static const double buttonSmall = sm; // 4px
  
  /// 大按钮圆角
  static const double buttonLarge = lg; // 12px
  
  /// 卡片圆角
  static const double card = lg; // 12px
  
  /// 对话框圆角
  static const double dialog = lg; // 12px
  
  /// 输入框圆角
  static const double input = md; // 8px
  
  /// 标签圆角
  static const double chip = xl; // 16px
  
  /// 头像圆角
  static const double avatar = circular; // 圆形
  
  /// 徽章圆角
  static const double badge = xl; // 16px
  
  /// 底部导航栏圆角
  static const double bottomSheet = xl; // 16px
  
  /// 应用栏圆角
  static const double appBar = none; // 无圆角
  
  /// 图片圆角
  static const double image = md; // 8px
  
  /// 容器圆角
  static const double container = sm; // 4px
  
  // ==================== BorderRadius 辅助方法 ====================
  
  /// 全方向相同圆角
  static BorderRadius all(double radius) => BorderRadius.circular(radius);
  
  /// 自定义四角圆角
  static BorderRadius only({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) => BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      );
  
  /// 顶部圆角
  static BorderRadius top(double radius) => only(
        topLeft: radius,
        topRight: radius,
      );
  
  /// 底部圆角
  static BorderRadius bottom(double radius) => only(
        bottomLeft: radius,
        bottomRight: radius,
      );
  
  /// 左侧圆角
  static BorderRadius left(double radius) => only(
        topLeft: radius,
        bottomLeft: radius,
      );
  
  /// 右侧圆角
  static BorderRadius right(double radius) => only(
        topRight: radius,
        bottomRight: radius,
      );
  
  // ==================== 预定义 BorderRadius ====================
  
  /// 无圆角
  static BorderRadius get noRadius => all(none);
  
  /// 超小圆角
  static BorderRadius get xsRadius => all(xs);
  
  /// 小圆角
  static BorderRadius get smRadius => all(sm);
  
  /// 中等圆角
  static BorderRadius get mdRadius => all(md);
  
  /// 大圆角
  static BorderRadius get lgRadius => all(lg);
  
  /// 超大圆角
  static BorderRadius get xlRadius => all(xl);
  
  /// 双倍大圆角
  static BorderRadius get xxlRadius => all(xxl);
  
  /// 三倍大圆角
  static BorderRadius get xxxlRadius => all(xxxl);
  
  /// 四倍大圆角
  static BorderRadius get xxxxlRadius => all(xxxxl);
  
  /// 圆形
  static BorderRadius get circularRadius => all(circular);
  
  // ==================== 组件专用圆角 ====================
  
  /// 按钮圆角
  static BorderRadius get buttonRadius => all(button);
  
  /// 小按钮圆角
  static BorderRadius get buttonSmallRadius => all(buttonSmall);
  
  /// 大按钮圆角
  static BorderRadius get buttonLargeRadius => all(buttonLarge);
  
  /// 卡片圆角
  static BorderRadius get cardRadius => all(card);
  
  /// 对话框圆角
  static BorderRadius get dialogRadius => all(dialog);
  
  /// 输入框圆角
  static BorderRadius get inputRadius => all(input);
  
  /// 标签圆角
  static BorderRadius get chipRadius => all(chip);
  
  /// 头像圆角
  static BorderRadius get avatarRadius => all(avatar);
  
  /// 徽章圆角
  static BorderRadius get badgeRadius => all(badge);
  
  /// 底部弹窗圆角
  static BorderRadius get bottomSheetRadius => top(bottomSheet);
  
  /// 图片圆角
  static BorderRadius get imageRadius => all(image);
  
  /// 容器圆角
  static BorderRadius get containerRadius => all(container);
  
  // ==================== RoundedRectangleBorder 辅助方法 ====================
  
  /// 创建圆角边框
  static RoundedRectangleBorder border(double radius, {BorderSide? side}) {
    return RoundedRectangleBorder(
      borderRadius: all(radius),
      side: side ?? BorderSide.none,
    );
  }
  
  /// 创建带边框的圆角
  static RoundedRectangleBorder borderWithSide({
    required double radius,
    required Color color,
    double width = 1.0,
  }) {
    return RoundedRectangleBorder(
      borderRadius: all(radius),
      side: BorderSide(color: color, width: width),
    );
  }
  
  // ==================== 预定义 RoundedRectangleBorder ====================
  
  /// 按钮形状
  static RoundedRectangleBorder get buttonShape => border(button);
  
  /// 卡片形状
  static RoundedRectangleBorder get cardShape => border(card);
  
  /// 对话框形状
  static RoundedRectangleBorder get dialogShape => border(dialog);
  
  /// 输入框形状
  static RoundedRectangleBorder get inputShape => border(input);
  
  /// 标签形状
  static RoundedRectangleBorder get chipShape => border(chip);
  
  // ==================== 特殊圆角组合 ====================
  
  /// 顶部圆角（底部弹窗用）
  static BorderRadius get topRoundedRadius => top(lg);
  
  /// 底部圆角（顶部弹窗用）
  static BorderRadius get bottomRoundedRadius => bottom(lg);
  
  /// 左侧圆角（右侧弹窗用）
  static BorderRadius get leftRoundedRadius => left(lg);
  
  /// 右侧圆角（左侧弹窗用）
  static BorderRadius get rightRoundedRadius => right(lg);
  
  /// 卡片顶部圆角
  static BorderRadius get cardTopRadius => top(card);
  
  /// 卡片底部圆角
  static BorderRadius get cardBottomRadius => bottom(card);
  
  /// 选项卡圆角（顶部圆角）
  static BorderRadius get tabRadius => top(md);
  
  // ==================== 响应式圆角 ====================
  
  /// 根据屏幕尺寸调整圆角
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
  
  /// 响应式卡片圆角
  static BorderRadius responsiveCard(BuildContext context) {
    final radius = responsive(context);
    return all(radius);
  }
  
  /// 响应式按钮圆角
  static BorderRadius responsiveButton(BuildContext context) {
    final radius = responsive(
      context,
      mobile: sm,
      tablet: md,
      desktop: lg,
    );
    return all(radius);
  }
}

/// 圆角扩展方法
extension RadiusExtensions on double {
  /// 转换为全方向圆角
  BorderRadius get radius => BorderRadius.circular(this);
  
  /// 转换为顶部圆角
  BorderRadius get topRadius => AppRadius.top(this);
  
  /// 转换为底部圆角
  BorderRadius get bottomRadius => AppRadius.bottom(this);
  
  /// 转换为左侧圆角
  BorderRadius get leftRadius => AppRadius.left(this);
  
  /// 转换为右侧圆角
  BorderRadius get rightRadius => AppRadius.right(this);
  
  /// 转换为圆角边框
  RoundedRectangleBorder get border => AppRadius.border(this);
  
  /// 转换为带颜色边框的圆角
  RoundedRectangleBorder borderWithColor(Color color, {double width = 1.0}) {
    return AppRadius.borderWithSide(
      radius: this,
      color: color,
      width: width,
    );
  }
}

/// Widget 圆角扩展方法
extension WidgetRadiusExtensions on Widget {
  /// 添加圆角裁剪
  Widget withRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }
  
  /// 添加自定义圆角裁剪
  Widget withBorderRadius(BorderRadius borderRadius) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: this,
    );
  }
  
  /// 添加圆形裁剪
  Widget withCircularClip() {
    return ClipOval(child: this);
  }
  
  /// 添加卡片圆角
  Widget withCardRadius() {
    return withRadius(AppRadius.card);
  }
  
  /// 添加按钮圆角
  Widget withButtonRadius() {
    return withRadius(AppRadius.button);
  }
  
  /// 添加顶部圆角
  Widget withTopRadius(double radius) {
    return withBorderRadius(AppRadius.top(radius));
  }
  
  /// 添加底部圆角
  Widget withBottomRadius(double radius) {
    return withBorderRadius(AppRadius.bottom(radius));
  }
}

/// 容器圆角工具类
class RadiusUtils {
  /// 创建带圆角的容器
  static Container roundedContainer({
    required Widget child,
    double radius = AppRadius.md,
    Color? color,
    Border? border,
    List<BoxShadow>? boxShadow,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: border,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
  
  /// 创建圆形容器
  static Container circularContainer({
    required Widget child,
    required double size,
    Color? color,
    Border? border,
    List<BoxShadow>? boxShadow,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: border,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
  
  /// 创建带圆角的卡片
  static Card roundedCard({
    required Widget child,
    double radius = AppRadius.card,
    Color? color,
    double? elevation,
    EdgeInsetsGeometry? margin,
  }) {
    return Card(
      color: color,
      elevation: elevation,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
  
  /// 创建圆形头像
  static CircleAvatar circleAvatar({
    required double radius,
    Widget? child,
    Color? backgroundColor,
    ImageProvider? backgroundImage,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      child: child,
    );
  }
}

/// 特殊形状工具类
class ShapeUtils {
  /// 创建胶囊形状（完全圆角）
  static RoundedRectangleBorder get pill => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.circular),
      );
  
  /// 创建水滴形状
  static Path teardropPath(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    
    path.moveTo(width * 0.5, 0);
    path.cubicTo(
      width * 0.8, height * 0.2,
      width * 0.8, height * 0.8,
      width * 0.5, height,
    );
    path.cubicTo(
      width * 0.2, height * 0.8,
      width * 0.2, height * 0.2,
      width * 0.5, 0,
    );
    path.close();
    
    return path;
  }
  
  /// 创建星形路径
  static Path starPath(Size size, {int points = 5}) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final outerRadius = centerX;
    final innerRadius = outerRadius * 0.4;
    
    for (int i = 0; i < points * 2; i++) {
      final angle = (i * 3.14159) / points;
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = centerX + radius * math.cos(angle - 3.14159 / 2);
      final y = centerY + radius * math.sin(angle - 3.14159 / 2);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    
    return path;
  }
}
