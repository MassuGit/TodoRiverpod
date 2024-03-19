import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_riverpod/external_interface/repositories/local_data_repository_impl.dart';

class AddTodoPage extends HookConsumerWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoTextFieldController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo追加画面'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: todoTextFieldController,
                decoration: const InputDecoration(
                  hintText: 'Todoを入力してください',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                ref
                    .read(localDataRepositoryProvider)
                    .saveTodoItem(title: todoTextFieldController.text);
              },
              child: const Text('追加'),
            ),
          ),
        ],
      ),
    );
  }
}
