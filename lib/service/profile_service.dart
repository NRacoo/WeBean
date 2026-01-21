import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:webean/model/profile_model.dart';
import 'package:webean/route/app_route.dart';
import 'package:webean/utils/secure_storage.dart';

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
    debugPrint('GET PROFILE RESPONSE: $res');

    if (response.statusCode == 401) {
      await SecureStorage.logout();

      Get.offAllNamed(AppRoute.login);

      throw Exception('Session expired. Please login again');
    }

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(res['data']);
    } else {
      throw Exception(res['message'] ?? 'Failed fetch profile');
    }
  }

  Future<void> updateProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    if (data.isEmpty) {
      return;
    }

    final response = await http.patch(
      Uri.parse("$baseUrl/profile/update-profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );

    final resp = jsonDecode(response.body);
    debugPrint('response update: $resp');

    if (response.statusCode != 201) {
      final res = jsonDecode(response.body);
      throw Exception(res['message'] ?? 'update gagal');
    }
  }
}
