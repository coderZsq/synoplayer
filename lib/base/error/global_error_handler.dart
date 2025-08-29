import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'exceptions.dart';
import 'error_mapper.dart';
import '../utils/logger.dart';

/// 全局错误处理服务
class GlobalErrorHandler {
  static final GlobalErrorHandler _instance = GlobalErrorHandler._internal();
  factory GlobalErrorHandler() => _instance;
  GlobalErrorHandler._internal();

  /// 错误处理器列表
  final List<ErrorHandler> _handlers = [];
  
  /// 错误监听器列表
  final List<ErrorListener> _listeners = [];
  
  /// 是否已初始化
  bool _initialized = false;

  /// 初始化全局错误处理
  void initialize() {
    if (_initialized) return;
    
    // 设置 Flutter 错误处理
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };
    
    // 设置 Zone 错误处理
    PlatformDispatcher.instance.onError = (error, stack) {
      _handleZoneError(error, stack);
      return true;
    };
    
    _initialized = true;
    Logger.info('GlobalErrorHandler initialized', tag: 'GlobalErrorHandler');
  }

  /// 添加错误处理器
  void addHandler(ErrorHandler handler) {
    _handlers.add(handler);
  }

  /// 移除错误处理器
  void removeHandler(ErrorHandler handler) {
    _handlers.remove(handler);
  }

  /// 添加错误监听器
  void addListener(ErrorListener listener) {
    _listeners.add(listener);
  }

  /// 移除错误监听器
  void removeListener(ErrorListener listener) {
    _listeners.remove(listener);
  }

  /// 处理错误
  void handleError(dynamic error, StackTrace? stackTrace) {
    final trace = stackTrace ?? StackTrace.current;
    
    // 通知所有监听器
    for (final listener in _listeners) {
      try {
        listener.onError(error, trace);
      } catch (e) {
        Logger.error('Error in error listener: $e', tag: 'GlobalErrorHandler');
      }
    }
    
    // 执行所有处理器
    for (final handler in _handlers) {
      try {
        handler.handleError(error, trace);
      } catch (e) {
        Logger.error('Error in error handler: $e', tag: 'GlobalErrorHandler');
      }
    }
    
    // 记录错误
    _logError(error, trace);
  }

  /// 处理 Flutter 错误
  void _handleFlutterError(FlutterErrorDetails details) {
    Logger.error('Flutter Error: ${details.exception}', tag: 'GlobalErrorHandler');
    Logger.error('Stack Trace: ${details.stack}', tag: 'GlobalErrorHandler');
    
    handleError(details.exception, details.stack);
  }

  /// 处理 Zone 错误
  void _handleZoneError(dynamic error, StackTrace stackTrace) {
    Logger.error('Zone Error: $error', tag: 'GlobalErrorHandler');
    Logger.error('Stack Trace: $stackTrace', tag: 'GlobalErrorHandler');
    
    handleError(error, stackTrace);
  }

  /// 记录错误
  void _logError(dynamic error, StackTrace stackTrace) {
    // TODO: 集成日志系统
    Logger.error('=== Global Error Handler ===', tag: 'GlobalErrorHandler');
    Logger.error('Error: $error', tag: 'GlobalErrorHandler');
    Logger.error('Type: ${error.runtimeType}', tag: 'GlobalErrorHandler');
    Logger.error('Message: ${ErrorMapper.mapToUserMessage(error)}', tag: 'GlobalErrorHandler');
    Logger.error('Stack Trace: $stackTrace', tag: 'GlobalErrorHandler');
    Logger.error('===========================', tag: 'GlobalErrorHandler');
  }

  /// 清理资源
  void dispose() {
    _handlers.clear();
    _listeners.clear();
    _initialized = false;
  }
}

/// 错误处理器接口
abstract class ErrorHandler {
  void handleError(dynamic error, StackTrace stackTrace);
}

/// 错误监听器接口
abstract class ErrorListener {
  void onError(dynamic error, StackTrace stackTrace);
}

/// 默认错误处理器 - 记录到控制台
class ConsoleErrorHandler implements ErrorHandler {
  @override
  void handleError(dynamic error, StackTrace stackTrace) {
    Logger.error('ConsoleErrorHandler: $error', tag: 'ConsoleErrorHandler');
    Logger.error('Stack Trace: $stackTrace', tag: 'ConsoleErrorHandler');
  }
}

/// 网络错误处理器 - 特殊处理网络相关错误
class NetworkErrorHandler implements ErrorHandler {
  @override
  void handleError(dynamic error, StackTrace stackTrace) {
    if (ErrorMapper.isNetworkError(error)) {
      Logger.network('Network Error Handler: $error', tag: 'NetworkErrorHandler');
      // TODO: 可以在这里添加网络状态检查、重连逻辑等
    }
  }
}

