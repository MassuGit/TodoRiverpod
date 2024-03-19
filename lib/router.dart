import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_riverpod/entities/todo_item.dart';
import 'package:todo_riverpod/ui/add_todo_page.dart';
import 'package:todo_riverpod/ui/todo_list_page.dart';
import 'package:todo_riverpod/ui/update_todo_page.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const TodoListPage(),
    ),
    GoRoute(
      path: '/addTodo',
      builder: (BuildContext context, GoRouterState state) =>
          const AddTodoPage(),
    ),
    GoRoute(
      path: '/updateTodo',
      builder: (context, state) {
        final todoItem = state.extra as TodoItem? ?? TodoItem(todoId: -1);
        return UpdateTodoPage(todoItemProps: todoItem);
      },
    ),
  ],
);
