part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  final TaskEntity? task;
  final String? error;

  const TaskState({
    this.task,
    this.error,
  });
}

class TaskInitial extends TaskState {
  @override
  List<Object?> get props => [super.task, super.error];
}

class TaskError extends TaskState {
  const TaskError({required super.error});

  @override
  List<Object?> get props => [super.task, super.error];
}

class TaskCorrectUrl extends TaskState {
  const TaskCorrectUrl({required super.task});

  @override
  List<Object?> get props => [super.task, super.error];
}

class TaskCalcInProgress extends TaskState {
  const TaskCalcInProgress({
    required super.task,
  });

  @override
  List<Object?> get props => [super.task, super.error, ...super.task!.field];
}

class TaskCalcFinished extends TaskState {
  final List<TaskEntity> tasks;
  final List<Map<String, dynamic>> results;

  const TaskCalcFinished(
    this.results, {
    required super.task,
    required this.tasks,
  });

  @override
  List<Object?> get props => [results, super.task, super.error, tasks];
}
