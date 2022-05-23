import "package:flutter/material.dart";
import "life_map.dart";
class TileBoard extends StatelessWidget {
  const TileBoard(this.tileMap, this.tileSize, {Key? key}) : super(key: key);
  final LifeMap tileMap;
  final Size tileSize;

  Widget tileLine(int idx) {
    return Row(
      children: List.generate(tileMap.tileCols, (index) {
        BoxDecoration dec;
        if (tileMap.isAlive(idx, index)) {
          dec = const BoxDecoration(color: Colors.amberAccent);
        }else{
          dec = BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black26, width: 0.1));
        }
        String n = tileMap.surroundSum(idx, index).toString();
        return 
        SizedBox(width: tileSize.width, height: tileSize.height,child:
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: dec,
            child: Text(n,style: const TextStyle(color: Colors.blue,fontSize: 12,),textAlign: TextAlign.center),
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
