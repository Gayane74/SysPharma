import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://yourapi.com/api'; // Replace with your API base URL
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('\$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    return response.statusCode == 201;
  }

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('\$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      await storage.write(key: 'token', value: jsonResponse['token']);
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>?> getUser() async {
    String? token = await storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('\$baseUrl/user'),
      headers: {'Authorization': 'Bearer \$token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<bool> logout() async {
    await storage.delete(key: 'token');
    return true;
  }
}