// models.dart

// Dart model for Authentication Responses
class AuthResponse {
  final String token;
  final String refreshToken;

  AuthResponse({required this.token, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }
}

// Dart model for User Data
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

// Dart model for API Responses
class ApiResponse<T> {
  final T data;
  final String message;
  final bool success;

  ApiResponse({required this.data, required this.message, required this.success});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return ApiResponse<T>(
      data: fromJsonT(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
