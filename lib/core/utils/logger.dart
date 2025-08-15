import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// 应用日志工具类
class AppLogger {
  static const String _defaultTag = 'App';

  /// 信息日志
  static void info(String message, {String? tag}) {
    _log(message, tag: tag ?? _defaultTag, level: LogLevel.info);
  }

  /// 调试日志
  static void debug(String message, {String? tag}) {
    _log(message, tag: tag ?? _defaultTag, level: LogLevel.debug);
  }

  /// 警告日志
  static void warning(String message, {String? tag}) {
    _log(message, tag: tag ?? _defaultTag, level: LogLevel.warning);
  }

  /// 错误日志
  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(message, tag: tag ?? _defaultTag, level: LogLevel.error);
    if (error != null) {
      _log('Error details: $error', tag: tag ?? _defaultTag, level: LogLevel.error);
    }
    if (stackTrace != null) {
      _log('Stack trace: $stackTrace', tag: tag ?? _defaultTag, level: LogLevel.error);
    }
  }

  /// 成功日志
  static void success(String message, {String? tag}) {
    _log('✅ $message', tag: tag ?? _defaultTag, level: LogLevel.info);
  }

  /// 网络请求日志
  static void network(String message, {String? tag}) {
    _log('🌐 $message', tag: tag ?? _defaultTag, level: LogLevel.info);
  }

  /// 用户操作日志
  static void userAction(String message, {String? tag}) {
    _log('👤 $message', tag: tag ?? _defaultTag, level: LogLevel.info);
  }

  /// 性能日志
  static void performance(String message, int durationMs, {String? tag}) {
    final emoji = durationMs > 1000 ? '🐌' : durationMs > 500 ? '⚡' : '🚀';
    _log('$emoji $message (${durationMs}ms)', tag: tag ?? _defaultTag, level: LogLevel.info);
  }

  /// 内部日志方法
  static void _log(String message, {required String tag, required LogLevel level}) {
    if (!kDebugMode && level == LogLevel.debug) {
      return; // 在发布模式下不输出调试日志
    }

    final timestamp = DateTime.now().toIso8601String();
    final formattedMessage = '[$timestamp] [$tag] $message';

    // 在调试模式下使用 print 输出到控制台
    if (kDebugMode) {
      print(formattedMessage);
    } else {
      // 在发布模式下使用 developer.log
      developer.log(
        formattedMessage,
        name: tag,
        level: level.value,
        time: DateTime.now(),
      );
    }
  }
}

/// 日志级别
enum LogLevel {
  debug(700),
  info(800),
  warning(900),
  error(1000);

  const LogLevel(this.value);
  final int value;
}
