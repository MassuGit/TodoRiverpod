import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_riverpod/ui/add_todo_page.dart';
import 'package:todo_riverpod/ui/todo_list_page.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => TodoListPage(),
    ),
    GoRoute(
      path: '/addTodo',
      builder: (BuildContext context, GoRouterState state) =>
          const AddTodoPage(),
    ),
  ],
);
