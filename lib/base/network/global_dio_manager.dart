import 'package:dio/dio.dart';

class GlobalDioManager {
  static final GlobalDioManager _instance = GlobalDioManager._internal();
  factory GlobalDioManager() => _instance;
  GlobalDioManager._internal();

  Dio? _globalDio;
  
  Dio get dio => _globalDio!;
  
  void initialize(Dio dio) {
    _globalDio = dio;
  }
  
  void updateBaseUrl(String baseUrl) {
    if (_globalDio != null) {
      _globalDio!.options.baseUrl = baseUrl;
    }
  }
  
  void resetBaseUrl() {
    if (_globalDio != null) {
      _globalDio!.options.baseUrl = '';
    }
  }
}