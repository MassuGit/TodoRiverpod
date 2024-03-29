import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_riverpod/entities/todo_item.dart';
import 'package:todo_riverpod/external_interface/shared_preference_service.dart';

final localDataRepositoryProvider = Provider(
  (ref) => LocalDataRepositoryImpl(
    sharedPreferences: ref.read(sharedPreferenceProvider),
  ),
);

class LocalDataRepositoryImpl {
  LocalDataRepositoryImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  Future<void> saveTodoItem({required String title, String? content}) async {
    final todoList = sharedPreferences.getStringList('todoListKey') ?? [];
    final maxId = sharedPreferences.getInt('maxIdKey') ?? 0;

    final newTodoItem = TodoItem(todoId: maxId + 1, title: title);
    final encodeData =
        json.encode(newTodoItem.toJson()); // 一度jsonに変換してからでないと保存不可能
    todoList.add(encodeData);

    await sharedPreferences.setStringList('todoListKey', todoList);
    await sharedPreferences.setInt('maxIdKey', maxId + 1);
  }

  Future<List<TodoItem>> fetchTodoList() async {
    final todoListString = sharedPreferences.getStringList('todoListKey') ?? [];
    return todoListString.map((todoItemString) {
      final todoItem = json.decode(todoItemString) as Map<String, dynamic>;
      return TodoItem.fromJson(todoItem);
    }).toList();
  }

  Future<void> updateTodoItem(
      {required int todoId,
      required String title,
      required String content}) async {
    // jsonを取得 → 該当todoかどうか確認 →該当するなら更新、でなければもともとの値入れる → 終
    final todoListString = sharedPreferences.getStringList('todoListKey') ?? [];
    final todoListStringUpdated = todoListString.map((todoItemString) {
      // String -> Map<String, dynamic> -> TodoItem
      final todoItem = TodoItem.fromJson(json.decode(todoItemString));
      if (todoItem.todoId == todoId) {
        final todoItemUpdated =
            todoItem.copyWith(title: title, content: content);
        // TodoItem -> Map<String, dynamic> -> String
        return json.encode(todoItemUpdated.toJson());
      } else {
        return todoItemString;
      }
    }).toList();
    await sharedPreferences.setStringList('todoListKey', todoListStringUpdated);
  }

  void deleteTodoItem({
    required int todoId,
  }) {
    final todoListString = sharedPreferences.getStringList('todoListKey') ?? [];
    final todoListStringUpdated = todoListString.where((todoItemString) {
      final todoItem = TodoItem.fromJson(json.decode(todoItemString));
      return todoItem.todoId != todoId;
    }).toList();
    sharedPreferences.setStringList('todoListKey', todoListStringUpdated);
  }

  Future<void> clearAllData() async {
    await sharedPreferences.clear();
  }
}
