import 'package:flutter/cupertino.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(
          CupertinoIcons.globe,
          size: 64,
          color: CupertinoColors.activeBlue,
        ),
        const SizedBox(height: 16),
        Text(
          'Synology 登录',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '请输入您的 QuickConnect 信息',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            color: CupertinoColors.systemGrey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
