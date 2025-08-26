import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synoplayer/base/router/app_router.dart';
import 'package:synoplayer/base/error/global_error_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          // 获取全局错误处理服务（确保初始化）
          ref.read(globalErrorHandlerProvider);
          
          return GlobalErrorBoundary(
            child: CupertinoApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    ),
  );
}