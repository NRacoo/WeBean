import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:webean/model/profile_model.dart';

class ProfileService {
  static const String baseUrl = "http://localhost:3000";

  Future<ProfileModel> getProfile({
    required String token,
    required String username,
  }) async {
    final response = await http.get(
      Uri.parse("$baseUrl/profile/me?username=$username"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final res = jsonDecode(response.body);
    debugPrint('LOGIN RESPONSE: $res');

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(res['data']);
    }else{
        throw Exception(res['message'] ?? 'Failed fetch profile');
    }
  }
}
