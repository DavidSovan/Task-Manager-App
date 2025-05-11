import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';
import 'auth_service.dart';

class TaskService {
  final String baseUrl;
  final AuthService authService;

  TaskService({required this.baseUrl, required this.authService});

  Future<Map<String, String>> _getHeaders() async {
    final token = await authService.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Task>> getTasks() async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks: ${response.body}');
    }
  }

  Future<Task> createTask(Task task) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Task(
        id: data['task_id'],
        title: task.title,
        description: task.description,
      );
    } else {
      throw Exception('Failed to create task: ${response.body}');
    }
  }

  Future<void> updateTask(Task task) async {
    if (task.id == null) {
      throw Exception('Task ID cannot be null');
    }

    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task: ${response.body}');
    }
  }

  Future<void> deleteTask(int taskId) async {
    final headers = await _getHeaders();
    final response = await http.delete(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode({'id': taskId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task: ${response.body}');
    }
  }
}
