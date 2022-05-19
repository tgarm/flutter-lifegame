import 'package:flutter/material.dart';
import 'dart:math';
import 'tileBoard.dart';

void main() {
  runApp(const LifeGameApp());
}

class LifeGameApp extends StatelessWidget {
  const LifeGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple LifeGame',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LifePanel(title: 'SLG Home'),
    );
  }
}

class LifePanel extends StatefulWidget {
  const LifePanel({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LifePanel> createState() => _LifePanelState();
}

class _LifePanelState extends State<LifePanel> {
  static const tileSize = Size(32, 32);
  static const otherHeight = 200;
  int tileRows = 12, tileCols = 16;
  List<List> _lifeMap = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initMap(tileCols, tileRows);
  }

  void _initMap(cols, rows) {
    tileCols = cols;
    tileRows = rows;
    _lifeMap = List.generate(rows, (index) => List.filled(cols, ''));
    final cellCnt = (cols * rows * 0.1).floor();
    for (var i = 0; i < cellCnt; i++) {
      _lifeMap[_random.nextInt(tileRows)][_random.nextInt(tileCols)] = 'o';
    }
  }

  void _resetMap() {
    setState(() {
      _initMap(tileCols, tileRows);
    });
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
    if (_lifeMap[row][col] == '') {
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

  void _runStep() {
    setState(() {
      for (var row = 0; row < tileRows; row++) {
        for (var col = 0; col < tileCols; col++) {
          final sum = surroundSum(row, col);
          if (sum == 2 || sum == 3) {
            _lifeMap[row][col] = 'o';
          } else {
            _lifeMap[row][col] = '';
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    final cols = (wsize.width / tileSize.width).floor();
    final rows = ((wsize.height - otherHeight) / tileSize.height).floor();
    if (rows > 0) {
      if (cols != tileCols || rows != tileRows || _lifeMap.isEmpty) {
        _initMap(cols, rows);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TileBoard(_lifeMap, tileSize),
            Row(
              children: <Widget>[
                TextButton(
                    onPressed: () => {_resetMap()}, child: const Text('Reset')),
                TextButton(
                    onPressed: () => {_runStep()}, child: const Text('Step')),
                TextButton(
                  child: const Text('Run'),
                  onPressed: () => {print("run?")},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
