import 'package:flutter_test/flutter_test.dart';
import 'package:synoplayer/services/quickconnect/api/quickconnect_api_mock.dart';
import 'package:synoplayer/services/quickconnect/models/quickconnect_models.dart';

void main() {
  group('QuickConnect 全球服务器信息 API 测试', () {
    group('Mock 实现测试', () {
      test('应该正确创建默认的成功响应', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();
        const quickConnectId = 'test123';

        // Act
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: quickConnectId,
          getCaFingerprints: true,
        );

        // Assert
        expect(response, isNotNull);
        expect(response!.command, equals('get_server_info'));
        expect(response.version, equals(1));
        expect(response.getCaFingerprints, isTrue);
        expect(response.isSuccess, isTrue);
        expect(response.isError, isFalse);
        expect(response.hasSites, isTrue);
        expect(response.sites, contains('global.quickconnect.to'));
        expect(response.sites, contains('cnc.quickconnect.cn'));
        expect(response.hasServerInfo, isTrue);
        expect(response.hasSmartDns, isTrue);
        expect(response.hasServiceInfo, isTrue);
      });

      test('应该正确处理错误响应（基于抓包数据）', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();
        const quickConnectId = 'error';

        // Act
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: quickConnectId,
        );

        // Assert
        expect(response, isNotNull);
        expect(response!.command, equals('get_server_info'));
        expect(response.errno, equals(4));
        expect(response.errinfo, equals('get_server_info.go:112[Ds info not found]'));
        expect(response.suberrno, equals(2));
        expect(response.version, equals(1));
        expect(response.isSuccess, isFalse);
        expect(response.isError, isTrue);
        expect(response.errorMessage, equals('get_server_info.go:112[Ds info not found]'));
        expect(response.errorCode, equals(4));
        expect(response.subErrorCode, equals(2));
        expect(response.hasSites, isTrue);
        expect(response.sites, contains('cnc.quickconnect.cn'));
      });

      test('应该正确处理未找到的响应', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();
        const quickConnectId = 'notfound';

        // Act
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: quickConnectId,
        );

        // Assert
        expect(response, isNotNull);
        expect(response!.command, equals('get_server_info'));
        expect(response.errno, equals(1));
        expect(response.errinfo, equals('QuickConnect ID not found'));
        expect(response.version, equals(1));
        expect(response.isSuccess, isFalse);
        expect(response.isError, isTrue);
        expect(response.hasSites, isTrue);
        expect(response.sites, contains('global.quickconnect.to'));
      });

      test('应该正确处理超时情况', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();
        const quickConnectId = 'timeout';

        // Act & Assert
        final stopwatch = Stopwatch()..start();
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: quickConnectId,
        );
        stopwatch.stop();

        expect(response, isNull);
        expect(stopwatch.elapsed.inSeconds, greaterThanOrEqualTo(5)); // 减少等待时间
      });

      test('应该正确处理自定义响应', () async {
        // Arrange
        final customResponse = QuickConnectServerInfoResponse(
          command: 'get_server_info',
          version: 2,
          sites: ['custom.site.com'],
          server: ServerInfo(
            external: ExternalServerInfo(
              ip: '10.0.0.1',
              port: 8080,
            ),
          ),
        );

        final mockApi = QuickConnectApiMock(
          quickConnectServerInfoResponse: customResponse,
        );

        // Act
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: 'custom123',
        );

        // Assert
        expect(response, equals(customResponse));
        expect(response!.command, equals('get_server_info'));
        expect(response.version, equals(2));
        expect(response.sites, equals(['custom.site.com']));
        expect(response.hasServerInfo, isTrue);
        expect(response.server!.external!.ip, equals('10.0.0.1'));
        expect(response.server!.external!.port, equals(8080));
      });

      test('应该正确处理 getCaFingerprints 参数', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();

        // Act - 测试 true 值
        final responseWithTrue = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: 'test123',
          getCaFingerprints: true,
        );

        // Act - 测试 false 值
        final responseWithFalse = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: 'test123',
          getCaFingerprints: false,
        );

        // Assert
        expect(responseWithTrue!.getCaFingerprints, isTrue);
        expect(responseWithFalse!.getCaFingerprints, isFalse);
      });
    });

    group('响应数据验证测试', () {
      test('默认响应应该包含完整的服务器信息', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();
        const quickConnectId = 'test123';

        // Act
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: quickConnectId,
        );

        // Assert - 服务器信息
        expect(response!.hasServerInfo, isTrue);
        expect(response.server!.external!.ip, equals('192.168.1.100'));
        expect(response.server!.external!.port, equals(5000));
        expect(response.server!.external!.isValid, isTrue);

        // Assert - SmartDNS 信息
        expect(response.hasSmartDns, isTrue);
        expect(response.smartdns!.host, equals('test123.synology.me'));
        expect(response.smartdns!.port, equals(443));
        expect(response.smartdns!.isValid, isTrue);

        // Assert - 服务信息
        expect(response.hasServiceInfo, isTrue);
        expect(response.service!.relayDn, equals('relay.quickconnect.to'));
        expect(response.service!.relayPort, equals(443));
        expect(response.service!.httpsIp, equals('192.168.1.100'));
        expect(response.service!.httpsPort, equals(5001));
        expect(response.service!.port, equals(5000));
        expect(response.service!.hasValidRelay, isTrue);
        expect(response.service!.hasValidHttpsRelay, isTrue);
        expect(response.service!.hasValidPort, isTrue);
      });

      test('错误响应应该提供有用的调试信息', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();
        const quickConnectId = 'error';

        // Act
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: quickConnectId,
        );

        // Assert
        final debugInfo = response!.debugInfo;
        expect(debugInfo, contains('get_server_info'));
        expect(debugInfo, contains('isSuccess: false'));
        expect(debugInfo, contains('errno: 4'));
        expect(debugInfo, contains('errinfo: get_server_info.go:112[Ds info not found]'));
        expect(debugInfo, contains('sites: [cnc.quickconnect.cn]'));
        expect(debugInfo, contains('hasServerInfo: false'));
        expect(debugInfo, contains('hasSmartDns: false'));
        expect(debugInfo, contains('hasServiceInfo: false'));
      });
    });

    group('边界情况测试', () {
      test('应该正确处理空的 QuickConnect ID', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();

        // Act
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: '',
        );

        // Assert
        expect(response, isNotNull);
        expect(response!.command, equals('get_server_info'));
        expect(response.isSuccess, isTrue);
      });

      test('应该正确处理包含特殊字符的 QuickConnect ID', () async {
        // Arrange
        final mockApi = QuickConnectApiMock();
        const quickConnectId = 'test-123_456';

        // Act
        final response = await mockApi.requestQuickConnectServerInfo(
          quickConnectId: quickConnectId,
        );

        // Assert
        expect(response, isNotNull);
        expect(response!.isSuccess, isTrue);
        expect(response.smartdns!.host, equals('test-123_456.synology.me'));
      });
    });

    group('性能测试', () {
      test('默认延迟应该在合理范围内', () async {
        // Arrange
        final mockApi = QuickConnectApiMock(mockDelay: const Duration(milliseconds: 100));
        const quickConnectId = 'test123';

        // Act
        final stopwatch = Stopwatch()..start();
        await mockApi.requestQuickConnectServerInfo(quickConnectId: quickConnectId);
        stopwatch.stop();

        // Assert
        expect(stopwatch.elapsed.inMilliseconds, greaterThanOrEqualTo(100));
        expect(stopwatch.elapsed.inMilliseconds, lessThan(200)); // 允许一些误差
      });
    });
  });
}
