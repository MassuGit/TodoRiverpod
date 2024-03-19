import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_riverpod/external_interface/shared_preference_service.dart';
import 'package:todo_riverpod/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferenceProvider
            .overrideWithValue(await SharedPreferences.getInstance()),
      ],
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.amber[400],
        ),
      ),
    );
  }
}
