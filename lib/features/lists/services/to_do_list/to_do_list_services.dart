import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ournest/features/lists/services/to_do_list/to_do_list_model.dart';
import '../../../../core/utils/api_constants.dart';

class TodoService {
  static const String baseUrl = "${ApiConstants.baseUrl}/todo";

  /// GET ALL TODOS
  static Future<List<Todo>> getTodos(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      final List data = decoded is List
          ? decoded
          : decoded['data'];

      return data.map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load todos");
    }
  }

  /// TOGGLE TODO (IMPORTANT FIX)
  static Future<void> toggleTodo(String id, String token) async {
    final url = Uri.parse("$baseUrl/$id/toggle");

    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Failed to toggle todo");
    }
  }

  /// ADD TODO
  static Future<void> addTodo(String title, String token) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "title": title,
        "description": "",
        "dueDate": "",
        "priority": 1,
        "category": "General",
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add todo");
    }
  }
}