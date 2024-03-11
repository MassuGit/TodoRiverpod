import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_riverpod/add_todo_page.dart';
import 'package:todo_riverpod/todo_list_page.dart';

final router = GoRouter(
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Hello Xiaoting'),
          ),
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              TodoListPage(),
        ),
        GoRoute(
          path: '/addTodo',
          builder: (BuildContext context, GoRouterState state) =>
              const AddTodoPage(),
        ),
      ],
    ),
  ],
);
