import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<http.Response> getRequest(String endpoint) async {
    final response = await http.get(Uri.parse('[5m$baseUrl/endpoint')); 
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Add more methods to handle POST, PUT, DELETE requests if needed
}