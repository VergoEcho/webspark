import 'package:equatable/equatable.dart';

class CellEntity extends Equatable {
  final int x;
  final int y;
  final List<CellEntity> path;

  const CellEntity(this.x, this.y, {this.path = const []});

  /// limits are inclusive
  List<CellEntity> grow(List<CellEntity> banned, int limitX, int limitY) {
    List<CellEntity> newCells = [];
    List<CellEntity> newPath = [...path, this];

    //(1)2 3
    // 4 5 6
    // 7 8 9

    // left line
    if (x>0) {
      newCells.add(CellEntity(x-1, y, path: newPath));
      if (y > 0) newCells.add(CellEntity(x-1, y-1, path: newPath));
      if (y < limitY) newCells.add(CellEntity(x-1, y+1, path: newPath));
    }
    // right line
    if (x < limitX) {
      newCells.add(CellEntity(x+1, y, path: newPath));
      if (y>0) newCells.add(CellEntity(x+1, y-1, path: newPath));
      if (y< limitY) newCells.add(CellEntity(x+1, y+1, path: newPath));
    }
    // top center
    if (y < limitY) newCells.add(CellEntity(x, y+1, path: newPath));
    // bottom center
    if (y > 0) newCells.add(CellEntity(x, y-1, path: newPath));
    newCells.removeWhere((cell) {
      for (CellEntity bannedCell in banned) {
        if (bannedCell.x == cell.x && bannedCell.y == cell.y) return true;
      }
      return false;
    });
    return newCells;
  }

  String get road {
    String road = '';
    print(path.length);
    for (CellEntity cell in path) {
      road += '(${cell.x},${cell.y})->';
    }
    road += '($x,$y)';
    return road;
  }

  List<Map<String, String>> get steps {
    List<Map<String, String>> steps = [];
    for (CellEntity cell in path) {
      steps.add({
        'x': cell.x.toString(),
        'y': cell.y.toString(),
      });
    }
    steps.add({'x': x.toString(), 'y': y.toString()});
    return steps;
  }

  @override
  List<Object?> get props => [x, y, path];
}