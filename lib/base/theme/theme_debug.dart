import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_provider.dart';
import 'app_theme.dart';

class ThemeDebugWidget extends ConsumerWidget {
  const ThemeDebugWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(themeProvider);
    final currentTheme = ref.watch(currentThemeProvider);
    
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CupertinoColors.systemGrey4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '🔍 主题调试信息',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: CupertinoColors.label,
            ),
          ),
          const SizedBox(height: 8),
          Text('当前亮度: ${brightness.name}', style: TextStyle(color: CupertinoColors.label)),
          Text('主题类型: ${brightness == Brightness.dark ? "暗黑模式" : "亮色模式"}', style: TextStyle(color: CupertinoColors.label)),
          Text('主题对象: ${currentTheme.runtimeType}', style: TextStyle(color: CupertinoColors.label)),
          Text('导航栏背景: ${currentTheme.barBackgroundColor}', style: TextStyle(color: CupertinoColors.label)),
          Text('脚手架背景: ${currentTheme.scaffoldBackgroundColor}', style: TextStyle(color: CupertinoColors.label)),
          const SizedBox(height: 8),
          Text('🎨 颜色测试:', style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.label)),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.getBackgroundColor(brightness),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '主背景色',
                style: TextStyle(
                  color: AppTheme.getPrimaryTextColor(brightness),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.getSecondaryBackgroundColor(brightness),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '次要背景色',
                style: TextStyle(
                  color: AppTheme.getPrimaryTextColor(brightness),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.getTertiaryBackgroundColor(brightness),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '第三级背景色',
                style: TextStyle(
                  color: AppTheme.getPrimaryTextColor(brightness),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
