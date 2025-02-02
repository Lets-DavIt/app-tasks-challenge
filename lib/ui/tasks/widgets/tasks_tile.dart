import 'package:app_tasks_challenge/core/typedefs/task.dart';
import 'package:app_tasks_challenge/domain/models/task.dart';
import 'package:flutter/material.dart';

class TasksTile extends StatelessWidget {
  final OnRemoveTask onRemoveTask;
  final Task task;
  const TasksTile({super.key, required this.task, required this.onRemoveTask});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("${task.id}"),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: IconButton(
        onPressed: () {
          onRemoveTask(task);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
