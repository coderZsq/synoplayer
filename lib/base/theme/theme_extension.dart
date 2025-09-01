import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart';
import 'theme_provider.dart';

extension ThemeExtension on BuildContext {
  // 获取当前主题亮度 - 直接从 provider 获取，确保准确性
  Brightness get brightness {
    try {
      // 尝试从 ProviderScope 获取当前亮度
      final container = ProviderScope.containerOf(this);
      return container.read(themeProvider);
    } catch (e) {
      // 如果失败，回退到 CupertinoTheme
      return CupertinoTheme.of(this).brightness ?? Brightness.light;
    }
  }
  
  // 背景色系统 - 4层视觉层次
  Color get backgroundColor => AppTheme.getBackgroundColor(brightness);
  Color get secondaryBackgroundColor => AppTheme.getSecondaryBackgroundColor(brightness);
  Color get tertiaryBackgroundColor => AppTheme.getTertiaryBackgroundColor(brightness);
  Color get quaternaryBackgroundColor => AppTheme.getQuaternaryBackgroundColor(brightness);
  
  // 主要背景色（导航栏等）
  Color get primaryBackgroundColor => CupertinoTheme.of(this).barBackgroundColor;
  
  // 主要颜色
  Color get primaryColor => CupertinoTheme.of(this).primaryColor;
  
  // 文本颜色系统 - 4层信息层次
  Color get textColor => AppTheme.getPrimaryTextColor(brightness);
  Color get secondaryTextColor => AppTheme.getSecondaryTextColor(brightness);
  Color get tertiaryTextColor => AppTheme.getTertiaryTextColor(brightness);
  Color get quaternaryTextColor => AppTheme.getQuaternaryTextColor(brightness);
  
  // 分隔线和边框
  Color get separatorColor => AppTheme.getSeparatorColor(brightness);
  Color get borderColor => AppTheme.getBorderColor(brightness);
  
  // 强调色系统
  Color get accentColor => AppTheme.getAccentColor(brightness);
  Color get successColor => AppTheme.getSuccessColor(brightness);
  Color get warningColor => AppTheme.getWarningColor(brightness);
  Color get errorColor => AppTheme.getErrorColor(brightness);
  
  // 阴影和遮罩
  Color get shadowColor => AppTheme.getShadowColor(brightness);
  Color get overlayColor => AppTheme.getOverlayColor(brightness);
  
  // 便捷的颜色组合方法
  Color get cardBackgroundColor => tertiaryBackgroundColor;
  Color get inputBackgroundColor => quaternaryBackgroundColor;
  Color get disabledTextColor => quaternaryTextColor;
  Color get hintTextColor => tertiaryTextColor;
  
  // 状态颜色
  Color get activeColor => accentColor;
  Color get inactiveColor => tertiaryTextColor;
}
