import 'package:flutter/material.dart';
import 'tile_board.dart';
import 'life_map.dart';

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
  final _lifeMap = LifeMap(12,16);
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _lifeMap.clear();
    _running = false;
  }


  void _resetMap() {
    setState(() {
      _lifeMap.clear();
    });
  }
  void _runStep() {
    setState(() {
      _lifeMap.step();
    });
  }

  void _runToggle(){
    if(_running){
      setState(() {
        _running = false;
      });
    }else{
      setState(() {
        _running = true;
      });
    }
  }

  String _runCaption(){
    if(_running){
      return 'Stop';
    }else{
      return 'Start';
    }
  }

  TextButton _stepButton(){
    if(_running){
      return const TextButton(onPressed:null, child:Text('Step'));
    }else{
      return TextButton(onPressed: _runStep, child: const Text('Step'));
    }
    
  }
  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    final cols = (wsize.width / tileSize.width).floor();
    final rows = ((wsize.height - otherHeight) / tileSize.height).floor();
    _lifeMap.setSize(cols,rows);
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
                _stepButton(),
                TextButton(
                  child: Text(_runCaption()),
                  onPressed: () => {_runToggle()},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
