import 'dart:convert';

import '../../../core/index.dart';
import '../models/quickconnect_models.dart';

/// JSON 序列化辅助工具类
/// 
/// 提供统一的序列化/反序列化方法，包含错误处理和数据验证
class SerializationHelper {

  /// 安全地从 JSON 字符串反序列化对象
  /// 
  /// [jsonString] JSON 字符串
  /// [fromJson] 反序列化函数
  /// [fallback] 失败时的默认值
  static T? safeFromJson<T>(
    String jsonString,
    T Function(Map<String, dynamic>) fromJson, {
    T? fallback,
  }) {
    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(jsonMap);
    } on FormatException catch (e) {
      AppLogger.error('JSON 格式错误: $e');
      return fallback;
    } on TypeError catch (e) {
      AppLogger.error('类型转换错误: $e');
      return fallback;
    } catch (e) {
      AppLogger.error('反序列化异常: $e');
      return fallback;
    }
  }

  /// 安全地从 Map 反序列化对象
  /// 
  /// [jsonMap] JSON Map
  /// [fromJson] 反序列化函数
  /// [fallback] 失败时的默认值
  static T? safeFromMap<T>(
    Map<String, dynamic> jsonMap,
    T Function(Map<String, dynamic>) fromJson, {
    T? fallback,
  }) {
    try {
      return fromJson(jsonMap);
    } on TypeError catch (e) {
      AppLogger.error('类型转换错误: $e');
      return fallback;
    } catch (e) {
      AppLogger.error('反序列化异常: $e');
      return fallback;
    }
  }

  /// 安全地序列化对象为 JSON 字符串
  /// 
  /// [object] 要序列化的对象
  /// [toJson] 序列化函数
  /// [fallback] 失败时的默认值
  static String? safeToJson<T>(
    T object,
    Map<String, dynamic> Function(T) toJson, {
    String? fallback,
  }) {
    try {
      final jsonMap = toJson(object);
      return jsonEncode(jsonMap);
    } catch (e) {
      AppLogger.error('序列化异常: $e');
      return fallback;
    }
  }

  /// 批量反序列化列表
  /// 
  /// [jsonList] JSON 列表
  /// [fromJson] 反序列化函数
  /// [filterNull] 是否过滤 null 值
  static List<T> safeFromJsonList<T>(
    List<dynamic> jsonList,
    T Function(Map<String, dynamic>) fromJson, {
    bool filterNull = true,
  }) {
    final results = <T>[];
    
    for (final item in jsonList) {
      if (item is Map<String, dynamic>) {
        try {
          final result = fromJson(item);
          results.add(result);
        } catch (e) {
          AppLogger.error('列表项反序列化失败: $e');
          if (!filterNull) {
            // 如果不过滤 null，可以添加一个默认值或跳过
            continue;
          }
        }
      }
    }
    
    return results;
  }

  /// 验证 JSON 数据完整性
  /// 
  /// [jsonMap] 要验证的 JSON Map
  /// [requiredFields] 必需字段列表
  /// [optionalFields] 可选字段列表
  static bool validateJsonStructure(
    Map<String, dynamic> jsonMap,
    List<String> requiredFields, {
    List<String> optionalFields = const [],
  }) {
    // 检查必需字段
    for (final field in requiredFields) {
      if (!jsonMap.containsKey(field)) {
        AppLogger.error('缺少必需字段: $field');
        return false;
      }
      
      if (jsonMap[field] == null) {
        AppLogger.error('必需字段为空: $field');
        return false;
      }
    }
    
    // 检查字段类型（基本验证）
    for (final field in requiredFields) {
      final value = jsonMap[field];
      if (value is String && value.isEmpty) {
        AppLogger.error('必需字段为空字符串: $field');
        return false;
      }
    }
    
    return true;
  }

  /// 深度克隆对象（通过序列化）
  /// 
  /// [object] 要克隆的对象
  /// [fromJson] 反序列化函数
  /// [toJson] 序列化函数
  static T? deepClone<T>(
    T object,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic> Function(T) toJson,
  ) {
    try {
      final jsonMap = toJson(object);
      return fromJson(jsonMap);
    } catch (e) {
      AppLogger.error('深度克隆失败: $e');
      return null;
    }
  }

  /// 合并两个 JSON 对象
  /// 
  /// [base] 基础对象
  /// [override] 覆盖对象
  /// [deepMerge] 是否深度合并
  static Map<String, dynamic> mergeJson(
    Map<String, dynamic> base,
    Map<String, dynamic> override, {
    bool deepMerge = true,
  }) {
    if (!deepMerge) {
      return {...base, ...override};
    }
    
    final result = Map<String, dynamic>.from(base);
    
    for (final entry in override.entries) {
      final key = entry.key;
      final value = entry.value;
      
      if (value is Map<String, dynamic> && 
          result[key] is Map<String, dynamic>) {
        result[key] = mergeJson(
          result[key] as Map<String, dynamic>,
          value,
          deepMerge: true,
        );
      } else {
        result[key] = value;
      }
    }
    
    return result;
  }

  /// 清理 JSON 数据（移除 null 值和空字符串）
  /// 
  /// [jsonMap] 要清理的 JSON Map
  /// [removeEmptyStrings] 是否移除空字符串
  static Map<String, dynamic> cleanJson(
    Map<String, dynamic> jsonMap, {
    bool removeEmptyStrings = true,
  }) {
    final result = <String, dynamic>{};
    
    for (final entry in jsonMap.entries) {
      final key = entry.key;
      final value = entry.value;
      
      if (value == null) continue;
      
      if (removeEmptyStrings && value is String && value.isEmpty) continue;
      
      if (value is Map<String, dynamic>) {
        final cleaned = cleanJson(value, removeEmptyStrings: removeEmptyStrings);
        if (cleaned.isNotEmpty) {
          result[key] = cleaned;
        }
      } else if (value is List) {
        final cleaned = value.where((item) {
          if (item == null) return false;
          if (removeEmptyStrings && item is String && item.isEmpty) return false;
          return true;
        }).toList();
        if (cleaned.isNotEmpty) {
          result[key] = cleaned;
        }
      } else {
        result[key] = value;
      }
    }
    
    return result;
  }

  /// 格式化 JSON 字符串（美化输出）
  /// 
  /// [jsonString] 要格式化的 JSON 字符串
  /// [indent] 缩进字符
  static String formatJson(String jsonString, {String indent = '  '}) {
    try {
      final jsonMap = jsonDecode(jsonString);
      return JsonEncoder.withIndent(indent).convert(jsonMap);
    } catch (e) {
      AppLogger.error('JSON 格式化失败: $e');
      return jsonString;
    }
  }

  /// 检查 JSON 字符串是否有效
  /// 
  /// [jsonString] 要检查的 JSON 字符串
  static bool isValidJson(String jsonString) {
    try {
      jsonDecode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 从 JSON 中提取嵌套值
  /// 
  /// [jsonMap] JSON Map
  /// [path] 路径（用点分隔）
  /// [fallback] 失败时的默认值
  static T? extractNestedValue<T>(
    Map<String, dynamic> jsonMap,
    String path, {
    T? fallback,
  }) {
    try {
      final keys = path.split('.');
      dynamic current = jsonMap;
      
      for (final key in keys) {
        if (current is Map<String, dynamic>) {
          current = current[key];
        } else {
          return fallback;
        }
        
        if (current == null) return fallback;
      }
      
      return current as T?;
    } catch (e) {
      AppLogger.error('提取嵌套值失败: $e');
      return fallback;
    }
  }

  /// 设置嵌套值
  /// 
  /// [jsonMap] JSON Map
  /// [path] 路径（用点分隔）
  /// [value] 要设置的值
  static bool setNestedValue(
    Map<String, dynamic> jsonMap,
    String path,
    dynamic value,
  ) {
    try {
      final keys = path.split('.');
      dynamic current = jsonMap;
      
      // 遍历到倒数第二个键
      for (int i = 0; i < keys.length - 1; i++) {
        final key = keys[i];
        if (current[key] == null || current[key] is! Map<String, dynamic>) {
          current[key] = <String, dynamic>{};
        }
        current = current[key];
      }
      
      // 设置最后一个键的值
      final lastKey = keys.last;
      current[lastKey] = value;
      return true;
    } catch (e) {
      AppLogger.error('设置嵌套值失败: $e');
      return false;
    }
  }
}

/// QuickConnect 特定的序列化扩展方法
extension QuickConnectSerialization on Map<String, dynamic> {
  /// 安全地转换为 TunnelResponse
  TunnelResponse? toTunnelResponse() {
    return SerializationHelper.safeFromMap(this, TunnelResponse.fromJson);
  }

  /// 安全地转换为 ServerInfoResponse
  ServerInfoResponse? toServerInfoResponse() {
    return SerializationHelper.safeFromMap(this, ServerInfoResponse.fromJson);
  }

  /// 安全地转换为 ConnectionTestResult
  ConnectionTestResult? toConnectionTestResult() {
    return SerializationHelper.safeFromMap(this, ConnectionTestResult.fromJson);
  }

  /// 安全地转换为 AddressInfo
  AddressInfo? toAddressInfo() {
    return SerializationHelper.safeFromMap(this, AddressInfo.fromJson);
  }
}

/// 字符串序列化扩展方法
extension StringSerialization on String {
  /// 安全地解析为 JSON Map
  Map<String, dynamic>? toJsonMap() {
    try {
      return jsonDecode(this) as Map<String, dynamic>;
    } catch (e) {
      AppLogger.error('字符串转 JSON Map 失败: $e');
      return null;
    }
  }

  /// 安全地转换为 TunnelResponse
  TunnelResponse? toTunnelResponse() {
    final jsonMap = toJsonMap();
    return jsonMap?.toTunnelResponse();
  }

  /// 安全地转换为 ServerInfoResponse
  ServerInfoResponse? toServerInfoResponse() {
    final jsonMap = toJsonMap();
    return jsonMap?.toServerInfoResponse();
  }
}
