import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

class ApiService {
  final http.Client _httpClient = http.Client();

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _httpClient
          .get(
            Uri.parse('[1;32m${ApiConfig.fullApiUrl}$endpoint[0m'),
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(
            const Duration(milliseconds: ApiConfig.connectTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<dynamic> post(String endpoint, {required dynamic data}) async {
    try {
      final response = await _httpClient
          .post(
            Uri.parse('[1;32m${ApiConfig.fullApiUrl}$endpoint[0m'),
            headers: ApiConfig.defaultHeaders,
            body: jsonEncode(data),
          )
          .timeout(
            const Duration(milliseconds: ApiConfig.connectTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<dynamic> put(String endpoint, {required dynamic data}) async {
    try {
      final response = await _httpClient
          .put(
            Uri.parse('[1;32m${ApiConfig.fullApiUrl}$endpoint[0m'),
            headers: ApiConfig.defaultHeaders,
            body: jsonEncode(data),
          )
          .timeout(
            const Duration(milliseconds: ApiConfig.connectTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _httpClient
          .delete(
            Uri.parse('[1;32m${ApiConfig.fullApiUrl}$endpoint[0m'),
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(
            const Duration(milliseconds: ApiConfig.connectTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}