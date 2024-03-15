import 'dart:convert';

import 'package:webspark/features/pathfinder/domain/entities/task.dart';

import 'cell.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.field,
    required CellModel start,
    required CellModel end,
  }) : super(start: start, end: end);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      field: json['field'],
      start: CellModel.fromJson(json['start']),
      end: CellModel.fromJson(json['end']),
    );
  }

  String toJson(TaskModel taskModel) {
    return jsonEncode(taskModel);
  }
}