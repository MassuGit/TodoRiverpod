import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/entities/todo_item.dart';
import 'package:todo_riverpod/external_interface/repositories/local_data_repository_impl.dart';

class UpdateTodoPage extends HookConsumerWidget {
  const UpdateTodoPage({
    super.key,
    required this.todoItemProps,
  });

  final TodoItem todoItemProps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoTitleTextFieldController = useTextEditingController();
    final todoContentTextFieldController = useTextEditingController();

    todoTitleTextFieldController.text = todoItemProps.title;
    todoContentTextFieldController.text = todoItemProps.content;

    return Scaffold(
      appBar: AppBar(
        title: const Text('編集画面'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            TodoTextField(
              controller: todoTitleTextFieldController,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Content',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            TodoTextField(
              controller: todoContentTextFieldController,
              maxLines: null,
            ),
            const SizedBox(
              height: 16,
            ),
            // const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(localDataRepositoryProvider).updateTodoItem(
                      todoId: todoItemProps.todoId,
                      title: todoTitleTextFieldController.text,
                      content: todoContentTextFieldController.text);
                },
                child: Text('更新'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoTextField extends StatelessWidget {
  const TodoTextField({
    super.key,
    required this.controller,
    this.maxLines,
  });

  final TextEditingController controller;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2),
      ),
      onChanged: (text) {
        print(text);
        controller.text = text;
      },
    );
  }
}
