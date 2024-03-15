import 'package:webspark/core/resources/data_state.dart';
import 'package:webspark/features/pathfinder/domain/entities/task.dart';

abstract class TaskRepository {
  Future<DataState<List<TaskEntity>>> getTasks(String url);

  Future<DataState<String?>> checkTasks(String url, Map<String, dynamic> results);
}