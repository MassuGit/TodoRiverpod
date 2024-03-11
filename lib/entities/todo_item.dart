import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_item.freezed.dart';
part 'todo_item.g.dart';

@freezed
class TodoItem with _$TodoItem {
  factory TodoItem({
    required int todoId,
    @Default('') String title,
    @Default('') String content,
  }) = _TodoItem;

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
}
