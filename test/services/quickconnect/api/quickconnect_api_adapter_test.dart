import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synoplayer/services/quickconnect/api/quickconnect_api_adapter.dart';
import 'package:synoplayer/services/quickconnect/api/quickconnect_api_interface.dart';
import 'package:synoplayer/services/quickconnect/api/quickconnect_retrofit_api.dart';
import 'package:synoplayer/core/network/index.dart';

// Mock classes
class MockApiClient extends Mock implements ApiClient {}
class MockQuickConnectRetrofitApi extends Mock implements QuickConnectRetrofitApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('QuickConnectApiAdapter', () {
    late QuickConnectApiAdapter adapter;
    late MockApiClient mockApiClient;
    late MockQuickConnectRetrofitApi mockRetrofitApi;

    setUp(() {
      mockApiClient = MockApiClient();
      mockRetrofitApi = MockQuickConnectRetrofitApi();
      
      adapter = QuickConnectApiAdapter(
        apiClient: mockApiClient,
        retrofitApi: mockRetrofitApi,
      );
    });

    test('should be created successfully', () {
      expect(adapter, isNotNull);
      expect(adapter, isA<QuickConnectApiAdapter>());
    });

    test('should have required dependencies', () {
      expect(adapter.apiClient, equals(mockApiClient));
      expect(adapter.retrofitApi, equals(mockRetrofitApi));
    });

    test('should implement QuickConnectApiInterface', () {
      expect(adapter, isA<QuickConnectApiInterface>());
    });

    group('basic functionality', () {
      test('should handle tunnel request', () async {
        // This test verifies that the adapter can be instantiated and used
        // without throwing exceptions
        expect(() => adapter.requestTunnel('test_id'), returnsNormally);
      });

      test('should handle server info request', () async {
        expect(() => adapter.requestServerInfo('test_id'), returnsNormally);
      });

      test('should handle login request', () async {
        expect(() => adapter.requestLogin(
          baseUrl: 'https://test.com',
          username: 'test',
          password: 'test',
        ), returnsNormally);
      });

      test('should handle connection test', () async {
        expect(() => adapter.testConnection('https://test.com'), returnsNormally);
      });
    });
  });
}
