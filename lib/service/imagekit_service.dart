import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:webean/utils/secure_storage.dart';

class ImagekitService {
  static const String baseUrl = "http://localhost:3000";

  Future<Map<String, dynamic>> getImageKitAuth() async {
    final token = await SecureStorage.getToken();

    final res = await http.get(
      Uri.parse("$baseUrl/profile/image/auth"),
      headers: {"Authorization": "Bearer $token"},
    );

    return jsonDecode(res.body);
  }

  Future<String> uploadImageKit(XFile file) async {
  final auth = await getImageKitAuth();

  debugPrint('AUTH PARAMS: $auth');

  if (auth['token'] == null ||
      auth['signature'] == null ||
      auth['expire'] == null) {
    throw Exception('Auth ImageKit tidak lengkap: $auth');
  }

  final request = http.MultipartRequest(
    'POST',
    Uri.parse('https://upload.imagekit.io/api/v1/files/upload'),
  );

  request.fields.addAll({
    'token': auth['token'],
    'signature': auth['signature'],
    'expire': auth['expire'].toString(),
    'publicKey': 'public_D0r33UM3gJydatW7BXwHq+NLKww=',
    'fileName': file.name,
  });

  request.files.add(await http.MultipartFile.fromPath('file', file.path));

  final streamed = await request.send();
  final response = await http.Response.fromStream(streamed);

  debugPrint("ImageKit status: ${response.statusCode}");
  debugPrint("ImageKit body: ${response.body}");

  final data = jsonDecode(response.body);

  if (data['url'] == null) {
    throw Exception('ImageKit tidak mengembalikan url');
  }

  return data['url'];
}

  Future<void> saveImageUrl(String imageUrl) async {
    final token = await SecureStorage.getToken();

    await http.patch(
      Uri.parse("$baseUrl/profile/image"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({'imageUrl': imageUrl}),
    );
  }
}
