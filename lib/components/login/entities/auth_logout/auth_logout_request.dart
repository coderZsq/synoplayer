class AuthLogoutRequest {
  final String? _sid;

  AuthLogoutRequest({String? sid}) : _sid = sid;

  String? get sid => _sid;

  Map<String, dynamic> toJson() {
    return {
      if (_sid != null) 'sid': _sid,
    };
  }

  @override
  String toString() {
    return 'AuthLogoutRequest{sid: $_sid}';
  }
}
