import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:webean/utils/secure_storage.dart';

class AuthService {
  static const String baseUrl = "https://webean-user-service.vercel.app";

  static Future<void> register({
    required String username,
    required String password,
    required String email,
    required String phone,
    required String address,
    required String birth,
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
        "birth": birth,
      }),
    );

    if (response.body.isEmpty) {
      throw FormatException('empty response');
    }
    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    if (response.statusCode != 201 && response.statusCode == 400) {
      final res = jsonDecode(response.body);
      throw Exception(res['message'] ?? 'Registration failed');
    }
  }

  static Future<void> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse("$baseUrl/user/login");
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"username": username, "password": password}),
    );
    debugPrint("response: ${response.body}");

    if (response.body.isEmpty) {
      throw FormatException('empty response');
    }
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

  static Future<void> verify({required String token}) async {
    final uri = Uri.parse("$baseUrl/user/verify-email");
    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.body.isEmpty) {
      throw FormatException('empty response');
    }
    final res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(res['message'] ?? 'Failed to verify');
    }
  }
}
