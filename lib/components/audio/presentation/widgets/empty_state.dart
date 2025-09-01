import 'package:flutter/cupertino.dart';
import '../../../../../base/theme/theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.music_note,
              size: 48,
              color: context.tertiaryTextColor,
            ),
            const SizedBox(height: 16),
            Text(
              '暂无歌曲数据',
              style: TextStyle(
                color: context.tertiaryTextColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
