import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'life_map.dart';

class MapController extends GetxController {
  final _map = LifeMap(0, 0).obs;
  LifeMap map() => _map.value;
  Size _tileSize = const Size(32, 32);
  bool dirty = false;
  bool _running = false;
  dynamic _ticker;

  static MapController get to => Get.find();

  void _singleTick() {
    if (_running) {
      step();
      _ticker.reset();
    } else {
      stop();
    }
  }

  get running => _running;

  void start() {
    if (_ticker ??= null) {
      _ticker =
          RestartableTimer(const Duration(milliseconds: 400), _singleTick);
    }
    _ticker.reset();
    _running = true;
  }

  void stop() {
    if (_ticker != null) {
      _ticker.cancel();
      _ticker = null;
    }
    _running = false;
  }

  get tileRows => _map.value.tileRows;
  get tileCols => _map.value.tileCols;

  get tileSize => _tileSize;

  void setTileSize(Size newSize) {
    double xRate = newSize.width / _tileSize.width;
    double yRate = newSize.height / _tileSize.height;
    _tileSize = newSize;
    setSize((tileRows / yRate).floor(), (tileCols / xRate).floor());
    update();
  }

  void toggle(int row, int col) {
    _map.value.toggle(row, col);
    dirty = true;
    update();
  }

  void clear(int rows, int cols) {
    _map.value.clear(rows: rows, cols: cols);
    dirty = false;
    update();
  }

  void setSize(int rows, int cols) {
    _map.value.setSize(rows, cols);
    //TODO: should "update", but ...
  }

  void step() {
    _map.value.step();
    update();
  }

  String dump() {
    dirty = false;
    return _map.value.dump();
  }

  void load(String content) {
    dirty = false;
    _map.value.load(content);
    update();
  }
}
