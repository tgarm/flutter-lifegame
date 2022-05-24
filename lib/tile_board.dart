import "package:flutter/material.dart";
import 'tile_widgets.dart';
import "life_map.dart";

class TileBoard extends StatefulWidget {
  const TileBoard(this.tileMap, this.tileSize, this.editable, {Key? key})
      : super(key: key);

  final LifeMap tileMap;
  final Size tileSize;
  final bool editable;

  @override
  State<TileBoard> createState() => _TileBoardState();
}

class _TileBoardState extends State<TileBoard> {
  void toggle(int row, int col) {
    setState(() {
      widget.tileMap.toggle(row, col);
    });
  }

  Widget tileLine(int row) {
    return Row(
        children: List.generate(widget.tileMap.tileCols, (col) {
      return GestureDetector(
        child: TileWidgets.tileItem(row, col, widget.tileSize, widget.tileMap),
        onTap: () {
          toggle(row, col);
        },
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          List.generate(widget.tileMap.tileRows, (index) => tileLine(index)),
    );
  }
}
