import 'package:webspark/core/usecase/usecase.dart';
import 'package:webspark/features/pathfinder/domain/entities/task.dart';

import '../../../../core/resources/data_state.dart';
import '../repository/task_repository.dart';

class SendResultsUseCase implements UseCase<DataState<void>, (String, Map<String,dynamic>)> {
  final TaskRepository _taskRepository;

  SendResultsUseCase(this._taskRepository);

  @override
  Future<DataState<void>> call({params = const ('', {'': ''})}) {
    var (url, data) = params;
    return _taskRepository.checkTasks(url, data);
  }
}