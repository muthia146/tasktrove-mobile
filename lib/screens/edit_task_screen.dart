import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import '../providers/task_provider.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task; // Menerima data tugas yang diklik
  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _courseNameController;
  late TextEditingController _taskDescController;
  late TextEditingController _linkController;
  late String _selectedStatus;

  final TaskService _taskService = TaskService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Isi otomatis form dengan data yang sudah ada
    _courseNameController = TextEditingController(text: widget.task.courseName);
    _taskDescController = TextEditingController(text: widget.task.taskDesc);
    _linkController = TextEditingController(text: widget.task.link ?? '');

    // Pastikan status huruf awalnya besar sesuai Vercel (Pending, In Progress, Done)
    _selectedStatus = widget.task.status;
  }

  void _updateTask() async {
    if (_courseNameController.text.isEmpty ||
        _taskDescController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mata kuliah dan deskripsi harus diisi!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Kirim data baru ke Vercel (PATCH)
    final success = await _taskService.updateTask(widget.task.id, {
      'course_name': _courseNameController.text,
      'task_desc': _taskDescController.text,
      'link': _linkController.text.isEmpty ? null : _linkController.text,
      'status': _selectedStatus, // Status yang baru dipilih
    });

    setState(() => _isLoading = false);

    if (success && mounted) {
      Provider.of<TaskProvider>(
        context,
        listen: false,
      ).fetchTasks(); // Refresh list Home
      Navigator.pop(context); // Tutup halaman edit
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tugas berhasil diubah!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mengubah tugas.'),
            backgroundColor: Colors.red,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Tugas'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _courseNameController,
              decoration: const InputDecoration(
                labelText: 'Mata Kuliah',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _taskDescController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Tugas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _linkController,
              decoration: const InputDecoration(
                labelText: 'Link Referensi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown untuk ganti status
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status Tugas',
                border: OutlineInputBorder(),
              ),
              items: ['Pending', 'In Progress', 'Done'].map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
            const SizedBox(height: 32),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _updateTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'SIMPAN PERUBAHAN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
