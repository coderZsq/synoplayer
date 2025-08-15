import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/index.dart';

/// 主题设置组件
/// 
/// 提供主题切换功能
class ThemeSettingsWidget extends ConsumerWidget {
  const ThemeSettingsWidget({
    super.key,
    required this.onThemeChanged,
  });

  final Function(String description) onThemeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeAsync = ref.watch(themeNotifierProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.blue.shade900.withValues(alpha: 0.3) : Colors.blue.shade50,
        border: Border.all(
          color: isDark ? Colors.blue.shade700 : Colors.blue.shade200,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            children: [
              Icon(
                Icons.palette,
                color: isDark ? Colors.blue.shade300 : Colors.blue.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '外观设置',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // 描述
          Text(
            '选择您喜欢的主题模式，让应用更符合您的使用习惯',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.blue.shade200 : Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // 主题选择按钮
          themeAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('主题加载失败: $error'),
            data: (currentTheme) => Row(
              children: [
                Expanded(
                  child: _buildThemeButton(
                    context,
                    currentTheme,
                    themeNotifier,
                    AppThemeMode.light,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildThemeButton(
                    context,
                    currentTheme,
                    themeNotifier,
                    AppThemeMode.dark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildThemeButton(
                    context,
                    currentTheme,
                    themeNotifier,
                    AppThemeMode.system,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeButton(
    BuildContext context,
    AppThemeMode currentMode,
    ThemeNotifier themeNotifier,
    AppThemeMode mode,
  ) {
    final isSelected = currentMode == mode;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await themeNotifier.setThemeMode(mode);
          onThemeChanged(mode.description);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? Colors.blue.shade600 : Colors.blue.shade100)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? (isDark ? Colors.blue.shade400 : Colors.blue.shade300)
                  : (isDark ? Colors.grey.shade600 : Colors.grey.shade300),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                mode.icon,
                color: isSelected
                    ? (isDark ? Colors.blue.shade200 : Colors.blue.shade700)
                    : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                mode.description.replaceAll('模式', ''),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? (isDark ? Colors.blue.shade200 : Colors.blue.shade700)
                      : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
