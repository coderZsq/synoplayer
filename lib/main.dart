import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synoplayer/core/router/app_router.dart';
import 'package:synoplayer/core/error/global_error_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          // 设置路由器的 Riverpod 引用
          AppRouter.setRef(ref);
          
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