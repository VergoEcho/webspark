import 'dart:convert';

import 'package:webspark/features/pathfinder/domain/entities/cell.dart';

class CellModel extends CellEntity {
  const CellModel(super.x, super.y, {super.path});

  factory CellModel.fromJson(String json) {
    dynamic data = jsonDecode(json);
    return CellModel(
      data['x'] ?? 0,
      data['y'] ?? 0,
      path: const [],
    );
  }

  String toJson(CellModel model) {
    return jsonEncode(model);
  }
}
