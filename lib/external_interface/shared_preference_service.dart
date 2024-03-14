import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_riverpod/entities/todo_item.dart';

final sharedPreferenceProvider = FutureProvider<SharedPreferences>(
  (ref) async {
    return await SharedPreferences.getInstance();
  },
);

class SharedPreferenceService {
  SharedPreferenceService({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  Future<void> saveTodoItem({required String title, String? content}) async {
    final todoList = sharedPreferences.getStringList('todoListKey') ?? [];
    final maxId = sharedPreferences.getInt('maxId') ?? 0;

    final newTodoItem = TodoItem(todoId: maxId + 1, title: title);
    final encodeData =
        json.encode(newTodoItem.toJson()); // 一度jsonに変換してからでないと保存不可能
    todoList.add(encodeData);

    await sharedPreferences.setStringList('todoListKey', todoList);
    await sharedPreferences.setInt('maxIdKey', maxId + 1);
  }

  List<TodoItem> fetchTodoList() {
    final todoListString = sharedPreferences.getStringList('todoListKey') ?? [];
    return todoListString.map((todoItemString) {
      final todoItem = json.decode(todoItemString) as Map<String, dynamic>;
      return TodoItem.fromJson(todoItem);
    }).toList();
  }
}
