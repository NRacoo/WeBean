import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webean/utils/secure_storage.dart';

class AuthService {
  static const String baseUrl = "http://localhost:3000";

  static Future<void> register({
    required String username,
    required String password,
    required String email,
    required String phone,
    required String address,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/user/create"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "address": address,
      }),
    );

    if (response.statusCode != 201 && response.statusCode == 400) {
      final res = jsonDecode(response.body);
      throw Exception(res['message'] ?? 'Registration failed');
    }
  }

  static Future<void> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/user/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"username": username, "password": password}),
    );

    final res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final username = res['result']['username'];
      final token = res['access_token'];
      await SecureStorage.saveToken(token);
      await SecureStorage.saveUsername(username);
    } else {
      throw Exception(res['message'] ?? 'username or password not match');
    }
  }
}
