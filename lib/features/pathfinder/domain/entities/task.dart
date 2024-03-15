import 'package:webspark/features/pathfinder/domain/entities/cell.dart';

class TaskEntity {
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
}
