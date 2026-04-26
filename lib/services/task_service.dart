import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../models/task_model.dart';

class TaskService {
  final String baseUrl = 'https://tasktrove-three.vercel.app/api';
  final AuthService _authService = AuthService();

  // 1. Fungsi ambil list tugas (GET)
  Future<List<TaskModel>> getTasks() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => TaskModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal ambil data tugas');
    }
  }

  // 2. Fungsi tambah tugas baru (POST)
  Future<bool> createTask(
    String courseName,
    String taskDesc,
    String? link,
  ) async {
    final token = await _authService.getToken();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'course_name': courseName,
          'task_desc': taskDesc,
          'link': link,
          'status': 'Pending', // Status awal otomatis Pending
        }),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Error tambah tugas: $e');
      return false;
    }
  }

  // 3. Fungsi Edit/Update tugas (PATCH)
  Future<bool> updateTask(int id, Map<String, dynamic> data) async {
    final token = await _authService.getToken();
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/tasks/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error update tugas: $e');
      return false;
    }
  }

  // 4. Fungsi Hapus tugas (DELETE)
  Future<bool> deleteTask(int id) async {
    final token = await _authService.getToken();
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/tasks/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error hapus tugas: $e');
      return false;
    }
  }
}
