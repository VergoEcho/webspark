import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/features/pathfinder/domain/entities/cell.dart';
import 'package:webspark/features/pathfinder/domain/entities/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  Future<void> loadTask(TaskEntity task) async {
    emit(TaskCorrectUrl(task: task));
  }

  Future<void> banField(int x, int y) async {
    if (CellEntity(x, y) == state.task?.end) return;
    if (state.task?.start == CellEntity(x, y)) return;
    String toggledChar = state.task!.field[y][x] == 'X' ? '.' : 'X';
    TaskEntity updatedTask = state.task!;
    updatedTask.field[y] =
        updatedTask.field[y].replaceRange(x, x + 1, toggledChar);
    emit(TaskCorrectUrl(task: updatedTask));
  }

  Future<void> startField(int x, int y) async {
    if (state.task!.field[y][x] == 'X') return;
    if (CellEntity(x, y) == state.task?.end) return;
    emit(
      TaskCorrectUrl(
        task: state.task?.copyWith(
          start: CellEntity(x, y),
        ),
      ),
    );
  }

  Future<void> endField(int x, int y) async {
    if (state.task!.field[y][x] == 'X') return;
    if (state.task?.start == CellEntity(x, y)) return;
    emit(
      TaskCorrectUrl(
        task: state.task?.copyWith(
          end: CellEntity(x, y),
        ),
      ),
    );
  }

  Future<void> calcTasks() async {
    // emit(TaskCalcInProgress(0, task: state.task, tasks: const []));

    List<TaskEntity> tasks = [state.task!];
    List<Map<String, dynamic>> resultCells = [];
    for (int i = 0; i < tasks.length; i++) {
      CellEntity resultCell = await _calcTask(tasks[i]);
      resultCells.add({
        'id': tasks[i].id,
        'result': {
          'steps': resultCell.steps,
          'path': resultCell.road,
        }
      });
      double progress = (i + 1) / tasks.length;
      // emit(TaskCalcInProgress(progress, task: state.task, tasks: tasks));
    }
    emit(TaskCalcFinished(resultCells, task: state.task, tasks: tasks));
  }

  Future<CellEntity> _calcTask(TaskEntity task) async {
    int limitX = task.field[0].length - 1;
    int limitY = task.field.length - 1;
    List<CellEntity> aliveList = [task.start];
    CellEntity end = task.end;
    List<CellEntity> bannedList = [];
    List<CellEntity> startBannedList = [];
    for (int y = 0; y < task.field.length; y++) {
      String row = task.field[y];
      for (int x = 0; x < row.length; x++) {
        if (row[x] == 'X') {
          startBannedList.add(CellEntity(x, y));
        }
      }
    }

    while (true) {
      List<CellEntity> newGeneration = [];
      for (CellEntity cell in aliveList) {
        newGeneration.addAll(
            cell.grow([...bannedList, ...startBannedList], limitX, limitY));
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
      final newField = task.field;
      for (CellEntity cell in aliveList) {
        if (cell == task.start) continue;
        if (cell == end) {
          newField[cell.y] =
              newField[cell.y].replaceRange(cell.x, cell.x + 1, '#');
          continue;
        }
        newField[cell.y] =
            newField[cell.y].replaceRange(cell.x, cell.x + 1, '+');
      }
      for (CellEntity cell in bannedList) {
        newField[cell.y] =
            newField[cell.y].replaceRange(cell.x, cell.x + 1, '-');
      }
      await Future.delayed(const Duration(milliseconds: 900));

      if (state is TaskCalcInProgress) {
        emit(TaskCorrectUrl(task: task.copyWith(field: newField)));
      } else {
        emit(TaskCalcInProgress(task: task.copyWith(field: newField)));
      }
    }
  }
}
