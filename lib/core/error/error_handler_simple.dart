import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'exceptions.dart';

/// 简化的错误处理工具类
class SimpleErrorHandler {
  /// 显示错误提示
  static void showError(BuildContext context, dynamic error) {
    final message = _getErrorMessage(error);
    
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('错误'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 显示重试对话框
  static Future<bool> showRetryDialog(
    BuildContext context, 
    dynamic error, {
    String? title,
    String? message,
  }) async {
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title ?? '操作失败'),
        content: Text(message ?? _getErrorMessage(error)),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          CupertinoButton.filled(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('重试'),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }

  /// 获取错误消息
  static String _getErrorMessage(dynamic error) {
    if (error is AppException) {
      return error.message;
    }
    
    if (error is String) {
      return error;
    }
    
    return error.toString();
  }

  /// 判断是否为可重试的错误
  static bool isRetryableError(dynamic error) {
    if (error is NetworkException) return true;
    
    if (error is ServerException) return true;
    
    if (error is String) {
      final errorString = error.toLowerCase();
      return errorString.contains('network') || 
             errorString.contains('timeout') ||
             errorString.contains('server');
    }
    
    return false;
  }

  /// 安全执行操作
  static Future<T?> safeExecute<T>(
    Future<T> Function() operation,
    BuildContext context, {
    String? errorTitle,
    String? errorMessage,
    bool showErrorDialog = true,
  }) async {
    try {
      return await operation();
    } catch (e) {
      if (showErrorDialog) {
        showError(context, e);
      }
      return null;
    }
  }

  /// 带重试的操作执行
  static Future<T?> executeWithRetry<T>(
    Future<T> Function() operation,
    BuildContext context, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
    String? errorTitle,
    String? errorMessage,
  }) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        return await operation();
      } catch (e) {
        attempts++;
        
        if (attempts >= maxRetries) {
          // 达到最大重试次数，显示错误
          SimpleErrorHandler.showError(context, e);
          return null;
        }
        
        // 询问是否重试
        final shouldRetry = await SimpleErrorHandler.showRetryDialog(
          context, 
          e,
          title: errorTitle ?? '操作失败',
          message: errorMessage ?? '是否重试？',
        );
        
        if (!shouldRetry) {
          return null;
        }
        
        // 等待延迟时间
        await Future.delayed(delay * attempts);
      }
    }
    
    return null;
  }
}

/// 错误边界 Provider
final errorBoundaryProvider = StateProvider<bool>((ref) => false);

/// 错误边界 Widget
class SimpleErrorBoundary extends ConsumerWidget {
  final Widget child;
  final Widget Function(dynamic error)? errorBuilder;

  const SimpleErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasError = ref.watch(errorBoundaryProvider);
    
    if (!hasError) {
      return child;
    }

    if (errorBuilder != null) {
      return errorBuilder!(Exception('应用出现错误'));
    }

    return _DefaultErrorDisplay(
      onRetry: () => ref.read(errorBoundaryProvider.notifier).state = false,
    );
  }
}

/// 默认错误显示组件
class _DefaultErrorDisplay extends StatelessWidget {
  final VoidCallback? onRetry;

  const _DefaultErrorDisplay({this.onRetry});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.exclamationmark_triangle,
                  size: 64,
                  color: CupertinoColors.systemRed,
                ),
                const SizedBox(height: 24),
                Text(
                  '出现错误',
                  style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
                ),
                const SizedBox(height: 16),
                const Text(
                  '应用遇到了一个错误，请重试',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 32),
                  CupertinoButton.filled(
                    onPressed: onRetry,
                    child: const Text('重试'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
