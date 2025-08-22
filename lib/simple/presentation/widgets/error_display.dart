import 'package:flutter/cupertino.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorDisplay({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: CupertinoColors.systemRed.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                color: CupertinoColors.systemRed,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '登录失败',
                  style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.systemRed,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              onPressed: onRetry,
              child: const Text('重试'),
            ),
          ),
        ],
      ),
    );
  }
}
