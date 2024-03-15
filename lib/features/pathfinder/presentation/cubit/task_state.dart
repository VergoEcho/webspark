part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  final String url;
  final String? error;

  const TaskState({
    this.url = '',
    this.error,
  });
}

class TaskInitial extends TaskState {
  @override
  List<Object?> get props => [super.url, super.error];
}

class TaskError extends TaskState {
  const TaskError({required super.error});

  @override
  List<Object?> get props => [super.url, super.error];
}

class TaskCorrectUrl extends TaskState {
  const TaskCorrectUrl({required super.url});

  @override
  List<Object?> get props => [super.url, super.error];
}

class TaskCalcInProgress extends TaskState {
  final double progress;
  final List<TaskEntity> tasks;

  const TaskCalcInProgress(
    this.progress, {
    required super.url,
    required this.tasks,
  });

  @override
  List<Object?> get props => [progress, super.url, super.error, tasks];
}

class TaskCalcFinished extends TaskState {
  final List<TaskEntity> tasks;
  final List<Map<String, dynamic>> results;

  const TaskCalcFinished(
    this.results, {
    required super.url,
    required this.tasks,
  });

  @override
  List<Object?> get props => [results, super.url, super.error, tasks];
}
