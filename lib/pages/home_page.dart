import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('📱 HomePage is being built');
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('🏠 主页'),
        backgroundColor: CupertinoColors.systemBackground,
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.home,
                size: 100,
                color: CupertinoColors.systemBlue,
              ),
              SizedBox(height: 20),
              Text(
                '🎉 登录成功！',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '欢迎来到主页',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
