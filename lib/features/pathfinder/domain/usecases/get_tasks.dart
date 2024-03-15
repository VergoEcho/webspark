import 'package:webspark/core/usecase/usecase.dart';
import 'package:webspark/features/pathfinder/domain/entities/task.dart';

import '../../../../core/resources/data_state.dart';
import '../repository/task_repository.dart';

class GetTasksUseCase implements UseCase<DataState<List<TaskEntity>>, String?> {
  final TaskRepository _taskRepository;

  GetTasksUseCase(this._taskRepository);

  @override
  Future<DataState<List<TaskEntity>>> call({String? params}) {
    return _taskRepository.getTasks(params!);
  }
}