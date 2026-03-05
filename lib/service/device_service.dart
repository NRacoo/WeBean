import 'dart:convert';
import 'package:http/http.dart' as http;

class DeviceApiService {
  static final DeviceApiService _instance = DeviceApiService._internal();
  factory DeviceApiService() => _instance;
  DeviceApiService._internal();

  final String _baseUrl =
      'https://webean-device-production.up.railway.app/device';

  Future<Map<String, dynamic>> getSessions({
    int page = 1,
    int limit = 10,
  }) async {
    final res = await http.get(
      Uri.parse('$_baseUrl/sessions?page=$page&limit=$limit'),
    );

    _checkStatus(res);
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> getSessionsRecord(
    String sessionId, {
    int limit = 100,
  }) async {
    final res = await http.get(
      Uri.parse('$_baseUrl/sessions/$sessionId/records?limit=$limit'),
    );
    _checkStatus(res);
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> getMonthlyHistory({int limit = 12}) async {
    final res = await http.get(Uri.parse('$_baseUrl/monthly?limit=$limit'));
    _checkStatus(res);
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>?> getCurrentMonth() async {
    final res = await http.get(Uri.parse('$_baseUrl/monthly/current'));
    _checkStatus(res);
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> getByYear(int year) async {
    final res = await http.get(Uri.parse('$_baseUrl/monthly/$year'));
    _checkStatus(res);
    return jsonDecode(res.body);
  }

  void _checkStatus(http.Response res) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
  }
}
