import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:lifegame/map_controller.dart';
import 'tile_widgets.dart';
import "life_map.dart";

class TileBoard extends StatelessWidget {
  const TileBoard(this.editable, {Key? key}) : super(key: key);

  final bool editable;

  void toggle(int row, int col) {
    MapController.to.toggle(row, col);
  }

  Widget tileLine(Size tileSize, LifeMap lm, int row) {
    return Row(
        children: List.generate(lm.tileCols, (col) {
      return GestureDetector(
        child: TileWidgets.tileItem(row, col, tileSize, lm),
        onTap: () {
          toggle(row, col);
        },
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
        builder: (mc) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(MapController.to.tileRows,
                  (index) => tileLine(mc.tileSize, mc.map(), index)),
            ));
  }
}
