import 'package:flutter_test/flutter_test.dart';
import 'package:synoplayer/services/quickconnect/api/quickconnect_api_interface.dart';
import 'package:synoplayer/services/quickconnect/api/quickconnect_api_mock.dart';
import 'package:synoplayer/services/quickconnect/auth_service.dart';
import 'package:synoplayer/services/quickconnect/connection_service.dart';
import 'package:synoplayer/services/quickconnect/address_resolver.dart';
import 'package:synoplayer/services/quickconnect/models/login_result.dart';
import 'package:synoplayer/services/quickconnect/models/quickconnect_models.dart';

void main() {
  group('QuickConnect API 抽象接口测试', () {
    late QuickConnectApiInterface mockApi;
    late QuickConnectAuthService authService;
    late QuickConnectConnectionService connectionService;
    late QuickConnectAddressResolver addressResolver;

    setUp(() {
      // 使用 Mock 实现进行测试
      mockApi = QuickConnectApiMockFactory.createSuccess();
      authService = QuickConnectAuthService(mockApi);
      connectionService = QuickConnectConnectionService(mockApi);
      addressResolver = QuickConnectAddressResolver(mockApi);
    });

    group('认证服务测试', () {
      test('成功登录应该返回 SID', () async {
        // Arrange
        const baseUrl = 'https://test.synology.com:5001';
        const username = 'testuser';
        const password = 'testpass';

        // Act
        final result = await authService.login(
          baseUrl: baseUrl,
          username: username,
          password: password,
        );

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.sid, isNotNull);
        expect(result.sid, isNotEmpty);
      });

      test('无效用户名应该返回失败', () async {
        // Arrange
        const baseUrl = 'https://test.synology.com:5001';
        const username = 'invalid_user';
        const password = 'testpass';

        // Act
        final result = await authService.login(
          baseUrl: baseUrl,
          username: username,
          password: password,
        );

        // Assert
        expect(result.isSuccess, isFalse);
        expect(result.errorMessage, contains('Invalid username'));
      });

      test('需要 OTP 验证时应该返回相应状态', () async {
        // Arrange
        const baseUrl = 'https://test.synology.com:5001';
        const username = 'otp_required';
        const password = 'testpass';

        // Act
        final result = await authService.login(
          baseUrl: baseUrl,
          username: username,
          password: password,
        );

        // Assert
        expect(result.requireOTP, isTrue);
        expect(result.errorMessage, contains('OTP code required'));
      });

      test('提供有效 OTP 应该登录成功', () async {
        // Arrange
        const baseUrl = 'https://test.synology.com:5001';
        const username = 'otp_required';
        const password = 'testpass';
        const otpCode = '123456';

        // Act
        final result = await authService.login(
          baseUrl: baseUrl,
          username: username,
          password: password,
          otpCode: otpCode,
        );

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.sid, isNotNull);
      });
    });

    group('连接服务测试', () {
      test('有效地址应该连接成功', () async {
        // Arrange
        const baseUrl = 'https://test.synology.com:5001';

        // Act
        final result = await connectionService.testConnection(baseUrl);

        // Assert
        expect(result.isConnected, isTrue);
        expect(result.url, equals(baseUrl));
        expect(result.responseTime.inMilliseconds, greaterThan(0));
      });

      test('无效地址应该连接失败', () async {
        // Arrange
        const baseUrl = 'https://invalid.example.com:5001';

        // Act
        final result = await connectionService.testConnection(baseUrl);

        // Assert
        expect(result.isConnected, isFalse);
        expect(result.error, contains('Invalid URL'));
      });

      test('批量连接测试应该返回所有结果', () async {
        // Arrange
        const urls = [
          'https://test1.synology.com:5001',
          'https://test2.synology.com:5001',
          'https://invalid.example.com:5001',
        ];

        // Act
        final results = await connectionService.testMultipleConnections(urls);

        // Assert
        expect(results.length, equals(urls.length));
        expect(results[0].isConnected, isTrue);
        expect(results[1].isConnected, isTrue);
        expect(results[2].isConnected, isFalse);
      });
    });

    group('地址解析服务测试', () {
      test('有效 QuickConnect ID 应该解析到地址', () async {
        // Arrange
        const quickConnectId = 'test-server';

        // Act
        final address = await addressResolver.resolveAddress(quickConnectId);

        // Assert
        expect(address, isNotNull);
        expect(address, startsWith('https://'));
      });

      test('获取所有地址详细信息应该返回多个地址', () async {
        // Arrange
        const quickConnectId = 'test-server';

        // Act
        final addresses = await addressResolver.getAllAddressesWithDetails(quickConnectId);

        // Assert
        expect(addresses, isNotEmpty);
        expect(addresses.first.url, startsWith('https://'));
        expect(addresses.first.type, isA<AddressType>());
        expect(addresses.first.priority, isA<int>());
      });
    });

    group('错误场景测试', () {
      test('API 层失败应该正确处理', () async {
        // Arrange - 使用失败的 Mock
        final failureMockApi = QuickConnectApiMockFactory.createFailure();
        final failureAuthService = QuickConnectAuthService(failureMockApi);

        // Act
        final result = await failureAuthService.login(
          baseUrl: 'https://test.synology.com:5001',
          username: 'testuser',
          password: 'testpass',
        );

        // Assert
        expect(result.isSuccess, isFalse);
        expect(result.errorMessage, contains('failed'));
      });

      test('超时场景应该正确处理', () async {
        // Arrange - 使用超时的 Mock（减少延迟时间避免测试超时）
        final timeoutMockApi = QuickConnectApiMockFactory.createTimeout(
          delay: const Duration(seconds: 2), // 减少到 2 秒
        );
        final timeoutConnectionService = QuickConnectConnectionService(timeoutMockApi);

        // Act
        final result = await timeoutConnectionService.testConnection(
          'https://timeout.example.com:5001'
        );

        // Assert
        expect(result.isConnected, isFalse);
        expect(result.error, contains('timeout'));
        expect(result.responseTime.inSeconds, greaterThanOrEqualTo(2));
      });
    });

    group('自定义 Mock 数据测试', () {
      test('可以使用自定义响应数据', () async {
        // Arrange - 创建自定义响应
        final customLoginResult = LoginResult.success(
          sid: 'custom_session_id',
          availableAddress: 'https://custom.example.com:5001',
        );

        final customConnectionResult = ConnectionTestResult.success(
          'https://custom.example.com:5001',
          200,
          const Duration(milliseconds: 50),
        );

        final customMockApi = QuickConnectApiMockFactory.createCustom(
          tunnelResponse: null,
          serverInfoResponse: null,
          loginResult: customLoginResult,
          connectionTestResult: customConnectionResult,
        );

        final customAuthService = QuickConnectAuthService(customMockApi);
        final customConnectionService = QuickConnectConnectionService(customMockApi);

        // Act - 测试登录
        final loginResult = await customAuthService.login(
          baseUrl: 'https://custom.example.com:5001',
          username: 'testuser',
          password: 'testpass',
        );

        // Act - 测试连接
        final connectionResult = await customConnectionService.testConnection(
          'https://custom.example.com:5001'
        );

        // Assert
        expect(loginResult.sid, equals('custom_session_id'));
        expect(connectionResult.responseTime.inMilliseconds, equals(50));
      });
    });
  });

  group('Mock 工厂类测试', () {
    test('createSuccess 应该创建成功的 Mock', () {
      // Act
      final mock = QuickConnectApiMockFactory.createSuccess();

      // Assert
      expect(mock, isA<QuickConnectApiInterface>());
    });

    test('createFailure 应该创建失败的 Mock', () {
      // Act
      final mock = QuickConnectApiMockFactory.createFailure();

      // Assert
      expect(mock, isA<QuickConnectApiInterface>());
    });

    test('createOTPRequired 应该创建需要 OTP 的 Mock', () {
      // Act
      final mock = QuickConnectApiMockFactory.createOTPRequired();

      // Assert
      expect(mock, isA<QuickConnectApiInterface>());
    });

    test('createTimeout 应该创建超时的 Mock', () {
      // Act
      final mock = QuickConnectApiMockFactory.createTimeout();

      // Assert
      expect(mock, isA<QuickConnectApiInterface>());
    });
  });
}
