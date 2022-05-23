import "package:flutter/material.dart";
import 'tile_widgets.dart';
import "life_map.dart";
class TileBoard extends StatelessWidget {
  const TileBoard(this.tileMap, this.tileSize, {Key? key}) : super(key: key);
  final LifeMap tileMap;
  final Size tileSize;

  Widget tileLine(int idx) {
    return Row(
      children: List.generate(tileMap.tileCols, (index) {
        return 
        SizedBox(width: tileSize.width, height: tileSize.height,child:
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: TileWidgets.tileDecoration(tileMap.isAlive(idx, index)),
            child: TileWidgets.tileText(tileMap.surroundSum(idx, index)),
          ));
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tileMap.tileRows, (index) => tileLine(index)),
    );
  }
}
