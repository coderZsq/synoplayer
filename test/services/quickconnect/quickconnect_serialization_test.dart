import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:synoplayer/services/quickconnect/models/quickconnect_models.dart';

void main() {
  group('QuickConnect 服务器信息序列化测试', () {
    test('应该正确解析抓包数据中的错误响应', () {
      // Arrange - 基于抓包的实际响应数据
      const responseJson = '''
      {
        "command": "get_server_info",
        "errinfo": "get_server_info.go:112[Ds info not found]",
        "errno": 4,
        "sites": ["cnc.quickconnect.cn"],
        "suberrno": 2,
        "version": 1
      }
      ''';

      final responseMap = jsonDecode(responseJson) as Map<String, dynamic>;

      // Act - 反序列化
      final response = QuickConnectServerInfoResponse.fromJson(responseMap);

      // Assert - 验证所有字段
      expect(response.command, equals('get_server_info'));
      expect(response.errinfo, equals('get_server_info.go:112[Ds info not found]'));
      expect(response.errno, equals(4));
      expect(response.sites, equals(['cnc.quickconnect.cn']));
      expect(response.suberrno, equals(2));
      expect(response.version, equals(1));
      
      // 验证计算属性
      expect(response.isSuccess, isFalse);
      expect(response.isError, isTrue);
      expect(response.errorMessage, equals('get_server_info.go:112[Ds info not found]'));
      expect(response.errorCode, equals(4));
      expect(response.subErrorCode, equals(2));
      expect(response.hasSites, isTrue);
      expect(response.hasServerInfo, isFalse);
      expect(response.hasSmartDns, isFalse);
      expect(response.hasServiceInfo, isFalse);
    });

    test('应该正确序列化为 JSON', () {
      // Arrange
      final response = QuickConnectServerInfoResponse(
        command: 'get_server_info',
        errinfo: 'get_server_info.go:112[Ds info not found]',
        errno: 4,
        sites: ['cnc.quickconnect.cn'],
        suberrno: 2,
        version: 1,
      );

      // Act
      final json = response.toJson();

      // Assert
      expect(json['command'], equals('get_server_info'));
      expect(json['errinfo'], equals('get_server_info.go:112[Ds info not found]'));
      expect(json['errno'], equals(4));
      expect(json['sites'], equals(['cnc.quickconnect.cn']));
      expect(json['suberrno'], equals(2));
      expect(json['version'], equals(1));
    });

    test('应该正确处理成功响应（无错误代码）', () {
      // Arrange
      const responseJson = '''
      {
        "command": "get_server_info",
        "sites": ["global.quickconnect.to", "cnc.quickconnect.cn"],
        "version": 1,
        "server": {
          "external": {
            "ip": "192.168.1.100",
            "port": 5000
          }
        },
        "smartdns": {
          "host": "example.synology.me",
          "port": 443
        }
      }
      ''';

      final responseMap = jsonDecode(responseJson) as Map<String, dynamic>;

      // Act
      final response = QuickConnectServerInfoResponse.fromJson(responseMap);

      // Assert
      expect(response.command, equals('get_server_info'));
      expect(response.errno, isNull);
      expect(response.errinfo, isNull);
      expect(response.sites?.length, equals(2));
      expect(response.version, equals(1));
      
      // 验证计算属性
      expect(response.isSuccess, isTrue);
      expect(response.isError, isFalse);
      expect(response.errorMessage, isNull);
      expect(response.hasSites, isTrue);
      expect(response.hasServerInfo, isTrue);
      expect(response.hasSmartDns, isTrue);
      expect(response.hasServiceInfo, isFalse);
      
      // 验证嵌套对象
      expect(response.server?.external?.ip, equals('192.168.1.100'));
      expect(response.server?.external?.port, equals(5000));
      expect(response.smartdns?.host, equals('example.synology.me'));
      expect(response.smartdns?.port, equals(443));
    });

    test('应该正确处理包含 get_ca_fingerprints 字段的请求', () {
      // Arrange - 基于抓包的请求数据
      const responseJson = '''
      {
        "get_ca_fingerprints": true,
        "command": "get_server_info",
        "errno": 4,
        "errinfo": "get_server_info.go:112[Ds info not found]",
        "sites": ["cnc.quickconnect.cn"],
        "version": 1
      }
      ''';

      final responseMap = jsonDecode(responseJson) as Map<String, dynamic>;

      // Act
      final response = QuickConnectServerInfoResponse.fromJson(responseMap);

      // Assert
      expect(response.getCaFingerprints, isTrue);
      expect(response.command, equals('get_server_info'));
      expect(response.errno, equals(4));
      expect(response.isError, isTrue);
    });

    test('应该提供有用的调试信息', () {
      // Arrange
      final response = QuickConnectServerInfoResponse(
        command: 'get_server_info',
        errno: 4,
        errinfo: 'Test error message',
        sites: ['site1.com', 'site2.com'],
      );

      // Act
      final debugInfo = response.debugInfo;

      // Assert
      expect(debugInfo, contains('get_server_info'));
      expect(debugInfo, contains('isSuccess: false'));
      expect(debugInfo, contains('errno: 4'));
      expect(debugInfo, contains('errinfo: Test error message'));
      expect(debugInfo, contains('sites: [site1.com, site2.com]'));
      expect(debugInfo, contains('hasServerInfo: false'));
    });

    test('应该正确处理边界情况', () {
      // Arrange
      final response = QuickConnectServerInfoResponse(
        command: 'get_server_info',
        sites: [],
        server: null,
        smartdns: null,
        service: null,
      );

      // Act & Assert
      expect(response.hasSites, isFalse);
      expect(response.hasServerInfo, isFalse);
      expect(response.hasSmartDns, isFalse);
      expect(response.hasServiceInfo, isFalse);
    });

    test('往返测试 (Roundtrip) JSON -> 对象 -> JSON 应该保持一致', () {
      // Arrange - 原始抓包数据
      const originalJson = '''
      {
        "command": "get_server_info",
        "errinfo": "get_server_info.go:112[Ds info not found]",
        "errno": 4,
        "sites": ["cnc.quickconnect.cn"],
        "suberrno": 2,
        "version": 1
      }
      ''';

      final originalMap = jsonDecode(originalJson) as Map<String, dynamic>;

      // Act - 往返转换
      final response = QuickConnectServerInfoResponse.fromJson(originalMap);
      final serializedMap = response.toJson();

      // Assert - 验证关键字段保持一致
      expect(serializedMap['command'], equals(originalMap['command']));
      expect(serializedMap['errinfo'], equals(originalMap['errinfo']));
      expect(serializedMap['errno'], equals(originalMap['errno']));
      expect(serializedMap['sites'], equals(originalMap['sites']));
      expect(serializedMap['suberrno'], equals(originalMap['suberrno']));
      expect(serializedMap['version'], equals(originalMap['version']));
    });
  });
}
