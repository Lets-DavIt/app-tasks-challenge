import 'package:app_tasks_challenge/ui/tasks/viewmodels/tasks_viewmodel.dart';
import 'package:app_tasks_challenge/ui/tasks/widgets/add_task_widget.dart';
import 'package:app_tasks_challenge/ui/tasks/widgets/tasks_list.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  final TasksViewModel viewModel;
  const TasksScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taski')),
      body: ListenableBuilder(
        listenable: viewModel.load,
        builder: (context, child) {
          if (viewModel.load.running) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (viewModel.load.error) {
            return const Center(
              child: Text('Error'),
            );
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) {
            return TasksList(data: viewModel.tasks);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTaskWidget(
                viewModel: viewModel,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
