import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/entities/todo_item.dart';
import 'package:todo_riverpod/external_interface/repositories/local_data_repository_impl.dart';

final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<TodoItem>>(
  (ref) {
    final localDataRepositoryImpl = ref.read(localDataRepositoryProvider);
    return TodoListNotifier(localDataRepositoryImpl: localDataRepositoryImpl);
  },
);

class TodoListNotifier extends StateNotifier<List<TodoItem>> {
  TodoListNotifier({required this.localDataRepositoryImpl}) : super([]);

  final LocalDataRepositoryImpl localDataRepositoryImpl;

  Future<void> fetchTodoList() async {
    final todoList = await localDataRepositoryImpl.fetchTodoList();
    state = todoList;
  }

  void saveTodoItem({required String title}) {
    localDataRepositoryImpl.saveTodoItem(title: title);
    fetchTodoList();
  }

  void updateTodoItem({
    required int todoId,
    required String title,
    required String content,
  }) {
    localDataRepositoryImpl.updateTodoItem(
        todoId: todoId, title: title, content: content);
    fetchTodoList();
  }

  void deleteTodoItem({
    required int todoId,
  }) {
    localDataRepositoryImpl.deleteTodoItem(todoId: todoId);
    fetchTodoList();
  }
}
