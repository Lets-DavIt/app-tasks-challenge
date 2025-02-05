import 'package:app_tasks_challenge/ui/tasks/viewmodels/tasks_viewmodel.dart';
import 'package:app_tasks_challenge/ui/tasks/widgets/add_task_widget.dart';
import 'package:app_tasks_challenge/ui/tasks/widgets/tasks_list.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  final TasksViewModel viewModel;
  const TasksScreen({super.key, required this.viewModel});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    widget.viewModel.deleteTask.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.viewModel.deleteTask.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const IntrinsicHeight(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (widget.viewModel.deleteTask.completed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Tarefa removida com sucesso!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ocorreu um erro ao remover a tarefa.'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    widget.viewModel.deleteTask.addListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taski')),
      body: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          if (widget.viewModel.load.running) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (widget.viewModel.load.error) {
            return const Center(
              child: Text('Error'),
            );
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return TasksList(
              onRemoveTask: (task) {
                widget.viewModel.deleteTask.execute(task);
              },
              data: widget.viewModel.tasks,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTaskWidget(
                viewModel: widget.viewModel,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
