import 'dart:convert';

import 'package:webspark/features/pathfinder/data/models/cell.dart';

import '../../features/pathfinder/data/models/task.dart';

class ResponseApi<T> {
  bool? error;
  String? message;
  List<TaskModel>? data;

  ResponseApi({this.error, this.message, this.data});

  factory ResponseApi.fromJson(Map<String, dynamic> json) {
    return ResponseApi(
      error: json['error'],
      message: json['message'],
      data: List<TaskModel>.from(json['data']!
          .map(
            (list) => TaskModel(
          id: list['id'],
          field: List<String>.from(list['field']),
          end: CellModel(list['end']['x'], list['end']['y']),
          start: CellModel(list['start']['x'], list['start']['y']),
        ),
      )
          .toList()),
    );
  }

// String toJson(ResponseApi<T> response) {
//   return jsonEncode(response);
// }
}
