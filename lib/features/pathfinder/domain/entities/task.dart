import 'package:equatable/equatable.dart';
import 'package:webspark/features/pathfinder/domain/entities/cell.dart';

class TaskEntity extends Equatable {
  final String id;
  final List<String> field;
  final CellEntity start;
  final CellEntity end;

  TaskEntity({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  TaskEntity copyWith({
    String? id,
    List<String>? field,
    CellEntity? start,
    CellEntity? end,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      field: field ?? this.field,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  List<Object?> get props => [id, field, start, end];
}
