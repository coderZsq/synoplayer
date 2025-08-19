import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import 'package:synoplayer/features/quickconnect/data/datasources/quickconnect_remote_datasource.dart';
import 'package:synoplayer/core/error/failures.dart';
import 'package:synoplayer/features/quickconnect/data/models/quickconnect_model.dart';
import 'package:synoplayer/core/network/network_info.dart';

class MockDio extends Mock implements Dio {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  group('QuickConnectRemoteDataSourceImpl', () {
    late QuickConnectRemoteDataSourceImpl dataSource;
    late MockDio mockDio;
    late MockNetworkInfo mockNetworkInfo;

    setUp(() {
      mockDio = MockDio();
      mockNetworkInfo = MockNetworkInfo();
      dataSource = QuickConnectRemoteDataSourceImpl(
        dio: mockDio,
        networkInfo: mockNetworkInfo,
      );
    });

    group('requestTunnel', () {
      const quickConnectId = 'test-quickconnect-id';
      const testUrl = 'https://global.quickconnect.to/Serv.php';

      test('should return server info when API call is successful', () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        
        final mockResponse = Response<Map<String, dynamic>>(
          data: {
            'success': true,
            'data': {
              'external': {
                'domain': 'test.example.com',
                'ip': '192.168.1.100',
                'port': 5000,
                'protocol': 'https',
                'online': true,
              },
              'internal': {
                'ip': '192.168.1.100',
                'port': 5000,
              },
            },
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: testUrl),
        );

        when(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.requestTunnel(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (tunnelResponse) {
            expect(tunnelResponse, isNotNull);
            // 这里需要根据实际的 TunnelResponseModel 结构进行调整
          },
        );

        verify(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        )).called(1);
      });

      test('should return server failure when API returns error status', () async {
        // Arrange
        final mockResponse = Response<Map<String, dynamic>>(
          data: {'error': 'Server not found'},
          statusCode: 404,
          requestOptions: RequestOptions(path: testUrl),
        );

        when(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.requestTunnel(quickConnectId);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, contains('Server not found'));
          },
          (_) => fail('Should not return success'),
        );
      });

      test('should return network failure when DioException occurs', () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: testUrl),
          type: DioExceptionType.connectionTimeout,
        ));

        // Act
        final result = await dataSource.requestTunnel(quickConnectId);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, contains('Connection timeout'));
          },
          (_) => fail('Should not return success'),
        );
      });

      test('should handle different DioException types correctly', () async {
        // Arrange
        final dioExceptions = [
          DioException(
            requestOptions: RequestOptions(path: testUrl),
            type: DioExceptionType.sendTimeout,
          ),
          DioException(
            requestOptions: RequestOptions(path: testUrl),
            type: DioExceptionType.receiveTimeout,
          ),
          DioException(
            requestOptions: RequestOptions(path: testUrl),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: testUrl),
            ),
          ),
          DioException(
            requestOptions: RequestOptions(path: testUrl),
            type: DioExceptionType.cancel,
          ),
        ];

        for (int i = 0; i < dioExceptions.length; i++) {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenThrow(dioExceptions[i]);

          // Act
          final result = await dataSource.requestTunnel(quickConnectId);

          // Assert
          expect(result.isLeft(), isTrue);
          result.fold(
            (failure) {
              expect(failure, isA<NetworkFailure>());
            },
            (_) => fail('Should not return success'),
          );

          // Reset mock for next iteration
          reset(mockDio);
        }
      });
    });

    group('testConnection', () {
      const address = 'test.example.com';
      const port = 5000;

      test('should return connection status when connection test is successful', () async {
        // Arrange
        final mockResponse = Response<Map<String, dynamic>>(
          data: {
            'connected': true,
            'responseTime': 150,
            'error': null,
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: 'https://$address:$port'),
        );

        when(() => mockDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.testConnection(address, port: port);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (isConnected) {
            expect(isConnected, true);
          },
        );
      });

      test('should return connection status when connection test fails', () async {
        // Arrange
        final mockResponse = Response<Map<String, dynamic>>(
          data: {
            'connected': false,
            'responseTime': 0,
            'error': 'Connection refused',
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: 'https://$address:$port'),
        );

        when(() => mockDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.testConnection(address, port: port);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (isConnected) {
            expect(isConnected, false);
          },
        );
      });

      test('should handle connection test with default port', () async {
        // Arrange
        final mockResponse = Response<Map<String, dynamic>>(
          data: {
            'connected': true,
            'responseTime': 100,
            'error': null,
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: 'https://$address:5001'),
        );

        when(() => mockDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.testConnection(address);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (isConnected) {
            expect(isConnected, true);
          },
        );
      });
    });

    group('login', () {
      const address = 'test.example.com';
      const username = 'testuser';
      const password = 'testpass';
      const otpCode = '123456';
      const port = 5000;

      test('should return login result when login is successful', () async {
        // Arrange
        final mockResponse = Response<Map<String, dynamic>>(
          data: {
            'success': true,
            'sid': 'test-sid-123',
            'redirectUrl': 'https://test.example.com:5000/webman/index.cgi',
            'error': null,
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: 'https://$address:$port'),
        );

        when(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.login(
          address: address,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: true,
          port: port,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (loginResult) {
            expect(loginResult?.isSuccess, true);
            expect(loginResult?.sid, 'test-sid-123');
            expect(loginResult?.redirectUrl, 'https://test.example.com:5000/webman/index.cgi');
            expect(loginResult?.errorMessage, isNull);
          },
        );

        verify(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).called(1);
      });

      test('should return login result when login fails', () async {
        // Arrange
        final mockResponse = Response<Map<String, dynamic>>(
          data: {
            'success': false,
            'sid': null,
            'redirectUrl': null,
            'error': 'Invalid credentials',
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: 'https://$address:$port'),
        );

        when(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.login(
          address: address,
          username: username,
          password: password,
          rememberMe: false,
          port: port,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (loginResult) {
            expect(loginResult?.isSuccess, false);
            expect(loginResult?.sid, isNull);
            expect(loginResult?.errorMessage, 'Invalid credentials');
          },
        );
      });

      test('should handle OTP required case', () async {
        // Arrange
        final mockResponse = Response<Map<String, dynamic>>(
          data: {
            'success': false,
            'sid': null,
            'redirectUrl': null,
            'error': 'OTP required',
            'requireOTP': true,
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: 'https://$address:$port'),
        );

        when(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.login(
          address: address,
          username: username,
          password: password,
          port: port,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (loginResult) {
            expect(loginResult?.isSuccess, false);
            expect(loginResult?.errorMessage, 'OTP required');
          },
        );
      });

      test('should handle network errors during login', () async {
        // Arrange
        when(() => mockDio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: 'https://$address:$port'),
          type: DioExceptionType.connectionTimeout,
        ));

        // Act
        final result = await dataSource.login(
          address: address,
          username: username,
          password: password,
          port: port,
        );

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, contains('Connection timeout'));
          },
          (_) => fail('Should not return success'),
        );
      });
    });



    group('getPerformanceStats', () {
      const quickConnectId = 'test-quickconnect-id';

      test('should return performance stats when API call is successful', () async {
        // Arrange
        final mockResponse = Response<Map<String, dynamic>>(
          data: {
            'responseTime': 150,
            'uptime': 86400,
            'connections': 100,
            'errors': 5,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: 'https://api.quickconnect.to'),
        );

        when(() => mockDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.getPerformanceStats();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (performanceStats) {
            expect(performanceStats['responseTime'], 150);
            expect(performanceStats['uptime'], 86400);
            expect(performanceStats['connections'], 100);
            expect(performanceStats['errors'], 5);
          },
        );
      });

      test('should handle performance stats API errors', () async {
        // Arrange
        when(() => mockDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: 'https://api.quickconnect.to'),
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: 'https://api.quickconnect.to'),
          ),
        ));

        // Act
        final result = await dataSource.getPerformanceStats();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
          },
          (_) => fail('Should not return success'),
        );
      });
    });
  });
}
