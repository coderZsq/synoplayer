import 'package:flutter/cupertino.dart';
import '../error/error_mapper.dart';

/// 全局错误展示帮助类
class ErrorDisplayHelper {
  /// 显示错误对话框
  static void showError(
    BuildContext context, 
    dynamic error, {
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    if (!context.mounted) return;
    
    final message = ErrorMapper.mapToUserMessage(error);
    final isNetworkError = ErrorMapper.isNetworkError(error);
    final isAuthError = ErrorMapper.isAuthError(error);
    
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        // 自动关闭对话框
        if (duration != null) {
          Future.delayed(duration, () {
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop();
              onDismiss?.call();
            }
          });
        }
        
        return CupertinoAlertDialog(
          title: Text(_getErrorTitle(isNetworkError, isAuthError)),
          content: Text(message),
          actions: duration == null ? [
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onDismiss?.call();
              },
            ),
          ] : [],
        );
      },
    );
  }
  
  /// 显示成功消息
  static void showSuccess(
    BuildContext context, 
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    if (!context.mounted) return;
    
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        Future.delayed(duration, () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });
        
        return CupertinoAlertDialog(
          title: const Text('成功'),
          content: Text(message),
          actions: const [],
        );
      },
    );
  }
  
  /// 显示确认对话框
  static Future<bool> showConfirmDialog(
    BuildContext context,
    String title,
    String message, {
    String confirmText = '确定',
    String cancelText = '取消',
  }) async {
    if (!context.mounted) return false;
    
    return await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text(cancelText),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(confirmText),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    ) ?? false;
  }
  
  /// 显示加载对话框
  static void showLoading(
    BuildContext context,
    String message, {
    bool barrierDismissible = false,
  }) {
    if (!context.mounted) return;
    
    showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CupertinoActivityIndicator(),
              const SizedBox(height: 16),
              Text(message),
            ],
          ),
        );
      },
    );
  }
  
  /// 隐藏对话框
  static void hideDialog(BuildContext context) {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
  
  /// 根据错误类型获取标题
  static String _getErrorTitle(bool isNetworkError, bool isAuthError) {
    if (isAuthError) {
      return '认证失败';
    } else if (isNetworkError) {
      return '网络错误';
    } else {
      return '操作失败';
    }
  }
}
