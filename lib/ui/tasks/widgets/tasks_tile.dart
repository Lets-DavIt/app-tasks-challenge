import 'package:app_tasks_challenge/domain/models/task.dart';
import 'package:flutter/material.dart';

class TasksTile extends StatelessWidget {
  final Task task;
  const TasksTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("${task.id}"),
      title: Text(task.title),
      subtitle: Text(task.description),
    );
  }
}
