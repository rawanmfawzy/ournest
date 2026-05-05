import 'package:dio/dio.dart';
import '../../../../core/cubit/dio_interceptor.dart';
import 'to_do_list_model.dart';
class TodoService {

  /// GET ALL
  Future<List<TodoModel>> getTodos() async {
    final res = await DioClient.dio.get("/tasks");
    final data = res.data as List;
    return data.map((e) => TodoModel.fromJson(e)).toList();
  }

  /// CREATE
  Future<TodoModel> addTodo(String title) async {
    final res = await DioClient.dio.post(
      "/tasks",
      data: {
        "title": title,
        "description": "",
        "dueDate": null,
        "priority": 0,
        "category": null,
        "sharedWithPartner": false
      },
    );
    return TodoModel.fromJson(res.data);
  }

  /// TOGGLE DONE
  Future<TodoModel> toggleTodo(String id) async {
    final res = await DioClient.dio.patch("/tasks/$id/toggle");
    return TodoModel.fromJson(res.data);
  }

  /// UPDATE (title / done / shared)
  Future<TodoModel> updateTodo({
    required String id,
    String? title,
    bool? isDone,
    bool? sharedWithPartner,
  }) async {
    final res = await DioClient.dio.put(
      "/tasks/$id",
      data: {
        "task": title,
        "isDone": isDone,
        "sharedWithPartner": sharedWithPartner,
      },
    );

    return TodoModel.fromJson(res.data);
  }

  /// SHARE ONLY
  Future<TodoModel> shareTodo(String id, bool value) async {
    final res = await DioClient.dio.patch(
      "/tasks/$id/share",
      data: {
        "sharedWithPartner": value,
      },
    );

    return TodoModel.fromJson(res.data);
  }

  /// DELETE
  Future<void> deleteTodo(String id) async {
    await DioClient.dio.delete("/tasks/$id");
  }
}