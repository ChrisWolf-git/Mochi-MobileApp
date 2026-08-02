import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000";

  Future<String> sendUserData(String name, String mood, int level) async {
    final response = await http.post(
      Uri.parse("$baseUrl/userdata"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "mood": mood,
        "level": level,
      }),
    );

    final data = jsonDecode(response.body);
    return data["message"];
  }

  Future<Map<String, dynamic>> getUserData() async {
    final response = await http.get(Uri.parse("$baseUrl/userdata"));
    return jsonDecode(response.body);
  }
  Future<Map<String, dynamic>> getReaction(String mood) async {
      final response = await http.get(Uri.parse("$baseUrl/reaction/$mood"));
      return jsonDecode(response.body);
  }

}
