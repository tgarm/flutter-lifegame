import 'package:flutter/material.dart';
import 'package:lifegame/life_map.dart';

class TileWidgets {
  static const Color _aliveColor = Colors.amberAccent;
  static final filledTileDecoration =
      BoxDecoration(color: _aliveColor, border: Border.all(color: _aliveColor));
  static final emptyTileDecoration = BoxDecoration(
      color: Colors.black12,
      border: Border.all(color: Colors.black26, width: 0.1));
  static BoxDecoration tileDecoration(bool filled) {
    if (filled) return filledTileDecoration;
    return emptyTileDecoration;
  }

  static tileItem(int row, int col, Size size, LifeMap map) {
    final text = Text(map.surroundSum(row, col).toString(),
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 12,
        ),
        textAlign: TextAlign.center);
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: TileWidgets.tileDecoration(map.isAlive(row, col)),
          child: text,
        ));
  }
}
