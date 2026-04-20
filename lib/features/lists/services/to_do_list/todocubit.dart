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

      final newTodo = await service.addTodo(title);

      emit(state.copyWith(
        todos: [newTodo, ...state.todos],
        loading: false,
      ));
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
}