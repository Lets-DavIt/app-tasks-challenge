import 'package:app_tasks_challenge/data/repositories/tasks_repository.dart';
import 'package:app_tasks_challenge/domain/models/task.dart';
import 'package:result_dart/result_dart.dart';

class TasksRepositoryDev implements TasksRepository {
  final List<Task> _list = [];

  @override
  Future<Result<List<Task>>> get() {
    throw UnimplementedError();
  }

  @override
  Future<Result<Task>> add(Task task) {
    final lastTaskIndex = _list.length;

    final Task createdTask = Task(
        id: lastTaskIndex + 1,
        title: task.title,
        description: task.description);

    throw UnimplementedError();
  }

  @override
  Future<Result<String>> delete(Task task) {
    throw UnimplementedError();
  }
}
