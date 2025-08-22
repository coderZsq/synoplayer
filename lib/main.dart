import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synoplayer/login/pages/login_page.dart';
import 'package:synoplayer/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化依赖注入
  await setupDependencies();
  
  runApp(
    const ProviderScope(
      child: CupertinoApp(
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}