
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthAPI {
  static const String _baseUrl = 'https://example.com/api/auth';

  /// Login API call
  /// Sends `email` and `password` to the server and retrieves user details.
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    // Uncomment below when enabling the API
    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   throw Exception('Failed to login');
    // }

    // Placeholder for now
    return {'status': 'success', 'userType': email == 'superadmin@super.com' ? 'superadmin' : 'user'};
  }

  /// Signup API call
  /// Sends `email`, `password`, and other details to register a new user.
  static Future<bool> signUp(Map<String, dynamic> userData) async {
    final url = Uri.parse('$_baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    // Uncomment below when enabling the API
    // return response.statusCode == 201;

    // Placeholder for now
    return true;
  }
}
