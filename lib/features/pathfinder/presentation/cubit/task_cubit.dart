import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/core/resources/data_state.dart';
import 'package:webspark/features/pathfinder/domain/entities/cell.dart';
import 'package:webspark/features/pathfinder/domain/entities/task.dart';
import 'package:webspark/features/pathfinder/domain/usecases/get_tasks.dart';
import 'package:webspark/features/pathfinder/domain/usecases/send_results.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._getTasksUseCase, this._sendResultsUseCase) : super(TaskInitial());

  final GetTasksUseCase _getTasksUseCase;
  final SendResultsUseCase _sendResultsUseCase;

  Future<void> loadUrl(String url) async {
    Uri? parsedUrl = Uri.tryParse(url);
    if (parsedUrl == null) {
      emit(
        const TaskError(error: 'invalid url'),
      );
      return;
    }
    if (url != 'https://flutter.webspark.dev/flutter/api') {
      emit(
        const TaskError(error: 'url different from given in task'),
      );
      return;
    }
    emit(TaskCorrectUrl(url: url));
  }

  Future<void> calcTasks() async {
    emit(TaskCalcInProgress(0, url: state.url, tasks: const []));
    final dataState = await _getTasksUseCase(params: state.url);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      List<TaskEntity> tasks = dataState.data!;
      List<Map<String, dynamic>> resultCells = [];
      for (int i = 0; i < tasks.length; i++) {
        CellEntity resultCell = _calcTask(tasks[i]);
        resultCells.add({
          'id': tasks[i].id,
          'result': {
            'steps': resultCell.steps,
            'path': resultCell.road,
          }
        });
        double progress = (i+1) / tasks.length;
        emit(TaskCalcInProgress(progress, url: state.url, tasks: tasks));
      }
      emit(TaskCalcFinished(resultCells, url: state.url, tasks: tasks));
    } else {
      emit(TaskError(error: dataState.error!.message));
    }
  }

  CellEntity _calcTask(TaskEntity task) {
    int limitX = task.field[0].length - 1;
    int limitY = task.field.length - 1;
    List<CellEntity> aliveList = [task.start];
    CellEntity end = task.end;
    List<CellEntity> bannedList = [];
    for (int y = 0; y < task.field.length; y++) {
      String row = task.field[y];
      for (int x = 0; x < row.length; x++) {
        if (row[x] == 'X') {
          bannedList.add(CellEntity(x, y));
        }
      }
    }

    while (true) {
      List<CellEntity> newGeneration = [];
      for (CellEntity cell in aliveList) {
        newGeneration.addAll(cell.grow(bannedList, limitX, limitY));
        if (cell.x == end.x && cell.y == end.y) return cell;
      }
      //clean coordinate duplicates with longer path
      for (CellEntity cell1 in aliveList) {
        newGeneration.removeWhere((cell2) =>
            cell1 != cell2 &&
            cell1.x == cell2.x &&
            cell1.y == cell2.y &&
            cell1.path.length < cell2.path.length);
      }
      // aliveGeneration becomes banned
      bannedList.addAll(aliveList);
      // newGeneration gets older, and become new aliveList
      aliveList = newGeneration;
    }
  }

  Future<void> checkResults() async {
    if (state is TaskCalcFinished) {
      for (Map<String, dynamic> result in (state as TaskCalcFinished).results) {
      _sendResultsUseCase(params: (state.url, result));
      }
    }
  }
}
