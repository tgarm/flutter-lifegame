import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'tile_board.dart';
import 'life_map.dart';
import 'package:clipboard/clipboard.dart';

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
  final _lifeMap = LifeMap(12, 16);
  bool _running = false;
  late RestartableTimer _ticker;
  int patternId = 0;
  bool _offstage = false;

  @override
  void initState() {
    super.initState();
    _lifeMap.clear();
    _running = false;
    _ticker = RestartableTimer(const Duration(milliseconds: 400), () {
      if (_running) {
        _runStep();
        _ticker.reset();
      }
    });
  }

  void _resetMap() async {
    patternId++;
    patternId = await _lifeMap.loadLexi(patternId);
    setState(() {});
  }

  void _runStep() {
    setState(() {
      _lifeMap.step();
    });
  }

  void _runToggle() {
    if (_running) {
      _ticker.cancel();
      setState(() {
        _running = false;
      });
    } else {
      _ticker.reset();
      setState(() {
        _running = true;
      });
    }
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  String _runCaption() {
    if (_running) {
      return 'Stop';
    } else {
      return 'Start';
    }
  }

  ElevatedButton _stepButton() {
    if (_running) {
      return const ElevatedButton(onPressed: null, child: Text('Step'));
    } else {
      return ElevatedButton(onPressed: _runStep, child: const Text('Step'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    final cols = (wsize.width / tileSize.width).floor();
    final rows = ((wsize.height - otherHeight) / tileSize.height).floor();
    _lifeMap.setSize(cols, rows);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TileBoard(_lifeMap, tileSize, true),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                "Pattern: $patternId",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => {_resetMap()}, child: const Text('Reset')),
                _stepButton(),
                ElevatedButton(
                  child: Text(_runCaption()),
                  onPressed: () => {_runToggle()},
                ),
                ElevatedButton(
                    onPressed: () {
                      FlutterClipboard.copy(_lifeMap.dump()).then((value) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("saved to clipboard"),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                  )
                                ],
                              );
                            });
                      });
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () => {
                          FlutterClipboard.paste().then((value) {
                            setState(() {
                              _lifeMap.load(value);
                            });
                          })
                        },
                    child: const Text('load'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
