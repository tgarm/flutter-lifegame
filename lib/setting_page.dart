import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifegame/map_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List tileSizeList = [
    {'name': 'Small-x24', 'val': 24.0},
    {'name': 'Medium-x32', 'val': 32.0},
    {'name': 'Large-x64', 'val': 64.0}
  ];
  String? selectedSize;

  final descTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'Roboto',
  );

  final descButton = BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: Colors.black38,
      ),
      color: Colors.blue);

  final descDropButton = BoxDecoration(
      border: Border.all(color: Colors.black38), color: Colors.black45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting', textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GetBuilder<MapController>(builder:(mc)=>ListView(
                  shrinkWrap: true,
                  children: List.generate(
                      tileSizeList.length,
                      (index) => ListTile(
                        leading: mc.tileSize.width==tileSizeList[index]['val']?const Icon(Icons.verified):null,
                          title: ElevatedButton(
                              child: Text(tileSizeList[index]['name']),
                              onPressed: () {
                                final item = tileSizeList[index];
                                MapController.to.setTileSize(
                                    Size(item['val'], item['val']));
                              }))))),
            ],
          ),
        ));
  }
}
