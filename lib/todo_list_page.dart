import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    ProviderScope(child: TodoListPage()),
  );
}

final homeTextProvider = Provider((ref) => 'Hello xiaoting!');

class TodoListPage extends ConsumerWidget {
  TodoListPage({super.key});

  final todoList = [
    "todo1",
    "todo10",
    "todo15",
    "todo100",
    "todo150",
    "todo200",
    "todo230",
    "todo300",
    "todo500",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeText = ref.read(homeTextProvider);

    return MaterialApp(
      title: "Title",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(homeText),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            if (index < todoList.length) {
              return _TodoItem(todoTitle: todoList[index]);
            }
            return null;
          },
        ),
      ),
    );
  }
}

class _TodoItem extends StatelessWidget {
  const _TodoItem({required this.todoTitle});

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
