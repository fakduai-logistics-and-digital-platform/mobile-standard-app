// lib/domain/http_client/ip.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class IpClient {
  String? apiUrl = dotenv.env['API_CHECK_IP'];

  IpClient({this.apiUrl});

  // ฟังก์ชันนี้จะดึงข้อมูลไอพีจาก API
  Future<String> getIp() async {
    try {
      final response = await http.get(Uri.parse(apiUrl!));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['ip'];
      } else {
        throw Exception('Failed to load IP');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching IP: $e');
    }
  }
}
