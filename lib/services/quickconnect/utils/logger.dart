import 'package:flutter/material.dart';

/// 日志工具类
class AppLogger {
  static Function(String)? _logCallback;

  /// 设置日志回调函数
  static void setLogCallback(Function(String) callback) {
    _logCallback = callback;
  }

  /// 记录日志
  static void log(String message, {String? tag}) {
    final timestamp = DateTime.now().toString().substring(11, 19);
    final logMessage = tag != null ? '[$tag] $message' : message;
    final fullMessage = '[$timestamp] $logMessage';
    
    // 同时输出到控制台和应用界面
    debugPrint('[QuickConnect] $logMessage');
    if (_logCallback != null) {
      _logCallback!(fullMessage);
    }
  }

  /// 记录信息日志
  static void info(String message, {String? tag}) {
    log('ℹ️ $message', tag: tag);
  }

  /// 记录成功日志
  static void success(String message, {String? tag}) {
    log('✅ $message', tag: tag);
  }

  /// 记录警告日志
  static void warning(String message, {String? tag}) {
    log('⚠️ $message', tag: tag);
  }

  /// 记录错误日志
  static void error(String message, {String? tag}) {
    log('❌ $message', tag: tag);
  }

  /// 记录调试日志
  static void debug(String message, {String? tag}) {
    log('🔍 $message', tag: tag);
  }

  /// 记录网络请求日志
  static void network(String message, {String? tag}) {
    log('🌐 $message', tag: tag);
  }

  /// 记录用户操作日志
  static void userAction(String message, {String? tag}) {
    log('👤 $message', tag: tag);
  }
}
