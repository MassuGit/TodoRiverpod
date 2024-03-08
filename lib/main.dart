import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final homeTextProvider = Provider((ref) => 'Hello xiaoting!');

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        body: Center(
          child: Text(homeText),
        ),
      ),
    );
  }
}
