import 'dart:convert';
import 'dart:math';


const List<List> lexiMaps = [
  [ '100',
    '101',
    '110',
  ],[
    '110',
    '101',
    '010'
  ],[
    '010',
    '111',
    '101',
  ]
];

class LifeMap {
  final Random _random = Random();
  List<List> _map = [];

  int get tileCols{
    if(_map.isEmpty) return 0;
    return _map[0].length;
  }

  int get tileRows{
    return _map.length;
  }


  LifeMap(int w, int h){
    setSize(w,h);
  }
  setSize(int cols, int rows){
    if (rows > 0) {
      if (cols != tileCols || rows != tileRows || _map.isEmpty) {
        clear(1, cols:cols, rows: rows);
      }
    }    
  }
  int patternCount(){
    return lexiMaps.length;
  }

  clear(int pattern, {int cols = 0, int rows = 0}){
    if(cols==0){
      cols = tileCols;
    }
    if(rows==0){
      rows = tileRows;
    }
    final int code1 = '1'.codeUnitAt(0);
    _map = List.generate(rows, (index) => List.filled(cols, ''));
    if(pattern>=0 && pattern< patternCount()){
      final lexi = lexiMaps[pattern];
      if(rows>lexi.length && cols>lexi[0].length){
        final cx = ((cols-lexi[0].length)/2).floor();
        final cy = ((rows-lexi.length)/2).floor();
        for(int y=0;y<lexi.length;y++){
          final String line = lexi[y];
          for(int x=0;x<line.length;x++){
              int c = line.codeUnitAt(x);
              if(c==code1){
                _map[cy+y][cx+x] = 'o';
              }
          }
        }      
      }
    }else{
      final cellCnt = (cols * rows * 0.1).floor();
      for (var i = 0; i < cellCnt; i++) {
        _map[_random.nextInt(rows)][_random.nextInt(cols)] = 'o';
      }
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
        if(y==row && x==col){
          continue;
        }
        if (isAlive(y, x)) {
          sum++;
        }
      }
    }
    return sum;
  }
  void step(){
    List<List> newMap = List.generate(tileRows, (index) => List.filled(tileCols, ''));
    for (var row = 0; row < tileRows; row++) {
        for (var col = 0; col < tileCols; col++) {
          final sum = surroundSum(row, col);
          if ((sum == 2 && _map[row][col]=='o')|| sum == 3) {
            newMap[row][col] = 'o';
          } else {
            newMap[row][col] = '';
          }
        }
      }
    _map = newMap;
  }

  String dump(){
    return jsonEncode(_map);
  }

  void load(String data){
    _map = jsonDecode(data);
  }

}
