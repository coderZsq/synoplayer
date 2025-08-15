import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../design_system/index.dart';

/// 应用主题配置（使用设计系统）
class AppThemeV2 {
  
  /// 亮色主题
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightSurface,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.lightTextPrimary,
      onError: AppColors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      
      // 文本主题
      textTheme: AppTextTheme.getTextTheme(Brightness.light),
      
      // AppBar 主题
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: AppTypography.h6.withColor(colorScheme.onSurface),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        shadowColor: AppColors.blackWithOpacity(0.1),
      ),
      
      // Card 主题
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 2,
        shadowColor: AppColors.blackWithOpacity(0.1),
        shape: AppRadius.cardShape,
        margin: AppSpacing.allSm,
      ),
      
      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: AppRadius.buttonShape,
          padding: AppSpacing.button,
          textStyle: AppTypography.buttonMedium,
          shadowColor: AppColors.blackWithOpacity(0.2),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
          shape: AppRadius.buttonShape,
          padding: AppSpacing.button,
          textStyle: AppTypography.buttonMedium,
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: AppRadius.buttonShape,
          padding: AppSpacing.smallButton,
          textStyle: AppTypography.buttonMedium,
        ),
      ),
      
      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: AppSpacing.input,
        labelStyle: AppTypography.labelMedium.withSecondaryColor(Brightness.light),
        hintStyle: AppTypography.bodyMedium.withDisabledColor(Brightness.light),
      ),
      
      // 图标主题
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: 24,
      ),
      
      // 芯片主题
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.grey100,
        labelStyle: AppTypography.labelSmall.withColor(AppColors.lightTextPrimary),
        secondaryLabelStyle: AppTypography.labelSmall.withColor(AppColors.white),
        selectedColor: AppColors.primary,
        disabledColor: AppColors.grey300,
        shape: AppRadius.chipShape,
        side: BorderSide(color: AppColors.lightBorder),
        padding: AppSpacing.horizontalSm,
      ),
      
      // 浮动操作按钮主题
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 6,
        shape: const CircleBorder(),
      ),
      
      // 底部导航栏主题
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: AppTypography.labelSmall.withPrimaryColor(),
        unselectedLabelStyle: AppTypography.labelSmall.withSecondaryColor(Brightness.light),
      ),
      
      // 对话框主题
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: AppRadius.dialogShape,
        elevation: 24,
        titleTextStyle: AppTypography.h6.withColor(colorScheme.onSurface),
        contentTextStyle: AppTypography.bodyMedium.withColor(colorScheme.onSurface),
      ),
      
      // 底部弹窗主题
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.bottomSheetRadius,
        ),
        elevation: 16,
      ),
      
      // 应用栏主题
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 3,
        height: 60,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.labelSmall.withPrimaryColor();
          }
          return AppTypography.labelSmall.withSecondaryColor(Brightness.light);
        }),
      ),
      
      // 分割线主题
      dividerTheme: DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
        space: AppSpacing.md,
      ),
    );
  }
  
  /// 暗黑主题
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondaryLight,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onSurface: AppColors.darkTextPrimary,
      onError: AppColors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      
      // 文本主题
      textTheme: AppTextTheme.getTextTheme(Brightness.dark),
      
      // AppBar 主题
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: AppTypography.h6.withColor(colorScheme.onSurface),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        shadowColor: AppColors.blackWithOpacity(0.3),
      ),
      
      // Card 主题
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 4,
        shadowColor: AppColors.blackWithOpacity(0.3),
        shape: AppRadius.cardShape,
        margin: AppSpacing.allSm,
      ),
      
      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: AppRadius.buttonShape,
          padding: AppSpacing.button,
          textStyle: AppTypography.buttonMedium,
          shadowColor: AppColors.blackWithOpacity(0.4),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
          shape: AppRadius.buttonShape,
          padding: AppSpacing.button,
          textStyle: AppTypography.buttonMedium,
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: AppRadius.buttonShape,
          padding: AppSpacing.smallButton,
          textStyle: AppTypography.buttonMedium,
        ),
      ),
      
      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: AppSpacing.input,
        labelStyle: AppTypography.labelMedium.withSecondaryColor(Brightness.dark),
        hintStyle: AppTypography.bodyMedium.withDisabledColor(Brightness.dark),
      ),
      
      // 图标主题
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: 24,
      ),
      
      // 芯片主题
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.grey800,
        labelStyle: AppTypography.labelSmall.withColor(AppColors.darkTextPrimary),
        secondaryLabelStyle: AppTypography.labelSmall.withColor(AppColors.white),
        selectedColor: AppColors.primary,
        disabledColor: AppColors.grey600,
        shape: AppRadius.chipShape,
        side: BorderSide(color: AppColors.darkBorder),
        padding: AppSpacing.horizontalSm,
      ),
      
      // 浮动操作按钮主题
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 6,
        shape: const CircleBorder(),
      ),
      
      // 底部导航栏主题
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: AppTypography.labelSmall.withPrimaryColor(),
        unselectedLabelStyle: AppTypography.labelSmall.withSecondaryColor(Brightness.dark),
      ),
      
      // 对话框主题
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: AppRadius.dialogShape,
        elevation: 24,
        titleTextStyle: AppTypography.h6.withColor(colorScheme.onSurface),
        contentTextStyle: AppTypography.bodyMedium.withColor(colorScheme.onSurface),
      ),
      
      // 底部弹窗主题
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.bottomSheetRadius,
        ),
        elevation: 16,
      ),
      
      // 应用栏主题
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 3,
        height: 60,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.labelSmall.withPrimaryColor();
          }
          return AppTypography.labelSmall.withSecondaryColor(Brightness.dark);
        }),
      ),
      
      // 分割线主题
      dividerTheme: DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
        space: AppSpacing.md,
      ),
    );
  }
}
