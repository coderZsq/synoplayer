import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synoplayer/core/di/injection.dart';
import 'package:synoplayer/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化依赖注入
  await setupDependencies();
  
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          // 设置路由器的 Riverpod 引用
          AppRouter.setRef(ref);
          
          return CupertinoApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    ),
  );
}