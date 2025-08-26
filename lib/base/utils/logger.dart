import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

/// 统一日志管理器
class Logger {
  static const String _appTag = 'SynoPlayer';
  
  /// 调试日志
  static void debug(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      final logTag = tag != null ? '$_appTag:$tag' : _appTag;
      dev.log(
        message,
        name: logTag,
        level: 800, // DEBUG level
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  /// 信息日志
  static void info(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    final logTag = tag != null ? '$_appTag:$tag' : _appTag;
    dev.log(
      message,
      name: logTag,
      level: 900, // INFO level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  /// 警告日志
  static void warning(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    final logTag = tag != null ? '$_appTag:$tag' : _appTag;
    dev.log(
      message,
      name: logTag,
      level: 1000, // WARNING level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  /// 错误日志
  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    final logTag = tag != null ? '$_appTag:$tag' : _appTag;
    dev.log(
      message,
      name: logTag,
      level: 1200, // ERROR level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  /// 网络请求日志
  static void network(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    debug(message, tag: tag ?? 'Network', error: error, stackTrace: stackTrace);
  }
  
  /// API 调用日志
  static void api(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    debug(message, tag: tag ?? 'API', error: error, stackTrace: stackTrace);
  }
  
  /// 用户行为日志
  static void user(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    info(message, tag: tag ?? 'User', error: error, stackTrace: stackTrace);
  }
  
  /// 性能日志
  static void performance(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    info(message, tag: tag ?? 'Performance', error: error, stackTrace: stackTrace);
  }
}
