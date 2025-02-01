import 'package:app_tasks_challenge/core/commands/commands.dart';
import 'package:app_tasks_challenge/domain/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

class TasksViewModel extends ChangeNotifier {
  TasksViewModel() {
    load = Command0(_load)..execute();
    addTask = Command1(_addTask);
    deleteTask = Command1(_deleteTask);
  }

  late Command0 load;

  late Command1<Task, Task> addTask;

  late Command1<String, Task> deleteTask;

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<Result> _load() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Task> tasks = [];

    _tasks = tasks;

    notifyListeners();

    return Success(tasks);
  }

  Future<Result<Task>> _addTask(Task params) async {
    final lastTaskIndex = _tasks.length;

    await Future.delayed(const Duration(seconds: 1));

    final createTask = Task(
        id: lastTaskIndex + 1,
        title: params.title,
        description: params.description);

    _tasks.add(createTask);

    notifyListeners();

    return Success(createTask);
  }

  Future<Result<String>> _deleteTask(Task task) async {
    await Future.delayed(const Duration(seconds: 1));
    _tasks.remove(task);
    return const Success("Removido com sucesso!");
  }
}
