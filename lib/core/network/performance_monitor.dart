import '../config/retrofit_migration_config.dart';
import '../utils/logger.dart';

/// 单次请求性能记录
class PerformanceRecord {
  final String featureName;
  final String implementation; // 'retrofit' 或 'legacy'
  final Duration duration;
  final bool isSuccess;
  final String? errorMessage;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  PerformanceRecord({
    required this.featureName,
    required this.implementation,
    required this.duration,
    required this.isSuccess,
    this.errorMessage,
    required this.timestamp,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'featureName': featureName,
      'implementation': implementation,
      'durationMs': duration.inMilliseconds,
      'isSuccess': isSuccess,
      'errorMessage': errorMessage,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }
}

/// 性能汇总数据
class PerformanceSummary {
  final String featureName;
  final String implementation;
  final int totalRequests;
  final int successfulRequests;
  final int failedRequests;
  final Duration averageDuration;
  final Duration minDuration;
  final Duration maxDuration;
  final double successRate;
  final DateTime lastUpdated;

  PerformanceSummary({
    required this.featureName,
    required this.implementation,
    required this.totalRequests,
    required this.successfulRequests,
    required this.failedRequests,
    required this.averageDuration,
    required this.minDuration,
    required this.maxDuration,
    required this.successRate,
    required this.lastUpdated,
  });

