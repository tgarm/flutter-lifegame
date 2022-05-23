import 'package:flutter/material.dart';

class TileWidgets {
  static const Color _aliveColor = Colors.amberAccent;
  static final filledTileDecoration =  BoxDecoration(
            color: _aliveColor,
            border: Border.all(color: _aliveColor));
  static final emptyTileDecoration = BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black26, width: 0.1));
  static BoxDecoration tileDecoration(bool filled){
    if(filled) return filledTileDecoration;
    return emptyTileDecoration;
  }
  static tileText(int n){
    return Text(n.toString(),style: const TextStyle(color: Colors.blue,fontSize: 12,),textAlign: TextAlign.center);
  }
}