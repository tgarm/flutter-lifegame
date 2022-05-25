import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lifegame/map_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // TODO: pattern should named
  final List<String> patterns = ['Pattern1', 'Pattern2', 'Pattern3', 'Custom'];
  String? selectedPattern;
  final List tileSizeList = [
    {'name': 'small', 'val': 16.0},
    {'name': 'middle', 'val': 32.0},
    {'name': 'big', 'val': 64.0}
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
              DropdownButtonHideUnderline(
                  child: DropdownButton2(
                hint: const Text('select pattern'),
                items: patterns
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: descTextStyle),
                        ))
                    .toList(),
                value: selectedPattern,
                onChanged: (value) {
                  setState(() {
                    selectedPattern = value as String;
                  });
                },
                buttonDecoration: descButton,
                dropdownDecoration: descDropButton,
              )),
              ListView(
                  shrinkWrap: true,
                  children: List.generate(
                      tileSizeList.length,
                      (index) => ListTile(
                          title: ElevatedButton(
                              child: Text(tileSizeList[index]['name']),
                              onPressed: () {
                                final item = tileSizeList[index];
                                MapController.to.setTileSize(
                                    Size(item['val'], item['val']));
                              })))),
            ],
          ),
        ));
  }
}