/// 认证错误处理器 - 特殊处理认证相关错误
class AuthErrorHandler implements ErrorHandler {
  @override
  void handleError(dynamic error, StackTrace stackTrace) {
    if (ErrorMapper.isAuthError(error)) {
      Logger.error('Auth Error Handler: $error', tag: 'AuthErrorHandler');
      // TODO: 可以在这里添加自动登出、重新认证等逻辑
    }
  }
}

/// 业务错误处理器 - 特殊处理业务逻辑错误
class BusinessErrorHandler implements ErrorHandler {
  @override
  void handleError(dynamic error, StackTrace stackTrace) {
    if (error is BusinessException) {
      Logger.error('Business Error Handler: $error', tag: 'BusinessErrorHandler');
      // TODO: 可以在这里添加业务错误统计、上报等逻辑
    }
  }
}

/// 全局错误处理 Provider
final globalErrorHandlerProvider = Provider<GlobalErrorHandler>((ref) {
  final handler = GlobalErrorHandler();
  
  // 添加默认错误处理器
  handler.addHandler(ConsoleErrorHandler());
  handler.addHandler(NetworkErrorHandler());
  handler.addHandler(AuthErrorHandler());
  handler.addHandler(BusinessErrorHandler());
  
  // 初始化
  handler.initialize();
  
  // 当 Provider 被销毁时清理资源
  ref.onDispose(() {
    handler.dispose();
  });
  
  return handler;
});

/// 错误边界状态 Provider
final globalErrorStateProvider = StateProvider<GlobalErrorState>((ref) {
  return const GlobalErrorState();
});

/// 全局错误状态
class GlobalErrorState {
  final bool hasError;
  final dynamic lastError;
  final StackTrace? lastStackTrace;
  final DateTime? lastErrorTime;

  const GlobalErrorState({
    this.hasError = false,
    this.lastError,
    this.lastStackTrace,
    this.lastErrorTime,
  });

  GlobalErrorState copyWith({
    bool? hasError,
    dynamic lastError,
    StackTrace? lastStackTrace,
    DateTime? lastErrorTime,
  }) {
    return GlobalErrorState(
      hasError: hasError ?? this.hasError,
      lastError: lastError ?? this.lastError,
      lastStackTrace: lastStackTrace ?? this.lastStackTrace,
      lastErrorTime: lastErrorTime ?? this.lastErrorTime,
    );
  }
}

/// 全局错误边界 Widget
class GlobalErrorBoundary extends ConsumerWidget {
  final Widget child;
  final Widget Function(dynamic error, StackTrace? stackTrace)? errorBuilder;

  const GlobalErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorState = ref.watch(globalErrorStateProvider);
    
    if (!errorState.hasError) {
      return child;
    }

    if (errorBuilder != null) {
      return errorBuilder!(errorState.lastError, errorState.lastStackTrace);
    }

    return _DefaultGlobalErrorDisplay(
      error: errorState.lastError,
      stackTrace: errorState.lastStackTrace,
      onRetry: () {
        ref.read(globalErrorStateProvider.notifier).state = 
            ref.read(globalErrorStateProvider).copyWith(hasError: false);
      },
    );
  }
}

/// 默认全局错误显示组件
class _DefaultGlobalErrorDisplay extends StatelessWidget {
  final dynamic error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;

  const _DefaultGlobalErrorDisplay({
    this.error,
    this.stackTrace,
    this.onRetry,
  });

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
                  '应用出现错误',
                  style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
                ),
                const SizedBox(height: 16),
                Text(
                  ErrorMapper.mapToUserMessage(error),
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                  textAlign: TextAlign.center,
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 32),
                  CupertinoButton.filled(
                    onPressed: onRetry,
                    child: const Text('重试'),
                  ),
                ],
                const SizedBox(height: 16),
                CupertinoButton(
                  onPressed: () {
                    // 显示详细错误信息
                    _showErrorDetails(context);
                  },
                  child: const Text('查看详情'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDetails(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('错误详情'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('错误类型: ${ErrorMapper.getErrorTypeDescription(error)}'),
              if (ErrorMapper.getErrorCode(error) != null) 
                Text('错误代码: ${ErrorMapper.getErrorCode(error)}'),
              Text('错误消息: ${ErrorMapper.mapToUserMessage(error)}'),
              if (stackTrace != null) ...[
                const SizedBox(height: 8),
                const Text('堆栈跟踪:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  stackTrace.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}
