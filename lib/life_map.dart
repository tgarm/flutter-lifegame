import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LifeMap {
  List<List> _map = [];

  int get tileCols {
    if (_map.isEmpty) return 0;
    return _map[0].length;
  }

  int get tileRows {
    return _map.length;
  }

  LifeMap(int w, int h) {
    setSize(w, h);
  }
  setSize(int cols, int rows) {
    if (rows > 0) {
      if (cols != tileCols || rows != tileRows || _map.isEmpty) {
        clear(cols: cols, rows: rows);
      }
    }
  }

  clear({int cols = 0, int rows = 0}) {
    if (cols == 0) {
      cols = tileCols;
    }
    if (rows == 0) {
      rows = tileRows;
    }
    _map = List.generate(rows, (index) => List.filled(cols, 0));
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
    if (_map[row][col] == 0) {
      return false;
    }
    return true;
  }

  int surroundSum(int row, int col) {
    int sum = 0;
    for (var y = row - 1; y <= row + 1; y++) {
      for (var x = col - 1; x <= col + 1; x++) {
        if (y == row && x == col) {
          continue;
        }
        if (isAlive(y, x)) {
          sum++;
        }
      }
    }
    return sum;
  }

  void toggle(int row, int col) {
    if (row >= 0 && row <= tileRows && col >= 0 && col <= tileCols) {
      final old = _map[row][col];
      if (old == 0) {
        _map[row][col] = 1;
      } else {
        _map[row][col] = 0;
      }
    }
  }

  void step() {
    List<List> newMap =
        List.generate(tileRows, (index) => List.filled(tileCols, 0));
    for (var row = 0; row < tileRows; row++) {
      for (var col = 0; col < tileCols; col++) {
        final sum = surroundSum(row, col);
        if ((sum == 2 && _map[row][col] == 1) || sum == 3) {
          newMap[row][col] = 1;
        } else {
          newMap[row][col] = 0;
        }
      }
    }
    _map = newMap;
  }

  String dump() {
    List<String> lines = [];
    for (final mapl in _map) {
      String line = utf8.decode(
          List.generate(mapl.length, (int index) => mapl[index] + 0x20));
      lines.add(line);
    }
    const encoder = JsonEncoder.withIndent(' ');
    return encoder.convert(lines);
  }

  void load(String data) {
    final List parsed = jsonDecode(data);
    final List<List> map = [];
    for (final line in parsed) {
      final lineCodes = utf8.encode(line);
      map.add(
          List.generate(line.length, (int index) => lineCodes[index] - 0x20));
    }
    _map = map;
  }

  Future<int> loadLexi(int index) async {
    final lexiList =
        jsonDecode(await rootBundle.loadString('assets/pattern.json'));

    if (index < 0) {
      index = 0;
    }
    final int lexiCount = lexiList.length;
    while (index >= lexiCount) {
      index -= lexiCount;
    }
    clear();
    final lexi = lexiList[index];
    final startcol = ((tileCols - lexi[0].length) / 2).floor();
    final startrow = ((tileRows - lexi.length) / 2).floor();
    for (var y = 0; y < lexi.length; y++) {
      final line = utf8.encode(lexi[y]);
      for (var x = 0; x < line.length; x++) {
        _map[startrow + y][startcol + x] = line[x] - 0x20;
      }
    }
    return index;
  }
}