  Map<String, dynamic> toJson() {
    return {
      'featureName': featureName,
      'implementation': implementation,
      'totalRequests': totalRequests,
      'successfulRequests': successfulRequests,
      'failedRequests': failedRequests,
      'averageDurationMs': averageDuration.inMilliseconds,
      'minDurationMs': minDuration.inMilliseconds,
      'maxDurationMs': maxDuration.inMilliseconds,
      'successRate': successRate,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

/// 网络性能监控器
/// 
/// 用于监控和对比 Retrofit 与旧实现的性能差异
class NetworkPerformanceMonitor {
  static const String _tag = 'NetworkPerformanceMonitor';
  
  // ==================== 性能数据存储 ====================
  
  static final Map<String, List<PerformanceRecord>> _performanceData = {};
  static final Map<String, PerformanceSummary> _performanceSummary = {};
  
  // ==================== 性能监控方法 ====================
  
  /// 记录请求性能
  static void recordPerformance({
    required String featureName,
    required String implementation,
    required Duration duration,
    required bool isSuccess,
    String? errorMessage,
    Map<String, dynamic>? metadata,
  }) {
    // 检查是否应该记录性能数据
    if (!RetrofitMigrationConfig.enablePerformanceMonitoring) {
      return;
    }
    
    // 随机采样
    if (!_shouldSample()) {
      return;
    }
    
    final record = PerformanceRecord(
      featureName: featureName,
      implementation: implementation,
      duration: duration,
      isSuccess: isSuccess,
      errorMessage: errorMessage,
      timestamp: DateTime.now(),
      metadata: metadata,
    );
    
    // 存储性能记录
    _performanceData.putIfAbsent(featureName, () => []).add(record);
    
    // 更新性能汇总
    _updatePerformanceSummary(featureName, implementation);
    
    // 记录到日志
    _logPerformanceRecord(record);
  }
  
  /// 检查是否应该采样
  static bool _shouldSample() {
    final sampleRate = RetrofitMigrationConfig.performanceMonitoringSampleRate;
    final random = DateTime.now().millisecondsSinceEpoch % 100;
    return random < (sampleRate * 100);
  }
  
  /// 更新性能汇总
  static void _updatePerformanceSummary(String featureName, String implementation) {
    final records = _performanceData[featureName] ?? [];
    final implementationRecords = records.where((r) => r.implementation == implementation).toList();
    
    if (implementationRecords.isEmpty) return;
    
    final totalRequests = implementationRecords.length;
    final successfulRequests = implementationRecords.where((r) => r.isSuccess).length;
    final failedRequests = totalRequests - successfulRequests;
    final successRate = totalRequests > 0 ? successfulRequests / totalRequests : 0.0;
    
    final durations = implementationRecords.map((r) => r.duration).toList();
    final averageDuration = Duration(
      milliseconds: (durations.fold<int>(0, (sum, d) => sum + d.inMilliseconds) / totalRequests).round(),
    );
    final minDuration = durations.reduce((a, b) => a < b ? a : b);
    final maxDuration = durations.reduce((a, b) => a > b ? a : b);
    
    final summary = PerformanceSummary(
      featureName: featureName,
      implementation: implementation,
      totalRequests: totalRequests,
      successfulRequests: successfulRequests,
      failedRequests: failedRequests,
      averageDuration: averageDuration,
      minDuration: minDuration,
      maxDuration: maxDuration,
      successRate: successRate,
      lastUpdated: DateTime.now(),
    );
    
    _performanceSummary['${featureName}_$implementation'] = summary;
  }
  
  /// 记录性能记录到日志
  static void _logPerformanceRecord(PerformanceRecord record) {
    final message = '性能记录: ${record.featureName} (${record.implementation}) - '
        '${record.duration.inMilliseconds}ms - '
        '${record.isSuccess ? "成功" : "失败"}';
    
    AppLogger.info(message, tag: _tag);
    
    if (record.errorMessage != null) {
      AppLogger.warning('错误信息: ${record.errorMessage}', tag: _tag);
    }
  }
  
  // ==================== 性能数据查询 ====================
  
  /// 获取性能汇总数据
  static Map<String, PerformanceSummary> getPerformanceSummary() {
    return Map.unmodifiable(_performanceSummary);
  }
  
  /// 获取特定功能的性能对比
  static Map<String, PerformanceSummary?> getFeaturePerformanceComparison(String featureName) {
    final retrofitKey = '${featureName}_retrofit';
    final legacyKey = '${featureName}_legacy';
    
    return {
      'retrofit': _performanceSummary[retrofitKey],
      'legacy': _performanceSummary[legacyKey],
    };
  }
  
  /// 获取所有性能数据
  static Map<String, List<PerformanceRecord>> getAllPerformanceData() {
    return Map.unmodifiable(_performanceData);
  }
  
  /// 获取特定功能的性能数据
  static List<PerformanceRecord> getFeaturePerformanceData(String featureName) {
    return List.unmodifiable(_performanceData[featureName] ?? []);
  }
  
  // ==================== 性能分析 ====================
  
  /// 分析性能差异
  static Map<String, dynamic> analyzePerformanceDifference(String featureName) {
    final retrofitSummary = _performanceSummary['${featureName}_retrofit'];
    final legacySummary = _performanceSummary['${featureName}_legacy'];
    
    if (retrofitSummary == null || legacySummary == null) {
      return {'error': '缺少性能数据进行比较'};
    }
    
    final durationDifference = retrofitSummary.averageDuration.inMilliseconds - 
                              legacySummary.averageDuration.inMilliseconds;
    final durationImprovement = durationDifference < 0;
    final durationImprovementPercent = legacySummary.averageDuration.inMilliseconds > 0
        ? (durationDifference.abs() / legacySummary.averageDuration.inMilliseconds * 100).round()
        : 0;
    
    final successRateDifference = retrofitSummary.successRate - legacySummary.successRate;
    final successRateImprovement = successRateDifference > 0;
    final successRateImprovementPercent = (successRateDifference.abs() * 100).round();
    
    return {
      'featureName': featureName,
      'duration': {
        'retrofit': retrofitSummary.averageDuration.inMilliseconds,
        'legacy': legacySummary.averageDuration.inMilliseconds,
        'difference': durationDifference,
        'improvement': durationImprovement,
        'improvementPercent': durationImprovementPercent,
      },
      'successRate': {
        'retrofit': retrofitSummary.successRate,
        'legacy': legacySummary.successRate,
        'difference': successRateDifference,
        'improvement': successRateImprovement,
        'improvementPercent': successRateImprovementPercent,
      },
      'recommendation': _generateRecommendation(
        durationImprovement,
        successRateImprovement,
        durationImprovementPercent,
        successRateImprovementPercent,
      ),
    };
  }
  
  /// 生成性能改进建议
  static String _generateRecommendation(
    bool durationImprovement,
    bool successRateImprovement,
    int durationImprovementPercent,
    int successRateImprovementPercent,
  ) {
    if (durationImprovement && successRateImprovement) {
      return 'Retrofit 在响应时间和成功率方面都有显著改进，建议继续使用';
    } else if (durationImprovement) {
      return 'Retrofit 在响应时间方面有改进，但成功率需要进一步观察';
    } else if (successRateImprovement) {
      return 'Retrofit 在成功率方面有改进，但响应时间需要进一步观察';
    } else {
      return 'Retrofit 性能表现不如旧实现，建议回滚或进一步优化';
    }
  }
  
  // ==================== 数据清理 ====================
  
  /// 清理旧的性能数据
  static void cleanupOldData({Duration maxAge = const Duration(days: 7)}) {
    final cutoffTime = DateTime.now().subtract(maxAge);
    
    for (final entry in _performanceData.entries) {
      final featureName = entry.key;
      final records = entry.value;
      
      // 移除旧记录
      records.removeWhere((record) => record.timestamp.isBefore(cutoffTime));
      
      // 如果功能没有记录，移除整个条目
      if (records.isEmpty) {
        _performanceData.remove(featureName);
      }
    }
    
    // 清理性能汇总
    _cleanupPerformanceSummary();
    
    AppLogger.info('清理了 ${maxAge.inDays} 天前的性能数据', tag: _tag);
  }
  
  /// 清理性能汇总数据
  static void _cleanupPerformanceSummary() {
    final cutoffTime = DateTime.now().subtract(const Duration(days: 1));
    
    _performanceSummary.removeWhere((key, summary) => 
      summary.lastUpdated.isBefore(cutoffTime)
    );
  }
  
  /// 重置所有性能数据
  static void resetAllData() {
    _performanceData.clear();
    _performanceSummary.clear();
    AppLogger.info('所有性能数据已重置', tag: _tag);
  }
  
  // ==================== 导出功能 ====================
  
  /// 导出性能数据为 JSON
  static Map<String, dynamic> exportPerformanceData() {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'performanceData': _performanceData.map(
        (key, value) => MapEntry(key, value.map((r) => r.toJson()).toList()),
      ),
      'performanceSummary': _performanceSummary.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }
}

/// 日志级别枚举
enum LogLevel {
  debug,
  info,
  warning,
  error,
}
