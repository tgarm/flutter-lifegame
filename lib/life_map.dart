import 'dart:math';

class LifeMap {
  int tileCols = 0;
  int tileRows = 0;
  final Random _random = Random();
  List<List> _map = [];
  LifeMap(int w, int h){
    setSize(w,h);
  }
  setSize(int cols, int rows){
    if (rows > 0) {
      if (cols != tileCols || rows != tileRows || _map.isEmpty) {
        tileCols = cols;
        tileRows = rows;
        clear();
      }
    }    
  }
  clear(){
    _map = List.generate(tileRows, (index) => List.filled(tileCols, ''));
    final cellCnt = (tileCols * tileRows * 0.1).floor();
    for (var i = 0; i < cellCnt; i++) {
      _map[_random.nextInt(tileRows)][_random.nextInt(tileCols)] = 'o';
    }
  }

  bool isAlive(row, col) {
    if (row >= tileRows) {
      row -= tileRows;
    }
    if (row < 0) {
      row += tileRows;
    }
    if (col >= tileCols) {
      col -= tileCols;
    }
    if (col < 0) {
      col += tileCols;
    }
    if (_map[row][col] == '') {
      return false;
    }
    return true;
  }

  int surroundSum(int row, int col) {
    int sum = 0;
    for (var y = row - 1; y <= row + 1; y++) {
      for (var x = col - 1; x <= col + 1; x++) {
        if (isAlive(y, x)) {
          sum++;
        }
      }
    }
    return sum;
  }
  void step(){
    for (var row = 0; row < tileRows; row++) {
        for (var col = 0; col < tileCols; col++) {
          final sum = surroundSum(row, col);
          if (sum == 2 || sum == 3) {
            _map[row][col] = 'o';
          } else {
            _map[row][col] = '';
          }
        }
      }
  }
}
