import 'package:flutter/cupertino.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.music_note,
            size: 48,
            color: CupertinoColors.systemGrey,
          ),
          SizedBox(height: 16),
          Text(
            '暂无歌曲数据',
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
