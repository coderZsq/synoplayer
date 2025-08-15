import 'package:flutter/material.dart';
import '../index.dart';

/// 设计系统演示页面
/// 
/// 展示如何使用设计系统的各种组件
class DesignSystemDemo extends StatelessWidget {
  const DesignSystemDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设计系统演示',
          style: AppTypography.h6.withPrimaryColor(),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.page,
        child: SpacingUtils.spacedColumn(
          spacing: AppSpacing.sectionSpacing,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorSection(),
            _buildTypographySection(),
            _buildSpacingSection(),
            _buildRadiusSection(),
            _buildShadowSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '颜色系统',
          style: AppTypography.h4.withPrimaryColor(),
        ),
        AppSpacing.vMd,
        Text(
          '主要颜色',
          style: AppTypography.h6,
        ),
        AppSpacing.vSm,
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _buildColorTile('主色', AppColors.primary),
            _buildColorTile('次要色', AppColors.secondary),
            _buildColorTile('成功色', AppColors.success),
            _buildColorTile('警告色', AppColors.warning),
            _buildColorTile('错误色', AppColors.error),
            _buildColorTile('信息色', AppColors.info),
          ],
        ),
        AppSpacing.vMd,
        Text(
          '灰度色阶',
          style: AppTypography.h6,
        ),
        AppSpacing.vSm,
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _buildColorTile('Grey 50', AppColors.grey50),
            _buildColorTile('Grey 100', AppColors.grey100),
            _buildColorTile('Grey 300', AppColors.grey300),
            _buildColorTile('Grey 500', AppColors.grey500),
            _buildColorTile('Grey 700', AppColors.grey700),
            _buildColorTile('Grey 900', AppColors.grey900),
          ],
        ),
      ],
    );
  }

  Widget _buildColorTile(String name, Color color) {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.smRadius,
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: AppTypography.caption.withColor(color.contrastColor),
            textAlign: TextAlign.center,
          ),
          Text(
            color.toHex(),
            style: AppTypography.overline.withColor(color.contrastColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTypographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '字体排版',
          style: AppTypography.h4.withPrimaryColor(),
        ),
        AppSpacing.vMd,
        SpacingUtils.spacedColumn(
          spacing: AppSpacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('大标题 H1', style: AppTypography.h1),
            Text('中标题 H2', style: AppTypography.h2),
            Text('小标题 H3', style: AppTypography.h3),
            Text('子标题 H4', style: AppTypography.h4),
            Text('小子标题 H5', style: AppTypography.h5),
            Text('最小标题 H6', style: AppTypography.h6),
            Text('大正文', style: AppTypography.bodyLarge),
            Text('中等正文', style: AppTypography.bodyMedium),
            Text('小正文', style: AppTypography.bodySmall),
            Text('大标签', style: AppTypography.labelLarge),
            Text('中等标签', style: AppTypography.labelMedium),
            Text('小标签', style: AppTypography.labelSmall),
            Text('代码字体', style: AppTypography.code),
          ],
        ),
      ],
    );
  }

  Widget _buildSpacingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '间距系统',
          style: AppTypography.h4.withPrimaryColor(),
        ),
        AppSpacing.vMd,
        Text(
          '间距值展示',
          style: AppTypography.h6,
        ),
        AppSpacing.vSm,
        Column(
          children: [
            _buildSpacingDemo('XS (4px)', AppSpacing.xs),
            _buildSpacingDemo('SM (8px)', AppSpacing.sm),
            _buildSpacingDemo('MD (12px)', AppSpacing.md),
            _buildSpacingDemo('LG (16px)', AppSpacing.lg),
            _buildSpacingDemo('XL (20px)', AppSpacing.xl),
            _buildSpacingDemo('XXL (24px)', AppSpacing.xxl),
          ],
        ),
      ],
    );
  }

  Widget _buildSpacingDemo(String name, double spacing) {
    return Padding(
      padding: AppSpacing.verticalSm,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: AppTypography.labelMedium,
            ),
          ),
          Container(
            width: spacing,
            height: 20,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildRadiusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '圆角系统',
          style: AppTypography.h4.withPrimaryColor(),
        ),
        AppSpacing.vMd,
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            _buildRadiusDemo('无圆角', AppRadius.none),
            _buildRadiusDemo('XS (2px)', AppRadius.xs),
            _buildRadiusDemo('SM (4px)', AppRadius.sm),
            _buildRadiusDemo('MD (8px)', AppRadius.md),
            _buildRadiusDemo('LG (12px)', AppRadius.lg),
            _buildRadiusDemo('XL (16px)', AppRadius.xl),
            _buildRadiusDemo('圆形', AppRadius.circular),
          ],
        ),
      ],
    );
  }

  Widget _buildRadiusDemo(String name, double radius) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        AppSpacing.vXs,
        Text(
          name,
          style: AppTypography.caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildShadowSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '阴影系统',
          style: AppTypography.h4.withPrimaryColor(),
        ),
        AppSpacing.vMd,
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: [
            _buildShadowDemo('无阴影', AppShadows.none),
            _buildShadowDemo('XS 阴影', AppShadows.xs),
            _buildShadowDemo('SM 阴影', AppShadows.sm),
            _buildShadowDemo('MD 阴影', AppShadows.md),
            _buildShadowDemo('LG 阴影', AppShadows.lg),
            _buildShadowDemo('XL 阴影', AppShadows.xl),
          ],
        ),
        AppSpacing.vMd,
        Text(
          '彩色阴影',
          style: AppTypography.h6,
        ),
        AppSpacing.vSm,
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: [
            _buildShadowDemo('主色阴影', AppShadows.primary),
            _buildShadowDemo('成功阴影', AppShadows.success),
            _buildShadowDemo('警告阴影', AppShadows.warning),
            _buildShadowDemo('错误阴影', AppShadows.error),
          ],
        ),
      ],
    );
  }

  Widget _buildShadowDemo(String name, List<BoxShadow> shadows) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.mdRadius,
            boxShadow: shadows,
          ),
          child: Center(
            child: Text(
              'Card',
              style: AppTypography.labelMedium.withColor(AppColors.grey700),
            ),
          ),
        ),
        AppSpacing.vXs,
        Text(
          name,
          style: AppTypography.caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// 使用设计系统的示例组件
class DesignSystemExamples extends StatelessWidget {
  const DesignSystemExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设计系统使用示例',
          style: AppTypography.h6.withPrimaryColor(),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.page,
        child: SpacingUtils.spacedColumn(
          spacing: AppSpacing.componentSpacing,
          children: [
            _buildButtonExamples(),
            _buildCardExamples(),
            _buildFormExamples(),
            _buildChipExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonExamples() {
    return RadiusUtils.roundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '按钮示例',
            style: AppTypography.h6.withPrimaryColor(),
          ).withCardPadding(),
          AppSpacing.vMd,
          SpacingUtils.spacedColumn(
            spacing: AppSpacing.sm,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('主要按钮', style: AppTypography.buttonMedium),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text('次要按钮', style: AppTypography.buttonMedium),
              ),
              TextButton(
                onPressed: () {},
                child: Text('文本按钮', style: AppTypography.buttonMedium),
              ),
            ],
          ).withCardPadding(),
        ],
      ),
    );
  }

  Widget _buildCardExamples() {
    return RadiusUtils.roundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '卡片示例',
            style: AppTypography.h6.withPrimaryColor(),
          ),
          AppSpacing.vMd,
          Container(
            padding: AppSpacing.card,
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: AppRadius.cardRadius,
              boxShadow: AppShadows.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('卡片标题', style: AppTypography.h6),
                AppSpacing.vSm,
                Text(
                  '这是一个使用设计系统构建的卡片示例，具有统一的间距、圆角和阴影。',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ).withCardPadding(),
    );
  }

  Widget _buildFormExamples() {
    return RadiusUtils.roundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '表单示例',
            style: AppTypography.h6.withPrimaryColor(),
          ),
          AppSpacing.vMd,
          TextField(
            decoration: InputDecoration(
              labelText: '用户名',
              hintText: '请输入用户名',
              labelStyle: AppTypography.labelMedium,
              hintStyle: AppTypography.bodyMedium.withDisabledColor(Brightness.light),
            ),
          ),
          AppSpacing.vMd,
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '密码',
              hintText: '请输入密码',
              labelStyle: AppTypography.labelMedium,
              hintStyle: AppTypography.bodyMedium.withDisabledColor(Brightness.light),
            ),
          ),
        ],
      ).withCardPadding(),
    );
  }

  Widget _buildChipExamples() {
    return RadiusUtils.roundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '标签示例',
            style: AppTypography.h6.withPrimaryColor(),
          ),
          AppSpacing.vMd,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              Chip(
                label: Text('Flutter', style: AppTypography.labelSmall),
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              ),
              Chip(
                label: Text('Dart', style: AppTypography.labelSmall),
                backgroundColor: AppColors.success.withValues(alpha: 0.1),
              ),
              Chip(
                label: Text('Riverpod', style: AppTypography.labelSmall),
                backgroundColor: AppColors.warning.withValues(alpha: 0.1),
              ),
            ],
          ),
        ],
      ).withCardPadding(),
    );
  }
}
