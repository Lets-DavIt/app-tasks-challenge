import 'package:app_tasks_challenge/ui/tasks/viewmodels/tasks_viewmodel.dart';
import 'package:app_tasks_challenge/ui/tasks/widgets/tasks_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TasksScreen(
        viewModel: TasksViewModel(),
      ),
    );
  }
}
