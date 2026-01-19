import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<void> saveUsername(String username) async {
    await _storage.write(key: 'username', value: username);
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: 'token');
    debugPrint("TOKEN: $token");
    return token;
  }

  static Future<String?> getUsername() async {
    final username = await _storage.read(key: 'username');
    debugPrint("USERNAME: $username");
    return username;
  }

  static Future<void> logout() async {
    return await _storage.deleteAll();
  }
}
