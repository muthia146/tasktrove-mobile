import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getter supaya datanya bisa dibaca oleh UI
  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final TaskService _taskService = TaskService();

  // Fungsi untuk mengambil data dari Service
  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners(); // Menyuruh UI menampilkan muter-muter loading

    try {
      _tasks = await _taskService.getTasks();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Gagal mengambil data tugas. Coba lagi.';
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners(); // Menyuruh UI mematikan muter-muter loading
    }
  }
}
