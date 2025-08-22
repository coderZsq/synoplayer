import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synoplayer/login/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: CupertinoApp(
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}