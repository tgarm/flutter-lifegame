import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'map_controller.dart';
import 'tile_board.dart';
import 'package:clipboard/clipboard.dart';
import 'setting_page.dart';

class LifePanel extends StatelessWidget {
  const LifePanel({Key? key, required this.title}) : super(key: key);

  final String title;
  static const tileSize = Size(32, 32);
  static const otherHeight = 200;

  void _runToggle() {
    final to = MapController.to;
    if (to.running) {
      to.stop();
    } else {
      to.start();
    }
  }

  ElevatedButton _stepButton() {
    if (MapController.to.running) {
      return const ElevatedButton(onPressed: null, child: Text('Step'));
    } else {
      return ElevatedButton(
          onPressed: () {
            MapController.to.step();
          },
          child: const Text('Step'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    final cols = (wsize.width / tileSize.width).floor();
    final rows = ((wsize.height - otherHeight) / tileSize.height).floor();
    MapController.to.setSize(rows, cols);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingPage()),
                );
              },
              iconSize: 46,
              alignment: Alignment.topRight,
            ),
          ],
        ),
        body: GetBuilder<MapController>(
          builder: (mc) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const TileBoard(true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _stepButton(),
                    ElevatedButton(
                      child:
                          mc.running ? const Text("Stop") : const Text("Start"),
                      onPressed: () => {_runToggle()},
                    ),
                    ElevatedButton(
                        onPressed: () {
                          FlutterClipboard.copy(MapController.to.dump())
                              .then((value) {
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
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
