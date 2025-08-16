import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synoplayer/services/quickconnect/api/quickconnect_api_adapter.dart';
import 'package:synoplayer/services/quickconnect/api/quickconnect_retrofit_api.dart';
import 'package:synoplayer/core/network/index.dart';
import 'package:synoplayer/services/quickconnect/models/quickconnect_models.dart';
import 'package:synoplayer/services/quickconnect/models/login_result.dart';

// Mock 类
class MockApiClient extends Mock implements ApiClient {}
class MockQuickConnectRetrofitApi extends Mock implements QuickConnectRetrofitApi {}
class MockApiResponse extends Mock implements ApiResponse<Map<String, dynamic>> {}
class MockTunnelResponse extends Mock implements TunnelResponse {}
class MockServerInfoResponse extends Mock implements ServerInfoResponse {}
class MockQuickConnectServerInfoResponse extends Mock implements QuickConnectServerInfoResponse {}
class MockConnectionTestResult extends Mock implements ConnectionTestResult {}

void main() {
  group('QuickConnectApiAdapter', () {
    late QuickConnectApiAdapter adapter;
    late MockApiClient mockApiClient;
    late MockQuickConnectRetrofitApi mockRetrofitApi;

    setUp(() {
      mockApiClient = MockApiClient();
      mockRetrofitApi = MockQuickConnectRetrofitApi();
    });

    group('when useRetrofit is false', () {
      setUp(() {
        adapter = QuickConnectApiAdapter(
          apiClient: mockApiClient,
          retrofitApi: mockRetrofitApi,
          useRetrofit: false,
        );
      });

      test('should use legacy implementation for tunnel request', () async {
        // Arrange
        final mockResponse = MockApiResponse();
        when(() => mockResponse.when(
          success: any(named: 'success'),
          error: any(named: 'error'),
        )).thenReturn(null);
        
        when(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await adapter.requestTunnel('test_id');

        // Assert
        verify(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).called(1);
        verifyNever(() => mockRetrofitApi.requestTunnel(any()));
      });

      test('should use legacy implementation for server info request', () async {
        // Arrange
        final mockResponse = MockApiResponse();
        when(() => mockResponse.when(
          success: any(named: 'success'),
          error: any(named: 'error'),
        )).thenReturn(null);
        
        when(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await adapter.requestServerInfo('test_id');

        // Assert
        verify(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).called(1);
        verifyNever(() => mockRetrofitApi.requestServerInfo(any()));
      });
    });

    group('when useRetrofit is true', () {
      setUp(() {
        adapter = QuickConnectApiAdapter(
          apiClient: mockApiClient,
          retrofitApi: mockRetrofitApi,
          useRetrofit: true,
        );
      });

      test('should use retrofit implementation for tunnel request', () async {
        // Arrange
        final mockResponse = MockTunnelResponse();
        when(() => mockRetrofitApi.requestTunnel(any()))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await adapter.requestTunnel('test_id');

        // Assert
        verify(() => mockRetrofitApi.requestTunnel(any())).called(1);
        verifyNever(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        ));
      });

      test('should use retrofit implementation for server info request', () async {
        // Arrange
        final mockResponse = MockServerInfoResponse();
        when(() => mockRetrofitApi.requestServerInfo(any()))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await adapter.requestServerInfo('test_id');

        // Assert
        verify(() => mockRetrofitApi.requestServerInfo(any())).called(1);
        verifyNever(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        ));
      });

      test('should fallback to legacy on retrofit failure for tunnel request', () async {
        // Arrange
        when(() => mockRetrofitApi.requestTunnel(any()))
            .thenThrow(Exception('Retrofit error'));
            
        final mockResponse = MockApiResponse();
        when(() => mockResponse.when(
          success: any(named: 'success'),
          error: any(named: 'error'),
        )).thenReturn(null);
        
        when(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await adapter.requestTunnel('test_id');

        // Assert
        verify(() => mockRetrofitApi.requestTunnel(any())).called(1);
        verify(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).called(1);
      });

      test('should fallback to legacy on retrofit failure for server info request', () async {
        // Arrange
        when(() => mockRetrofitApi.requestServerInfo(any()))
            .thenThrow(Exception('Retrofit error'));
            
        final mockResponse = MockApiResponse();
        when(() => mockResponse.when(
          success: any(named: 'success'),
          error: any(named: 'error'),
        )).thenReturn(null);
        
        when(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await adapter.requestServerInfo('test_id');

        // Assert
        verify(() => mockRetrofitApi.requestServerInfo(any())).called(1);
        verify(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).called(1);
      });
    });

    group('input validation', () {
      setUp(() {
        adapter = QuickConnectApiAdapter(
          apiClient: mockApiClient,
          retrofitApi: mockRetrofitApi,
          useRetrofit: false,
        );
      });

      test('should validate username and password for login', () async {
        // Act
        final result = await adapter.requestLogin(
          baseUrl: 'https://test.com',
          username: '',
          password: '',
        );

        // Assert
        expect(result.isSuccess, isFalse);
        expect(result.errorMessage, contains('用户名或密码不能为空'));
      });

      test('should accept valid username and password for login', () async {
        // Arrange
        final mockResponse = MockApiResponse();
        when(() => mockResponse.when(
          success: any(named: 'success'),
          error: any(named: 'error'),
        )).thenReturn(<String, dynamic>{
          'success': true,
          'data': {'sid': 'test_sid'}
        });
        
        when(() => mockApiClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          fromJson: any(named: 'fromJson'),
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await adapter.requestLogin(
          baseUrl: 'https://test.com',
          username: 'test_user',
          password: 'test_pass',
        );

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.sid, equals('test_sid'));
      });
    });
  });
}
