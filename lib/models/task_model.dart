class TaskModel {
  final int id;
  final String courseName;
  final String taskDesc;
  final String? link;
  final String status;

  TaskModel({
    required this.id,
    required this.courseName,
    required this.taskDesc,
    this.link,
    required this.status,
  });

  // Fungsi untuk mengubah JSON dari API menjadi Object Dart
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      courseName: json['course_name'] ?? '',
      taskDesc: json['task_desc'] ?? '',
      link: json['link'],
      status: json['status'] ?? 'Pending',
    );
  }
}
