import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/logger.dart';

part 'error_handler.g.dart';

/// 错误类型枚举
enum ErrorType {
  network,      // 网络错误
  validation,   // 验证错误
  authentication, // 认证错误
  server,       // 服务器错误
  unknown,      // 未知错误
}

/// 应用错误类
class AppError {
  const AppError({
    required this.message,
    required this.type,
    this.details,
    this.stackTrace,
  });

  final String message;
  final ErrorType type;
  final String? details;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'AppError(type: $type, message: $message${details != null ? ', details: $details' : ''})';
  }
}

/// 全局错误处理器
@riverpod
class GlobalErrorHandler extends _$GlobalErrorHandler {
  @override
  void build() {
    // 初始化错误处理器
    AppLogger.info('Global error handler initialized');
  }

  /// 处理错误
  void handleError(Object error, StackTrace? stackTrace) {
    // 记录错误日志
    AppLogger.error('Global error occurred', error: error, stackTrace: stackTrace);
    
    // 转换为应用错误
    final appError = _convertToAppError(error, stackTrace);
    
    // 根据错误类型处理
    _handleErrorByType(appError);
  }

  /// 将错误转换为应用错误
  AppError _convertToAppError(Object error, StackTrace? stackTrace) {
    if (error is AppError) {
      return error;
    }

    // 根据错误类型进行分类
    if (error.toString().contains('NetworkException') ||
        error.toString().contains('SocketException') ||
        error.toString().contains('TimeoutException')) {
      return AppError(
        message: '网络连接失败',
        type: ErrorType.network,
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }

    if (error.toString().contains('ValidationException') ||
        error.toString().contains('FormatException')) {
      return AppError(
        message: '数据格式错误',
        type: ErrorType.validation,
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }

    if (error.toString().contains('AuthException') ||
        error.toString().contains('Unauthorized')) {
      return AppError(
        message: '认证失败',
        type: ErrorType.authentication,
        details: error.toString(),
        stackTrace: stackTrace,
      );
    }

    return AppError(
      message: '发生未知错误',
      type: ErrorType.unknown,
      details: error.toString(),
      stackTrace: stackTrace,
    );
  }

  /// 根据错误类型处理
  void _handleErrorByType(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        _handleNetworkError(error);
        break;
      case ErrorType.validation:
        _handleValidationError(error);
        break;
      case ErrorType.authentication:
        _handleAuthenticationError(error);
        break;
      case ErrorType.server:
        _handleServerError(error);
        break;
      case ErrorType.unknown:
        _handleUnknownError(error);
        break;
    }
  }

  /// 处理网络错误
  void _handleNetworkError(AppError error) {
    AppLogger.warning('Network error: ${error.message}');
    // TODO: 显示网络错误提示
    // TODO: 尝试重连或降级处理
  }

  /// 处理验证错误
  void _handleValidationError(AppError error) {
    AppLogger.warning('Validation error: ${error.message}');
    // TODO: 显示验证错误提示
    // TODO: 高亮相关输入字段
  }

  /// 处理认证错误
  void _handleAuthenticationError(AppError error) {
    AppLogger.warning('Authentication error: ${error.message}');
    // TODO: 清除认证状态
    // TODO: 跳转到登录页
  }

  /// 处理服务器错误
  void _handleServerError(AppError error) {
    AppLogger.error('Server error: ${error.message}');
    // TODO: 显示服务器错误提示
    // TODO: 提供重试选项
  }

  /// 处理未知错误
  void _handleUnknownError(AppError error) {
    AppLogger.error('Unknown error: ${error.message}');
    // TODO: 显示通用错误提示
    // TODO: 收集错误信息用于调试
  }
}

/// 错误边界 Widget
class ErrorBoundary extends StatefulWidget {
  const ErrorBoundary({
    super.key,
    required this.child,
    this.onError,
    this.errorWidget,
  });

  final Widget child;
  final Function(AppError error)? onError;
  final Widget Function(AppError error)? errorWidget;

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> with WidgetsBindingObserver {
  AppError? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorWidget?.call(_error!) ?? _DefaultErrorWidget(
        error: _error!,
        onRetry: _resetError,
      );
    }

    return widget.child;
  }

  void _resetError() {
    setState(() {
      _error = null;
    });
  }

  @override
  void initState() {
    super.initState();
    // 设置错误处理器
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

/// 默认错误显示组件
class _DefaultErrorWidget extends StatelessWidget {
  const _DefaultErrorWidget({
    required this.error,
    required this.onRetry,
  });

  final AppError error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getErrorIcon(error.type),
                size: 64,
                color: _getErrorColor(error.type, theme),
              ),
              const SizedBox(height: 24),
              Text(
                _getErrorTitle(error.type),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                error.message,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (error.details != null) ...[
                const SizedBox(height: 8),
                Text(
                  error.details!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getErrorIcon(ErrorType type) {
    return switch (type) {
      ErrorType.network => Icons.wifi_off,
      ErrorType.validation => Icons.error_outline,
      ErrorType.authentication => Icons.lock_outline,
      ErrorType.server => Icons.dns,
      ErrorType.unknown => Icons.help_outline,
    };
  }

  String _getErrorTitle(ErrorType type) {
    return switch (type) {
      ErrorType.network => '网络连接失败',
      ErrorType.validation => '数据验证错误',
      ErrorType.authentication => '认证失败',
      ErrorType.server => '服务器错误',
      ErrorType.unknown => '未知错误',
    };
  }

  Color _getErrorColor(ErrorType type, ThemeData theme) {
    return switch (type) {
      ErrorType.network => Colors.orange,
      ErrorType.validation => Colors.amber,
      ErrorType.authentication => Colors.red,
      ErrorType.server => Colors.red,
      ErrorType.unknown => Colors.grey,
    };
  }
}
