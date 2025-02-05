import "package:app_tasks_challenge/domain/models/task.dart";
import "package:result_dart/result_dart.dart";

abstract class TasksRepository {
  Future<Result<List<Task>>> get();

  Future<Result<Task>> add(Task task);

  Future<Result<String>> delete(Task task);
}
