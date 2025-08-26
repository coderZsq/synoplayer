import 'package:flutter/cupertino.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(),
          SizedBox(height: 16),
          Text('正在加载歌曲列表...'),
        ],
      ),
    );
  }
}
