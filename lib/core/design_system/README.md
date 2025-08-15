# 设计系统

应用的统一设计语言和组件库，确保界面的一致性和可维护性。

## 概述

设计系统包含以下核心组件：

- **颜色系统** - 统一的颜色规范和调色板
- **字体排版** - 文字样式和排版规范
- **间距系统** - 统一的间距和布局规范
- **圆角系统** - 边框圆角规范
- **阴影系统** - 阴影和深度效果规范

## 使用方法

### 1. 导入设计系统

```dart
import 'package:your_app/core/design_system/index.dart';
```

### 2. 颜色使用

```dart
// 基础颜色
Container(color: AppColors.primary)
Container(color: AppColors.success)
Container(color: AppColors.error)

// 主题相关颜色
Container(color: AppColors.lightBackground)
Container(color: AppColors.darkBackground)

// 透明度变体
Container(color: AppColors.primaryWithOpacity(0.5))

// 扩展方法
final color = Colors.blue.lighten(0.2); // 变亮20%
final color = Colors.blue.darken(0.1);  // 变暗10%
```

### 3. 字体排版

```dart
// 标题样式
Text('大标题', style: AppTypography.h1)
Text('中标题', style: AppTypography.h2)
Text('小标题', style: AppTypography.h3)

// 正文样式
Text('大正文', style: AppTypography.bodyLarge)
Text('正文', style: AppTypography.bodyMedium)
Text('小正文', style: AppTypography.bodySmall)

// 按钮文字
Text('按钮', style: AppTypography.buttonMedium)

// 扩展方法
Text(
  '主色文字',
  style: AppTypography.bodyLarge.withPrimaryColor(),
)

Text(
  '加粗文字',
  style: AppTypography.bodyMedium.bold,
)

Text(
  '下划线文字',
  style: AppTypography.bodyMedium.underline,
)
```

### 4. 间距使用

```dart
// 基础间距
EdgeInsets.all(AppSpacing.md)     // 12px
EdgeInsets.all(AppSpacing.lg)     // 16px

// 预定义间距
padding: AppSpacing.page,         // 页面内边距
padding: AppSpacing.card,         // 卡片内边距
padding: AppSpacing.button,       // 按钮内边距

// 间距盒子
AppSpacing.vMd,                   // 垂直间距 12px
AppSpacing.hLg,                   // 水平间距 16px

// 扩展方法
Widget().withPagePadding(),       // 添加页面内边距
Widget().withCardPadding(),       // 添加卡片内边距
12.0.verticalSpace,              // 12px 垂直间距

// 工具类
SpacingUtils.spacedColumn(
  spacing: AppSpacing.md,
  children: [
    Widget1(),
    Widget2(),
    Widget3(),
  ],
)
```

### 5. 圆角使用

```dart
// 基础圆角
BorderRadius.circular(AppRadius.md)     // 8px
BorderRadius.circular(AppRadius.lg)     // 12px

// 预定义圆角
borderRadius: AppRadius.cardRadius,     // 卡片圆角
borderRadius: AppRadius.buttonRadius,   // 按钮圆角

// 特殊圆角
borderRadius: AppRadius.topRoundedRadius,    // 仅顶部圆角
borderRadius: AppRadius.bottomRoundedRadius, // 仅底部圆角

// 扩展方法
Widget().withCardRadius(),              // 添加卡片圆角
Widget().withButtonRadius(),            // 添加按钮圆角
8.0.radius,                            // 8px 圆角

// 工具类
RadiusUtils.roundedContainer(
  radius: AppRadius.lg,
  color: AppColors.primary,
  child: Widget(),
)
```

### 6. 阴影使用

```dart
// 基础阴影
boxShadow: AppShadows.sm,         // 小阴影
boxShadow: AppShadows.md,         // 中等阴影
boxShadow: AppShadows.lg,         // 大阴影

// 组件专用阴影
boxShadow: AppShadows.card,       // 卡片阴影
boxShadow: AppShadows.button,     // 按钮阴影
boxShadow: AppShadows.dialog,     // 对话框阴影

// 彩色阴影
boxShadow: AppShadows.primary,    // 主色阴影
boxShadow: AppShadows.success,    // 成功色阴影
boxShadow: AppShadows.error,      // 错误色阴影

// 主题适配
boxShadow: AppShadows.cardForTheme(brightness),

// 扩展方法
Widget().withCardShadow(),        // 添加卡片阴影
Widget().withPrimaryShadow(),     // 添加主色阴影
```

