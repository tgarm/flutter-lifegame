import "package:flutter/material.dart";
import "life_map.dart";
class TileBoard extends StatelessWidget {
  const TileBoard(this.tileMap, this.tileSize, {Key? key}) : super(key: key);
  final LifeMap tileMap;
  final Size tileSize;

  Widget tileLine(int idx) {
    return Row(
        children: List.generate(tileMap.tileCols, (index) {
      Color c = Colors.black12;
      if (tileMap.isAlive(idx, index)) {
        c = Colors.amberAccent;
      }
      String n = tileMap.surroundSum(idx, index).toString();
      return 
      SizedBox(width: tileSize.width, height: tileSize.height,child:
        Container(
          padding: const EdgeInsets.all(4.0),
          color: c,
          child: Text(n),
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
