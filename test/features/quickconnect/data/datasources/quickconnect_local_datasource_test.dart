import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';

import 'package:synoplayer/features/quickconnect/data/datasources/quickconnect_local_datasource.dart';
import 'package:synoplayer/core/error/failures.dart';
import 'package:synoplayer/features/quickconnect/data/models/quickconnect_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('QuickConnectLocalDataSourceImpl', () {
    late QuickConnectLocalDataSourceImpl dataSource;
    late MockSharedPreferences mockPrefs;
    late MockFlutterSecureStorage mockSecureStorage;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      mockSecureStorage = MockFlutterSecureStorage();
      dataSource = QuickConnectLocalDataSourceImpl(
        sharedPreferences: mockPrefs,
        secureStorage: mockSecureStorage,
      );
    });

    group('cacheServerInfo', () {
      const quickConnectId = 'test-quickconnect-id';
      final serverInfo = QuickConnectServerInfoModel(
        externalDomain: 'test.example.com',
        internalIp: '192.168.1.100',
        port: 5000,
        protocol: 'https',
        isOnline: true,
      );

      test('should cache server info successfully', () async {
        // Arrange
        when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);

        // Act
        final result = await dataSource.cacheServerInfo(quickConnectId, serverInfo);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (success) => expect(success, true),
        );

        verify(() => mockPrefs.setString(any(), any())).called(1);
      });

      test('should handle caching failure', () async {
        // Arrange
        when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => false);

        // Act
        final result = await dataSource.cacheServerInfo(quickConnectId, serverInfo);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, contains('Failed to cache server info'));
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('getCachedServerInfo', () {
      const quickConnectId = 'test-quickconnect-id';
      const cachedData = {
        'externalDomain': 'test.example.com',
        'internalIp': '192.168.1.100',
        'port': 5000,
        'protocol': 'https',
        'isOnline': true,
        'timestamp': 1640995200000, // 2022-01-01 00:00:00
      };

      test('should return cached server info when available and not expired', () async {
        // Arrange
        when(() => mockPrefs.getString(any())).thenReturn(
          '{"externalDomain":"test.example.com","internalIp":"192.168.1.100","port":5000,"protocol":"https","isOnline":true,"timestamp":${DateTime.now().millisecondsSinceEpoch}}',
        );

        // Act
        final result = await dataSource.getCachedServerInfo(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedInfo) {
            expect(cachedInfo, isNotNull);
            expect(cachedInfo!.externalDomain, 'test.example.com');
            expect(cachedInfo.internalIp, '192.168.1.100');
            expect(cachedInfo.port, 5000);
            expect(cachedInfo.protocol, 'https');
            expect(cachedInfo.isOnline, true);
          },
        );
      });

      test('should return null when no cached data exists', () async {
        // Arrange
        when(() => mockPrefs.getString(any())).thenReturn(null);

        // Act
        final result = await dataSource.getCachedServerInfo(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedInfo) => expect(cachedInfo, isNull),
        );
      });

      test('should return null when cached data is expired', () async {
        // Arrange
        final expiredTimestamp = DateTime.now().subtract(Duration(hours: 2)).millisecondsSinceEpoch;
        when(() => mockPrefs.getString(any())).thenReturn(
          '{"externalDomain":"test.example.com","internalIp":"192.168.1.100","port":5000,"protocol":"https","isOnline":true,"timestamp":$expiredTimestamp}',
        );

        // Act
        final result = await dataSource.getCachedServerInfo(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedInfo) => expect(cachedInfo, isNull),
        );
      });

      test('should handle invalid JSON data', () async {
        // Arrange
        when(() => mockPrefs.getString(any())).thenReturn('invalid json');

        // Act
        final result = await dataSource.getCachedServerInfo(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedInfo) => expect(cachedInfo, isNull),
        );
      });
    });

    group('cacheCredentials', () {
      const quickConnectId = 'test-quickconnect-id';
      const username = 'testuser';
      const password = 'testpass';
      const rememberMe = true;

      test('should cache credentials successfully', () async {
        // Arrange
        when(() => mockSecureStorage.write(any(), any())).thenAnswer((_) async {});

        // Act
        final result = await dataSource.cacheCredentials(
          quickConnectId,
          username,
          password,
          rememberMe,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (success) => expect(success, true),
        );

        verify(() => mockSecureStorage.write(any(), any())).called(1);
      });

      test('should handle credential caching failure', () async {
        // Arrange
        when(() => mockSecureStorage.write(any(), any())).thenThrow(Exception('Storage error'));

        // Act
        final result = await dataSource.cacheCredentials(
          quickConnectId,
          username,
          password,
          rememberMe,
        );

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, contains('Failed to cache credentials'));
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('getCachedCredentials', () {
      const quickConnectId = 'test-quickconnect-id';

      test('should return cached credentials when available and not expired', () async {
        // Arrange
        final validTimestamp = DateTime.now().millisecondsSinceEpoch;
        when(() => mockSecureStorage.read(any())).thenAnswer((_) async =>
            '{"username":"testuser","password":"testpass","rememberMe":true,"timestamp":$validTimestamp}');

        // Act
        final result = await dataSource.getCachedCredentials(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedCredentials) {
            expect(cachedCredentials, isNotNull);
            expect(cachedCredentials!.username, 'testuser');
            expect(cachedCredentials.password, 'testpass');
            expect(cachedCredentials.rememberMe, true);
          },
        );
      });

      test('should return null when no cached credentials exist', () async {
        // Arrange
        when(() => mockSecureStorage.read(any())).thenAnswer((_) async => null);

        // Act
        final result = await dataSource.getCachedCredentials(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedCredentials) => expect(cachedCredentials, isNull),
        );
      });

      test('should return null when cached credentials are expired', () async {
        // Arrange
        final expiredTimestamp = DateTime.now().subtract(Duration(hours: 3)).millisecondsSinceEpoch;
        when(() => mockSecureStorage.read(any())).thenAnswer((_) async =>
            '{"username":"testuser","password":"testpass","rememberMe":true,"timestamp":$expiredTimestamp}');

        // Act
        final result = await dataSource.getCachedCredentials(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedCredentials) => expect(cachedCredentials, isNull),
        );
      });
    });

    group('cacheConnectionStatus', () {
      const address = 'test.example.com';
      final connectionStatus = QuickConnectConnectionStatusModel(
        isConnected: true,
        responseTime: 150,
        errorMessage: null,
        serverInfo: null,
      );

      test('should cache connection status successfully', () async {
        // Arrange
        when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);

        // Act
        final result = await dataSource.cacheConnectionStatus(address, connectionStatus);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (success) => expect(success, true),
        );

        verify(() => mockPrefs.setString(any(), any())).called(1);
      });
    });

    group('getCachedConnectionStatus', () {
      const address = 'test.example.com';

      test('should return cached connection status when available and not expired', () async {
        // Arrange
        final validTimestamp = DateTime.now().millisecondsSinceEpoch;
        when(() => mockPrefs.getString(any())).thenReturn(
          '{"isConnected":true,"responseTime":150,"errorMessage":null,"serverInfo":null,"timestamp":$validTimestamp}',
        );

        // Act
        final result = await dataSource.getCachedConnectionStatus(address);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedStatus) {
            expect(cachedStatus, isNotNull);
            expect(cachedStatus!.isConnected, true);
            expect(cachedStatus.responseTime, 150);
            expect(cachedStatus.errorMessage, isNull);
          },
        );
      });

      test('should return null when cached connection status is expired', () async {
        // Arrange
        final expiredTimestamp = DateTime.now().subtract(Duration(minutes: 31)).millisecondsSinceEpoch;
        when(() => mockPrefs.getString(any())).thenReturn(
          '{"isConnected":true,"responseTime":150,"errorMessage":null,"serverInfo":null,"timestamp":$expiredTimestamp}',
        );

        // Act
        final result = await dataSource.getCachedConnectionStatus(address);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedStatus) => expect(cachedStatus, isNull),
        );
      });
    });

    group('cachePerformanceStats', () {
      const quickConnectId = 'test-quickconnect-id';
      final performanceStats = QuickConnectPerformanceStatsModel(
        responseTime: 150,
        uptime: 86400,
        connections: 100,
        errors: 5,
      );

      test('should cache performance stats successfully', () async {
        // Arrange
        when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);

        // Act
        final result = await dataSource.cachePerformanceStats(quickConnectId, performanceStats);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (success) => expect(success, true),
        );

        verify(() => mockPrefs.setString(any(), any())).called(1);
      });
    });

    group('getCachedPerformanceStats', () {
      const quickConnectId = 'test-quickconnect-id';

      test('should return cached performance stats when available and not expired', () async {
        // Arrange
        final validTimestamp = DateTime.now().millisecondsSinceEpoch;
        when(() => mockPrefs.getString(any())).thenReturn(
          '{"responseTime":150,"uptime":86400,"connections":100,"errors":5,"timestamp":$validTimestamp}',
        );

        // Act
        final result = await dataSource.getCachedPerformanceStats(quickConnectId);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cachedStats) {
            expect(cachedStats, isNotNull);
            expect(cachedStats!.responseTime, 150);
            expect(cachedStats.uptime, 86400);
            expect(cachedStats.connections, 100);
            expect(cachedStats.errors, 5);
          },
        );
      });
    });

    group('cleanupExpiredCache', () {
      test('should cleanup expired cache entries successfully', () async {
        // Arrange
        final keys = [
          'server_info_test1',
          'server_info_test2',
          'connection_status_test1',
          'performance_stats_test1',
        ];
        
        when(() => mockPrefs.getKeys()).thenReturn(keys.toSet());
        when(() => mockPrefs.getString(any())).thenReturn(null);
        when(() => mockPrefs.remove(any())).thenAnswer((_) async => true);

        // Act
        final result = await dataSource.cleanupExpiredCache();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (cleanedCount) => expect(cleanedCount, 0), // All entries are null
        );

        verify(() => mockPrefs.getKeys()).called(1);
      });

      test('should handle cleanup errors gracefully', () async {
        // Arrange
        when(() => mockPrefs.getKeys()).thenThrow(Exception('Storage error'));

        // Act
        final result = await dataSource.cleanupExpiredCache();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, contains('Failed to cleanup expired cache'));
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('clearAllCache', () {
      test('should clear all cache successfully', () async {
        // Arrange
        when(() => mockPrefs.clear()).thenAnswer((_) async => true);
        when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async {});

        // Act
        final result = await dataSource.clearAllCache();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (success) => expect(success, true),
        );

        verify(() => mockPrefs.clear()).called(1);
        verify(() => mockSecureStorage.deleteAll()).called(1);
      });

      test('should handle cache clearing errors', () async {
        // Arrange
        when(() => mockPrefs.clear()).thenAnswer((_) async => false);

        // Act
        final result = await dataSource.clearAllCache();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, contains('Failed to clear cache'));
          },
          (_) => fail('Should not return success'),
        );
      });
    });

    group('getCacheStats', () {
      test('should return cache statistics successfully', () async {
        // Arrange
        final keys = [
          'server_info_test1',
          'server_info_test2',
          'connection_status_test1',
          'performance_stats_test1',
        ];
        
        when(() => mockPrefs.getKeys()).thenReturn(keys.toSet());
        when(() => mockPrefs.getString(any())).thenReturn('valid data');

        // Act
        final result = await dataSource.getCacheStats();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (stats) {
            expect(stats['totalEntries'], 4);
            expect(stats['validEntries'], 4);
            expect(stats['expiredEntries'], 0);
            expect(stats['cacheSize'], isA<int>());
          },
        );
      });

      test('should handle cache stats errors', () async {
        // Arrange
        when(() => mockPrefs.getKeys()).thenThrow(Exception('Storage error'));

        // Act
        final result = await dataSource.getCacheStats();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, contains('Failed to get cache stats'));
          },
          (_) => fail('Should not return success'),
        );
      });
    });
  });
}
