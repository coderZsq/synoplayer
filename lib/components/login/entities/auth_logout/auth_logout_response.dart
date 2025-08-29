class AuthLogoutResponse {
  final bool success;
  final AuthLogoutData? data;
  final AuthLogoutError? error;

  AuthLogoutResponse({
    required this.success,
    this.data,
    this.error,
  });

  factory AuthLogoutResponse.fromJson(Map<String, dynamic> json) {
    return AuthLogoutResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? AuthLogoutData.fromJson(json['data']) : null,
      error: json['error'] != null ? AuthLogoutError.fromJson(json['error']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (data != null) 'data': data!.toJson(),
      if (error != null) 'error': error!.toJson(),
    };
  }

  @override
  String toString() {
    return 'AuthLogoutResponse{success: $success, data: $data, error: $error}';
  }
}

class AuthLogoutData {
  final String? message;

  AuthLogoutData({this.message});

  factory AuthLogoutData.fromJson(Map<String, dynamic> json) {
    return AuthLogoutData(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return 'AuthLogoutData{message: $message}';
  }
}

class AuthLogoutError {
  final int? code;
  final String? message;

  AuthLogoutError({this.code, this.message});

  factory AuthLogoutError.fromJson(Map<String, dynamic> json) {
    return AuthLogoutError(
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (code != null) 'code': code,
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return 'AuthLogoutError{code: $code, message: $message}';
  }
}
