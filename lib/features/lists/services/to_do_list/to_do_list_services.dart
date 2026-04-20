import 'package:dio/dio.dart';
import '../../../../core/cubit/dio_interceptor.dart';
import 'to_do_list_model.dart';

class TodoService {

  /// GET
  Future<List<TodoModel>> getTodos() async {
    final res = await DioClient.dio.get("/todo");

    final data = res.data as List;
    return data.map((e) => TodoModel.fromJson(e)).toList();
  }

  /// CREATE
  Future<TodoModel> addTodo(String title) async {
    final res = await DioClient.dio.post(
      "/todo",
      data: {
        "title": title,
        "description": "",
        "dueDate": null,
        "priority": 0,
        "category": null
      },
    );

    return TodoModel.fromJson(res.data);
  }

  /// TOGGLE
  Future<TodoModel> toggleTodo(String id) async {
    final res = await DioClient.dio.patch("/todo/$id/toggle");

    return TodoModel.fromJson(res.data);
  }

  /// DELETE
  Future<void> deleteTodo(String id) async {
    await DioClient.dio.delete("/todo/$id");
  }
}