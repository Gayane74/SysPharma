class ApiConfig {
  static const String baseUrl = 'http://localhost:5000';
  static const String apiPath = '/api';
  
  static String get fullApiUrl => '[30m$baseUrl$apiPath';
  
  // Timeouts
  static const int connectTimeout = 30000; // ms
  static const int receiveTimeout = 30000; // ms
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}