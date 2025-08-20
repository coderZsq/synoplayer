// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickConnectRequestImpl _$$QuickConnectRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectRequestImpl(
      getCaFingerprints: json['get_ca_fingerprints'] as bool,
      id: json['id'] as String,
      serverId: json['serverID'] as String,
      command: json['command'] as String,
      version: json['version'] as String,
    );

Map<String, dynamic> _$$QuickConnectRequestImplToJson(
        _$QuickConnectRequestImpl instance) =>
    <String, dynamic>{
      'get_ca_fingerprints': instance.getCaFingerprints,
      'id': instance.id,
      'serverID': instance.serverId,
      'command': instance.command,
      'version': instance.version,
    };

_$QuickConnectResponseImpl _$$QuickConnectResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectResponseImpl(
      command: json['command'] as String,
      errinfo: json['errinfo'] as String,
      errno: _toString(json['errno']),
      sites: (json['sites'] as List<dynamic>).map((e) => e as String).toList(),
      suberrno: _toString(json['suberrno']),
      version: _toString(json['version']),
    );

Map<String, dynamic> _$$QuickConnectResponseImplToJson(
        _$QuickConnectResponseImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'errinfo': instance.errinfo,
      'errno': instance.errno,
      'sites': instance.sites,
      'suberrno': instance.suberrno,
      'version': instance.version,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _QuickConnectApi implements QuickConnectApi {
  _QuickConnectApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<QuickConnectResponse> getServerInfo(
      QuickConnectRequest request) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = request;
    final _options = _setStreamType<QuickConnectResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'https://global.quickconnect.to/Serv.php',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late QuickConnectResponse _value;
    try {
      _value = QuickConnectResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
