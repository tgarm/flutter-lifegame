// ignore: file_names
import "package:flutter/material.dart";

class TileBoard extends StatelessWidget {
  const TileBoard(this.tileMap, this.tileSize, {Key? key}) : super(key: key);
  final List<List> tileMap;
  final Size tileSize;

  Widget tileLine(int idx) {
    return Row(
        children: List.generate(tileMap[0].length, (index) {
      Color c = Colors.white;
      if (tileMap[idx][index] != '') {
        c = Colors.green;
      }
      return Container(
        padding: EdgeInsets.symmetric(
            vertical: tileSize.width / 2, horizontal: tileSize.height / 2),
        color: c,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tileMap.length, (index) => tileLine(index)),
    );
  }
}
