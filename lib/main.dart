import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synoplayer/base/router/app_router.dart';
import 'package:synoplayer/base/error/global_error_handler.dart';
import 'package:synoplayer/base/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          // 获取全局错误处理服务（确保初始化）
          ref.read(globalErrorHandlerProvider);
          
          // 监听主题变化
          final currentTheme = ref.watch(currentThemeProvider);
          
          return GlobalErrorBoundary(
            child: CupertinoApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              theme: currentTheme,
            ),
          );
        },
      ),
    ),
  );
}