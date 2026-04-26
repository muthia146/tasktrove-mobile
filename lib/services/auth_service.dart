import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // URL API Vercel kamu
  final String baseUrl = 'https://tasktrove-three.vercel.app/api';
  final storage = const FlutterSecureStorage();

  // Fungsi untuk Login
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        // Simpan token JWT ke memori HP secara aman
        await storage.write(key: 'jwt_token', value: token);
        return true;
      }
      return false;
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }

  // Tambahkan fungsi ini di dalam class AuthService
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Fungsi ambil token
  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }

  // Fungsi Logout
  Future<void> logout() async {
    await storage.delete(key: 'jwt_token');
  }
}
