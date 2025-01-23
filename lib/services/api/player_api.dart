
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlayerAPI {
  static const String _baseUrl = 'https://example.com/api/players';

  /// Add a new player
  static Future<bool> addPlayer(Map<String, dynamic> playerData) async {
    final url = Uri.parse('$_baseUrl/add');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(playerData),
    );

    // Uncomment below when enabling the API
    // return response.statusCode == 201;

    // Placeholder for now
    return true;
  }

  /// Edit/Update an existing player
  static Future<bool> updatePlayer(String id, Map<String, dynamic> updatedData) async {
    final url = Uri.parse('$_baseUrl/update/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    // Uncomment below when enabling the API
    // return response.statusCode == 200;

    // Placeholder for now
    return true;
  }

  /// Delete a player
  static Future<bool> deletePlayer(String id) async {
    final url = Uri.parse('$_baseUrl/delete/$id');
    final response = await http.delete(url);

    // Uncomment below when enabling the API
    // return response.statusCode == 200;

    // Placeholder for now
    return true;
  }
}
