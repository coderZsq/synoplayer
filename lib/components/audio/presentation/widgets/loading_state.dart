import 'package:flutter/cupertino.dart';
import '../../../../../base/theme/theme.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(),
            const SizedBox(height: 16),
            Text(
              '正在加载歌曲列表...',
              style: TextStyle(color: context.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
