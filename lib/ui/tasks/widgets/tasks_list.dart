import 'package:app_tasks_challenge/domain/models/task.dart';
import 'package:app_tasks_challenge/ui/tasks/widgets/tasks_tile.dart';
import 'package:flutter/material.dart';

class TasksList extends StatelessWidget {
  final List<Task> data;

  const TasksList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text('Nenhuma tarefa por enquanto...'),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return TasksTile(task: data[index]);
      },
    );
  }
}
