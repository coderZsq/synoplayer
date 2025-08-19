import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:synoplayer/features/quickconnect/data/repositories/quickconnect_repository_impl.dart';
import 'package:synoplayer/features/quickconnect/data/datasources/quickconnect_remote_datasource.dart';
import 'package:synoplayer/features/quickconnect/data/datasources/quickconnect_local_datasource.dart';
import 'package:synoplayer/features/quickconnect/data/models/quickconnect_model.dart';
import 'package:synoplayer/core/error/failures.dart';

class MockQuickConnectRemoteDataSource extends Mock implements QuickConnectRemoteDataSource {}
class MockQuickConnectLocalDataSource extends Mock implements QuickConnectLocalDataSource {}

void main() {
  group('QuickConnectRepositoryImpl', () {
    late QuickConnectRepositoryImpl repository;
    late MockQuickConnectRemoteDataSource mockRemoteDataSource;
    late MockQuickConnectLocalDataSource mockLocalDataSource;

    setUp(() {
      mockRemoteDataSource = MockQuickConnectRemoteDataSource();
      mockLocalDataSource = MockQuickConnectLocalDataSource();
      repository = QuickConnectRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
      );
    });

    group('requestTunnel', () {
      const quickConnectId = 'test-quickconnect-id';

      test('should return server info when remote request is successful', () async {
        // Arrange
        final serverInfo = QuickConnectServerInfoModel(
          externalDomain: 'test.example.com',
          internalIp: '192.168.1.100',
          port: 5000,
          protocol: 'https',
          isOnline: true,
        );

        when(() => mockRemoteDataSource.requestTunnel(quickConnectId))
            .thenAnswer((_) async => Right(serverInfo));

        // Act
        final result = await repository.requestTunnel(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (result) {
            expect(result.externalDomain, 'test.example.com');
            expect(result.internalIp, '192.168.1.100');
            expect(result.port, 5000);
            expect(result.protocol, 'https');
            expect(result.isOnline, true);
          },
        );

        verify(() => mockRemoteDataSource.requestTunnel(quickConnectId)).called(1);
      });

      test('should return failure when remote request fails', () async {
        // Arrange
        when(() => mockRemoteDataSource.requestTunnel(quickConnectId))
            .thenAnswer((_) async => const Left(ServerFailure('Server not found')));

        // Act
        final result = await repository.requestTunnel(quickConnectId);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Server not found');
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('resolveAddress', () {
      const quickConnectId = 'test-quickconnect-id';

      test('should return cached server info when available', () async {
        // Arrange
        final cachedServerInfo = QuickConnectServerInfoModel(
          externalDomain: 'cached.example.com',
          internalIp: '192.168.1.200',
          port: 5001,
          protocol: 'https',
          isOnline: true,
        );

        when(() => mockLocalDataSource.getCachedServerInfo(quickConnectId))
            .thenAnswer((_) async => Right(cachedServerInfo));

        // Act
        final result = await repository.resolveAddress(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (result) {
            expect(result.externalDomain, 'cached.example.com');
            expect(result.internalIp, '192.168.1.200');
            expect(result.port, 5001);
          },
        );

        verify(() => mockLocalDataSource.getCachedServerInfo(quickConnectId)).called(1);
        verifyNever(() => mockRemoteDataSource.resolveAddress(quickConnectId));
      });

      test('should fallback to remote when cache is empty', () async {
        // Arrange
        final remoteServerInfo = QuickConnectServerInfoModel(
          externalDomain: 'remote.example.com',
          internalIp: '192.168.1.300',
          port: 5002,
          protocol: 'https',
          isOnline: true,
        );

        when(() => mockLocalDataSource.getCachedServerInfo(quickConnectId))
            .thenAnswer((_) async => const Right(null));
        when(() => mockRemoteDataSource.resolveAddress(quickConnectId))
            .thenAnswer((_) async => Right(remoteServerInfo));
        when(() => mockLocalDataSource.cacheServerInfo(quickConnectId, remoteServerInfo))
            .thenAnswer((_) async => const Right(true));

        // Act
        final result = await repository.resolveAddress(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (result) {
            expect(result.externalDomain, 'remote.example.com');
            expect(result.internalIp, '192.168.1.300');
            expect(result.port, 5002);
          },
        );

        verify(() => mockLocalDataSource.getCachedServerInfo(quickConnectId)).called(1);
        verify(() => mockRemoteDataSource.resolveAddress(quickConnectId)).called(1);
        verify(() => mockLocalDataSource.cacheServerInfo(quickConnectId, remoteServerInfo)).called(1);
      });

      test('should return failure when both cache and remote fail', () async {
        // Arrange
        when(() => mockLocalDataSource.getCachedServerInfo(quickConnectId))
            .thenAnswer((_) async => const Right(null));
        when(() => mockRemoteDataSource.resolveAddress(quickConnectId))
            .thenAnswer((_) async => const Left(NetworkFailure('Network error')));

        // Act
        final result = await repository.resolveAddress(quickConnectId);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, 'Network error');
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('testConnection', () {
      const address = 'test.example.com';
      const port = 5000;

      test('should return connection status when test is successful', () async {
        // Arrange
        final connectionStatus = QuickConnectConnectionStatusModel(
          isConnected: true,
          responseTime: 150,
          errorMessage: null,
          serverInfo: null,
        );

        when(() => mockRemoteDataSource.testConnection(address, port: port))
            .thenAnswer((_) async => Right(connectionStatus));

        // Act
        final result = await repository.testConnection(address, port: port);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (result) {
            expect(result.isConnected, true);
            expect(result.responseTime, 150);
            expect(result.errorMessage, isNull);
          },
        );

        verify(() => mockRemoteDataSource.testConnection(address, port: port)).called(1);
      });

      test('should return failure when connection test fails', () async {
        // Arrange
        when(() => mockRemoteDataSource.testConnection(address, port: port))
            .thenAnswer((_) async => const Left(NetworkFailure('Connection timeout')));

        // Act
        final result = await repository.testConnection(address, port: port);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, 'Connection timeout');
          },
          (_) => fail('Should not return success'),
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
        final loginResult = QuickConnectLoginResultModel(
          isSuccess: true,
          sid: 'test-sid-123',
          redirectUrl: 'https://test.example.com:5000/webman/index.cgi',
          errorMessage: null,
          requireOTP: false,
        );

        when(() => mockRemoteDataSource.login(
          address: address,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: true,
          port: port,
        )).thenAnswer((_) async => Right(loginResult));

        when(() => mockLocalDataSource.cacheCredentials(
          address,
          username,
          password,
          true,
        )).thenAnswer((_) async => const Right(true));

        // Act
        final result = await repository.login(
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
          (result) {
            expect(result.isSuccess, true);
            expect(result.sid, 'test-sid-123');
            expect(result.redirectUrl, 'https://test.example.com:5000/webman/index.cgi');
          },
        );

        verify(() => mockRemoteDataSource.login(
          address: address,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: true,
          port: port,
        )).called(1);
        verify(() => mockLocalDataSource.cacheCredentials(
          address,
          username,
          password,
          true,
        )).called(1);
      });

      test('should not cache credentials when rememberMe is false', () async {
        // Arrange
        final loginResult = QuickConnectLoginResultModel(
          isSuccess: true,
          sid: 'test-sid-123',
          redirectUrl: 'https://test.example.com:5000/webman/index.cgi',
          errorMessage: null,
          requireOTP: false,
        );

        when(() => mockRemoteDataSource.login(
          address: address,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: false,
          port: port,
        )).thenAnswer((_) async => Right(loginResult));

        // Act
        final result = await repository.login(
          address: address,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: false,
          port: port,
        );

        // Assert
        expect(result.isRight(), isTrue);
        verifyNever(() => mockLocalDataSource.cacheCredentials(any(), any(), any(), any()));
      });

      test('should return failure when login fails', () async {
        // Arrange
        when(() => mockRemoteDataSource.login(
          address: address,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: false,
          port: port,
        )).thenAnswer((_) async => const Left(AuthFailure('Invalid credentials')));

        // Act
        final result = await repository.login(
          address: address,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: false,
          port: port,
        );

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<AuthFailure>());
            expect(failure.message, 'Invalid credentials');
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('smartLogin', () {
      const quickConnectId = 'test-quickconnect-id';
      const username = 'testuser';
      const password = 'testpass';
      const otpCode = '123456';

      test('should return login result when smart login is successful', () async {
        // Arrange
        final loginResult = QuickConnectLoginResultModel(
          isSuccess: true,
          sid: 'smart-login-sid-123',
          redirectUrl: 'https://test.example.com:5000/webman/index.cgi',
          errorMessage: null,
          requireOTP: false,
        );

        when(() => mockRemoteDataSource.smartLogin(
          quickConnectId: quickConnectId,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: true,
        )).thenAnswer((_) async => Right(loginResult));

        // Act
        final result = await repository.smartLogin(
          quickConnectId: quickConnectId,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: true,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (result) {
            expect(result.isSuccess, true);
            expect(result.sid, 'smart-login-sid-123');
            expect(result.redirectUrl, 'https://test.example.com:5000/webman/index.cgi');
          },
        );

        verify(() => mockRemoteDataSource.smartLogin(
          quickConnectId: quickConnectId,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: true,
        )).called(1);
      });

      test('should return failure when smart login fails', () async {
        // Arrange
        when(() => mockRemoteDataSource.smartLogin(
          quickConnectId: quickConnectId,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: false,
        )).thenAnswer((_) async => const Left(ServerFailure('No available addresses')));

        // Act
        final result = await repository.smartLogin(
          quickConnectId: quickConnectId,
          username: username,
          password: password,
          otpCode: otpCode,
          rememberMe: false,
        );

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'No available addresses');
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('getPerformanceStats', () {
      const quickConnectId = 'test-quickconnect-id';

      test('should return remote performance stats when available', () async {
        // Arrange
        final performanceStats = QuickConnectPerformanceStatsModel(
          responseTime: 150,
          uptime: 86400,
          connections: 100,
          errors: 5,
        );

        when(() => mockRemoteDataSource.getPerformanceStats(quickConnectId))
            .thenAnswer((_) async => Right(performanceStats));

        when(() => mockLocalDataSource.cachePerformanceStats(quickConnectId, performanceStats))
            .thenAnswer((_) async => const Right(true));

        // Act
        final result = await repository.getPerformanceStats(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (result) {
            expect(result.responseTime, 150);
            expect(result.uptime, 86400);
            expect(result.connections, 100);
            expect(result.errors, 5);
          },
        );

        verify(() => mockRemoteDataSource.getPerformanceStats(quickConnectId)).called(1);
        verify(() => mockLocalDataSource.cachePerformanceStats(quickConnectId, performanceStats)).called(1);
      });

      test('should fallback to cached performance stats when remote fails', () async {
        // Arrange
        final cachedPerformanceStats = QuickConnectPerformanceStatsModel(
          responseTime: 200,
          uptime: 43200,
          connections: 50,
          errors: 2,
        );

        when(() => mockRemoteDataSource.getPerformanceStats(quickConnectId))
            .thenAnswer((_) async => const Left(NetworkFailure('Network error')));
        when(() => mockLocalDataSource.getCachedPerformanceStats(quickConnectId))
            .thenAnswer((_) async => Right(cachedPerformanceStats));

        // Act
        final result = await repository.getPerformanceStats(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (result) {
            expect(result.responseTime, 200);
            expect(result.uptime, 43200);
            expect(result.connections, 50);
            expect(result.errors, 2);
          },
        );

        verify(() => mockRemoteDataSource.getPerformanceStats(quickConnectId)).called(1);
        verify(() => mockLocalDataSource.getCachedPerformanceStats(quickConnectId)).called(1);
      });

      test('should return failure when both remote and cache fail', () async {
        // Arrange
        when(() => mockRemoteDataSource.getPerformanceStats(quickConnectId))
            .thenAnswer((_) async => const Left(NetworkFailure('Network error')));
        when(() => mockLocalDataSource.getCachedPerformanceStats(quickConnectId))
            .thenAnswer((_) async => const Right(null));

        // Act
        final result = await repository.getPerformanceStats(quickConnectId);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, 'Network error');
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('cleanupExpiredCache', () {
      test('should cleanup expired cache successfully', () async {
        // Arrange
        when(() => mockLocalDataSource.cleanupExpiredCache())
            .thenAnswer((_) async => const Right(5));

        // Act
        final result = await repository.cleanupExpiredCache();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cleanedCount) => expect(cleanedCount, 5),
        );

        verify(() => mockLocalDataSource.cleanupExpiredCache()).called(1);
      });

      test('should return failure when cleanup fails', () async {
        // Arrange
        when(() => mockLocalDataSource.cleanupExpiredCache())
            .thenAnswer((_) async => const Left(CacheFailure('Cleanup failed')));

        // Act
        final result = await repository.cleanupExpiredCache();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Cleanup failed');
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('getCacheStats', () {
      test('should return cache statistics successfully', () async {
        // Arrange
        final cacheStats = {
          'totalEntries': 10,
          'validEntries': 8,
          'expiredEntries': 2,
          'cacheSize': 1024,
        };

        when(() => mockLocalDataSource.getCacheStats())
            .thenAnswer((_) async => Right(cacheStats));

        // Act
        final result = await repository.getCacheStats();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (stats) {
            expect(stats['totalEntries'], 10);
            expect(stats['validEntries'], 8);
            expect(stats['expiredEntries'], 2);
            expect(stats['cacheSize'], 1024);
          },
        );

        verify(() => mockLocalDataSource.getCacheStats()).called(1);
      });

      test('should return failure when getting cache stats fails', () async {
        // Arrange
        when(() => mockLocalDataSource.getCacheStats())
            .thenAnswer((_) async => const Left(CacheFailure('Failed to get stats')));

        // Act
        final result = await repository.getCacheStats();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Failed to get stats');
          },
          (_) => fail('Should not return success'),
        );
      });
    });
  });
}