## 完整示例

### 自定义卡片组件

```dart
class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.title,
    required this.content,
    this.onTap,
  });

  final String title;
  final String content;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return RadiusUtils.roundedCard(
      radius: AppRadius.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.cardRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.h6.withPrimaryColor(),
            ),
            AppSpacing.vSm,
            Text(
              content,
              style: AppTypography.bodyMedium,
            ),
          ],
        ).withCardPadding(),
      ),
    ).withShadow(AppShadows.card);
  }
}
```

### 自定义按钮组件

```dart
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: AppRadius.buttonShape,
        padding: AppSpacing.button,
        elevation: 2,
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            )
          : Text(
              text,
              style: AppTypography.buttonMedium,
            ),
    );
  }
}
```

### 自定义输入框组件

```dart
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.obscureText = false,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: AppTypography.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: AppTypography.labelMedium.withPrimaryColor(),
        hintStyle: AppTypography.bodyMedium.withDisabledColor(
          Theme.of(context).brightness,
        ),
        filled: true,
        fillColor: AppColors.surfaceFor(Theme.of(context).brightness),
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(
            color: AppColors.borderFor(Theme.of(context).brightness),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        contentPadding: AppSpacing.input,
      ),
    );
  }
}
```

## 主题集成

新的主题系统已经集成了设计系统：

```dart
// 在 main.dart 中使用新主题
import 'package:your_app/core/services/theme/app_theme_v2.dart';

MaterialApp(
  theme: AppThemeV2.lightTheme,
  darkTheme: AppThemeV2.darkTheme,
  // ...
)
```

## 最佳实践

### 1. 颜色使用

- ✅ 优先使用设计系统中定义的颜色
- ✅ 使用语义化的颜色名称（如 `success`, `error`）
- ✅ 考虑暗色模式的适配
- ❌ 避免硬编码颜色值

### 2. 字体排版

- ✅ 使用预定义的文字样式
- ✅ 保持文字层级的一致性
- ✅ 使用扩展方法进行样式调整
- ❌ 避免随意设置字体大小和样式

### 3. 间距布局

- ✅ 使用设计系统的间距常量
- ✅ 保持间距的一致性和规律性
- ✅ 使用间距工具类简化布局
- ❌ 避免随意设置间距值

### 4. 圆角阴影

- ✅ 使用预定义的圆角和阴影
- ✅ 保持界面元素的视觉一致性
- ✅ 考虑不同组件的层级关系
- ❌ 避免过度使用装饰效果

## 响应式设计

设计系统支持响应式设计：

```dart
// 响应式间距
final spacing = AppSpacing.responsive(context);

// 响应式字体
final textStyle = ResponsiveTextStyle.responsive(
  context,
  AppTypography.bodyLarge,
);

// 响应式圆角
final radius = AppRadius.responsive(context);
```

## 自定义扩展

可以基于设计系统创建自定义组件：

```dart
// 扩展颜色系统
extension CustomColors on AppColors {
  static const Color brand = Color(0xFF6366F1);
  static const Color brandLight = Color(0xFF818CF8);
  static const Color brandDark = Color(0xFF4F46E5);
}

// 扩展字体系统
extension CustomTypography on AppTypography {
  static TextStyle get specialTitle => h3.copyWith(
    letterSpacing: 2.0,
    fontWeight: FontWeight.w900,
  );
}
```

## 调试和工具

### 设计系统演示页面

使用 `DesignSystemDemo` 组件查看所有设计系统元素：

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DesignSystemDemo(),
  ),
);
```

### 设计系统使用示例

查看 `DesignSystemExamples` 了解实际使用场景。

## 更新和维护

1. **版本控制** - 设计系统的修改应该谨慎进行
2. **向后兼容** - 尽量保持 API 的稳定性
3. **文档更新** - 修改时同步更新文档
4. **测试验证** - 确保修改不会破坏现有界面

## 总结

设计系统提供了构建一致、美观、可维护界面的基础。通过合理使用这些组件，可以：

- 🎨 **提升界面一致性** - 统一的视觉语言
- 🚀 **加速开发效率** - 预定义的组件和样式
- 🔧 **简化维护工作** - 集中化的样式管理
- 📱 **优化用户体验** - 专业的设计规范
- 🌙 **支持主题切换** - 完整的暗色模式支持

遵循设计系统的规范，可以构建出专业、一致、用户友好的应用界面。
