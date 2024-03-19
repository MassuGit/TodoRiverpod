import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/state_notifiers/todo_list_notifier.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HELLO XIAOTING'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                child: _TodoItemRecord(todoTitle: todoList[index].title),
                onTap: () {
                  context.push('/updateTodo', extra: todoList[index]);
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Material(
                child: InkWell(
                  onTap: () {
                    context.push('/addTodo');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 2.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TodoItemRecord extends StatelessWidget {
  const _TodoItemRecord({required this.todoTitle});

  final String todoTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Text(
        todoTitle,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }
}
