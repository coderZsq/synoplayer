import 'package:flutter/cupertino.dart';
import '../error/result.dart';
import '../error/exceptions.dart';
import '../error/error_handler_simple.dart';

/// Result 处理器组件，用于在 UI 中处理 Result 类型的结果
class ResultHandler<T> extends StatelessWidget {
  final Result<T> result;
  final Widget Function(T data) onSuccess;
  final Widget Function(AppException error)? onFailure;
  final Widget? onLoading;
  final bool showErrorDialog;
  final VoidCallback? onRetry;

  const ResultHandler({
    super.key,
    required this.result,
    required this.onSuccess,
    this.onFailure,
    this.onLoading,
    this.showErrorDialog = true,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return result.fold(
      (data) => onSuccess(data),
      (error) {
        if (showErrorDialog) {
          // 延迟显示错误对话框，避免在 build 中直接调用
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SimpleErrorHandler.showError(context, error);
          });
        }
        
        if (onFailure != null) {
          return onFailure!(error);
        }
        
        return _DefaultErrorWidget(
          error: error,
          onRetry: onRetry,
        );
      },
    );
  }
}

/// 默认错误显示组件
class _DefaultErrorWidget extends StatelessWidget {
  final AppException error;
  final VoidCallback? onRetry;

  const _DefaultErrorWidget({
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
              '操作失败',
              style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
            const SizedBox(height: 16),
            Text(
              error.message,
              style: const TextStyle(fontSize: 16),
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
    );
  }
}

/// 异步 Result 处理器，支持加载状态
class AsyncResultHandler<T> extends StatelessWidget {
  final Future<Result<T>> future;
  final Widget Function(T data) onSuccess;
  final Widget Function(AppException error)? onFailure;
  final Widget? onLoading;
  final bool showErrorDialog;
  final VoidCallback? onRetry;

  const AsyncResultHandler({
    super.key,
    required this.future,
    required this.onSuccess,
    this.onFailure,
    this.onLoading,
    this.showErrorDialog = true,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return onLoading ?? const _DefaultLoadingWidget();
        }
        
        if (snapshot.hasError) {
          final error = snapshot.error is AppException 
              ? snapshot.error as AppException 
              : ServerException('操作失败: ${snapshot.error}');
          
          if (showErrorDialog) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SimpleErrorHandler.showError(context, error);
            });
          }
          
          if (onFailure != null) {
            return onFailure!(error);
          }
          
          return _DefaultErrorWidget(
            error: error,
            onRetry: onRetry,
          );
        }
        
        if (snapshot.hasData) {
          final result = snapshot.data!;
          return ResultHandler<T>(
            result: result,
            onSuccess: onSuccess,
            onFailure: onFailure,
            showErrorDialog: showErrorDialog,
            onRetry: onRetry,
          );
        }
        
        return const _DefaultLoadingWidget();
      },
    );
  }
}

/// 默认加载组件
class _DefaultLoadingWidget extends StatelessWidget {
  const _DefaultLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}

/// Result 状态监听器，用于在 Provider 中监听 Result 状态
class ResultListener<T> extends StatelessWidget {
  final Result<T>? result;
  final Widget Function(T data) onSuccess;
  final Widget Function(AppException error)? onFailure;
  final Widget? onLoading;
  final bool showErrorDialog;
  final VoidCallback? onRetry;

  const ResultListener({
    super.key,
    this.result,
    required this.onSuccess,
    this.onFailure,
    this.onLoading,
    this.showErrorDialog = true,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return onLoading ?? const _DefaultLoadingWidget();
    }
    
    return ResultHandler<T>(
      result: result!,
      onSuccess: onSuccess,
      onFailure: onFailure,
      showErrorDialog: showErrorDialog,
      onRetry: onRetry,
    );
  }
}
