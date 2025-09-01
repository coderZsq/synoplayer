import 'package:flutter/cupertino.dart';

class AppTheme {
  // iOS 亮色主题 - 遵循 Apple HIG 设计规范
  static const CupertinoThemeData lightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemBlue,
    primaryContrastingColor: CupertinoColors.white,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.label,
      textStyle: TextStyle(
        color: CupertinoColors.label,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    ),
    barBackgroundColor: CupertinoColors.systemBackground,
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
  );

  // iOS 暗色主题 - 专业视觉设计考量
  static const CupertinoThemeData darkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.systemBlue,
    primaryContrastingColor: CupertinoColors.black,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.label,
      textStyle: TextStyle(
        color: CupertinoColors.label,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    ),
    barBackgroundColor: CupertinoColors.systemBackground,
    scaffoldBackgroundColor: darkPrimaryBackground,
  );

  // 专业的暗黑模式颜色系统
  static const Color darkPrimaryBackground = Color(0xFF1C1C1E);      // 主背景 - 深灰黑，减少眼睛疲劳
  static const Color darkSecondaryBackground = Color(0xFF2C2C2E);    // 次要背景 - 稍浅的深灰，创造层次
  static const Color darkTertiaryBackground = Color(0xFF3A3A3C);    // 第三级背景 - 卡片、按钮背景
  static const Color darkQuaternaryBackground = Color(0xFF48484A);   // 第四级背景 - 输入框、选择器背景
  
  // 暗黑模式文本颜色 - 考虑对比度和可读性
  static const Color darkPrimaryText = Color(0xFFFFFFFF);            // 主要文本 - 纯白，最高对比度
  static const Color darkSecondaryText = Color(0xFFEBEBF5);         // 次要文本 - 浅灰白，保持可读性
  static const Color darkTertiaryText = Color(0x99EBEBF5);        // 第三级文本 - 半透明，降低视觉权重
  static const Color darkQuaternaryText = Color(0x4DEBEBF5);      // 第四级文本 - 更透明，辅助信息
  
  // 暗黑模式分隔线和边框
  static const Color darkSeparator = Color(0xFF38383A);             // 分隔线 - 深灰，不突兀
  static const Color darkBorder = Color(0xFF48484A);                // 边框 - 与背景形成微妙对比
  
  // 暗黑模式强调色 - 考虑品牌一致性和视觉冲击
  static const Color darkAccentBlue = Color(0xFF0A84FF);            // 蓝色强调 - 品牌色，适当调亮
  static const Color darkAccentGreen = Color(0xFF30D158);           // 绿色 - 成功状态
  static const Color darkAccentOrange = Color(0xFFFF9F0A);          // 橙色 - 警告状态
  static const Color darkAccentRed = Color(0xFFFF453A);             // 红色 - 错误状态
  
  // 暗黑模式阴影和光效
  static const Color darkShadow = Color(0xFF000000);                // 阴影 - 纯黑，创造深度
  static const Color darkOverlay = Color(0x80000000);             // 遮罩 - 半透明黑，模态框背景
  
  // 亮色模式颜色系统 - 保持原有的 iOS 规范
  static const Color lightPrimaryBackground = CupertinoColors.systemBackground;
  static const Color lightSecondaryBackground = CupertinoColors.secondarySystemBackground;
  static const Color lightTertiaryBackground = CupertinoColors.tertiarySystemBackground;
  static const Color lightQuaternaryBackground = CupertinoColors.tertiarySystemBackground;
  
  // 亮色模式文本颜色
  static const Color lightPrimaryText = CupertinoColors.label;
  static const Color lightSecondaryText = CupertinoColors.secondaryLabel;
  static const Color lightTertiaryText = CupertinoColors.tertiaryLabel;
  static const Color lightQuaternaryText = CupertinoColors.quaternaryLabel;
  
  // 亮色模式分隔线和边框
  static const Color lightSeparator = CupertinoColors.separator;
  static const Color lightBorder = CupertinoColors.separator;
  
  // 亮色模式强调色
  static const Color lightAccentBlue = CupertinoColors.systemBlue;
  static const Color lightAccentGreen = CupertinoColors.systemGreen;
  static const Color lightAccentOrange = CupertinoColors.systemOrange;
  static const Color lightAccentRed = CupertinoColors.systemRed;
  
  // 亮色模式阴影和光效
  static const Color lightShadow = Color(0xFF000000);
  static const Color lightOverlay = Color(0x40000000);

  // 获取当前主题下的背景色 - 考虑视觉层次
  static Color getBackgroundColor(Brightness brightness) {
    return brightness == Brightness.light ? lightPrimaryBackground : darkPrimaryBackground;
  }

  // 获取当前主题下的次要背景色
  static Color getSecondaryBackgroundColor(Brightness brightness) {
    return brightness == Brightness.light ? lightSecondaryBackground : darkSecondaryBackground;
  }

  // 获取当前主题下的第三级背景色
  static Color getTertiaryBackgroundColor(Brightness brightness) {
    return brightness == Brightness.light ? lightTertiaryBackground : darkTertiaryBackground;
  }

  // 获取当前主题下的第四级背景色
  static Color getQuaternaryBackgroundColor(Brightness brightness) {
    return brightness == Brightness.light ? lightQuaternaryBackground : darkQuaternaryBackground;
  }

  // 获取当前主题下的主要文本色
  static Color getPrimaryTextColor(Brightness brightness) {
    return brightness == Brightness.light ? lightPrimaryText : darkPrimaryText;
  }

  // 获取当前主题下的次要文本色
  static Color getSecondaryTextColor(Brightness brightness) {
    return brightness == Brightness.light ? lightSecondaryText : darkSecondaryText;
  }

  // 获取当前主题下的第三级文本色
  static Color getTertiaryTextColor(Brightness brightness) {
    return brightness == Brightness.light ? lightTertiaryText : darkTertiaryText;
  }

  // 获取当前主题下的第四级文本色
  static Color getQuaternaryTextColor(Brightness brightness) {
    return brightness == Brightness.light ? lightQuaternaryText : darkQuaternaryText;
  }

  // 获取当前主题下的分隔线颜色
  static Color getSeparatorColor(Brightness brightness) {
    return brightness == Brightness.light ? lightSeparator : darkSeparator;
  }

  // 获取当前主题下的边框颜色
  static Color getBorderColor(Brightness brightness) {
    return brightness == Brightness.light ? lightBorder : darkBorder;
  }

  // 获取当前主题下的强调色
  static Color getAccentColor(Brightness brightness, {Color? customColor}) {
    if (customColor != null) return customColor;
    return brightness == Brightness.light ? lightAccentBlue : darkAccentBlue;
  }

  // 获取当前主题下的成功色
  static Color getSuccessColor(Brightness brightness) {
    return brightness == Brightness.light ? lightAccentGreen : darkAccentGreen;
  }

  // 获取当前主题下的警告色
  static Color getWarningColor(Brightness brightness) {
    return brightness == Brightness.light ? lightAccentOrange : darkAccentOrange;
  }

  // 获取当前主题下的错误色
  static Color getErrorColor(Brightness brightness) {
    return brightness == Brightness.light ? lightAccentRed : darkAccentRed;
  }

  // 获取当前主题下的阴影颜色
  static Color getShadowColor(Brightness brightness) {
    return brightness == Brightness.light ? lightShadow : darkShadow;
  }

  // 获取当前主题下的遮罩颜色
  static Color getOverlayColor(Brightness brightness) {
    return brightness == Brightness.light ? lightOverlay : darkOverlay;
  }
}
