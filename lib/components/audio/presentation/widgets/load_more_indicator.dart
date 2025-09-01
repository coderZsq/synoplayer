import 'package:flutter/cupertino.dart';
import '../../../../../base/theme/theme.dart';

class LoadMoreIndicator extends StatelessWidget {
  final bool isLoading;
  final bool hasMoreData;

  const LoadMoreIndicator({
    super.key,
    required this.isLoading,
    required this.hasMoreData,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasMoreData) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            '没有更多数据了',
            style: TextStyle(
              color: context.tertiaryTextColor,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: isLoading
            ? const CupertinoActivityIndicator()
            : Text(
                '上拉加载更多',
                style: TextStyle(
                  color: context.tertiaryTextColor,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}
