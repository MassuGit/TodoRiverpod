import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_riverpod/entities/todo_item.dart';

class SharedPreferenceService {
  SharedPreferenceService();

  Future<void> saveTodoItem({required String title, String? content}) async {
    final preference = await SharedPreferences.getInstance();

    final todoList = preference.getStringList('todoListKey') ?? [];
    final maxId = preference.getInt('maxId') ?? 0;

    final newTodoItem = TodoItem(todoId: maxId + 1, title: title);
    final encodeData =
        json.encode(newTodoItem.toJson()); // 一度jsonに変換してからでないと保存不可能
    todoList.add(encodeData);

    await preference.setStringList('todoListKey', todoList);
    await preference.setInt('maxIdKey', maxId + 1);
    print("保存に成功しました");
  }
}
