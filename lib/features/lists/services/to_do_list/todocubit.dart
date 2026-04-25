import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ournest/features/lists/services/to_do_list/to_do_list_model.dart';
import 'package:ournest/features/lists/services/to_do_list/to_do_list_services.dart';

class TodoState {
  final List<TodoModel> todos;
  final bool loading;

  TodoState({required this.todos, required this.loading});

  TodoState copyWith({
    List<TodoModel>? todos,
    bool? loading,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      loading: loading ?? this.loading,
    );
  }
}

class TodoCubit extends Cubit<TodoState> {
  final TodoService service;

  TodoCubit(this.service)
      : super(TodoState(todos: [], loading: false));

  /// GET
  Future<void> loadTodos() async {
    try {
      emit(state.copyWith(loading: true));

      final data = await service.getTodos();

      data.sort((a, b) {
        if (a.isCompleted == b.isCompleted) return 0;
        return a.isCompleted ? 1 : -1;
      });

      emit(state.copyWith(
        todos: data,
        loading: false,
      ));
    } catch (e) {
      print("ERROR loading todos: $e");

      emit(state.copyWith(
        loading: false,
      ));
    }
  }

  /// ADD
  Future<void> addTodo(String title) async {
    try {
      emit(state.copyWith(loading: true));

      await service.addTodo(title);

      await loadTodos();

    } catch (e) {
      print("ERROR ADD TODO: $e");
      emit(state.copyWith(loading: false));
    }
  }

  /// TOGGLE
  Future<void> toggle(String id) async {
    try {
      final updated = await service.toggleTodo(id);

      final list = state.todos.map((e) {
        return e.id == id ? updated : e;
      }).toList();

      emit(state.copyWith(todos: list));
    } catch (e) {
      print("ERROR TOGGLE: $e");
    }
  }
  /// DELETE
  Future<void> delete(String id) async {
    try {
      await service.deleteTodo(id);

      emit(state.copyWith(
        todos: state.todos.where((e) => e.id != id).toList(),
      ));
    } catch (e) {
      print("ERROR DELETE: $e");
    }
  }
  Future<void> update({
    required String id,
    String? title,
    bool? isDone,
    bool? shared,
  }) async {
    try {
      final updated = await service.updateTodo(
        id: id,
        title: title,
        isDone: isDone,
        sharedWithPartner: shared,
      );

      final list = state.todos.map((e) {
        return e.id == id ? updated : e;
      }).toList();

      emit(state.copyWith(todos: list));
    } catch (e) {
      print("ERROR UPDATE: $e");
    }
  }
  Future<void> share(String id, bool value) async {
    try {
      final updated = await service.shareTodo(id, value);

      final list = state.todos.map((e) {
        return e.id == id ? updated : e;
      }).toList();

      emit(state.copyWith(todos: list));
    } catch (e) {
      print("ERROR SHARE: $e");
    }
  }
}