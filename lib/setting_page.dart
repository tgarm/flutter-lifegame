import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<String> patterns = ['Pattern1', 'Pattern2', 'Pattern3', 'Custom'];
  String? selectedPattern;
  final List<String> sizes = ['small','middle','big'];
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
    color: Colors.blue
  );
   
  final descDropButton = BoxDecoration(
    border: Border.all(
      color: Colors.black38
    ),
    color: Colors.black45
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting', textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: const Text('select pattern'),
                  items: patterns
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: descTextStyle
                          ),
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
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                hint: const Text('select size'),
                items: sizes
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: descTextStyle
                          ),
                        ))
                    .toList(),
                value: selectedSize,
                onChanged: (value) {
                  setState(() {
                    selectedSize = value as String;
                  });
                },
                buttonDecoration: descButton,
                dropdownDecoration: descDropButton,
              )),
            ],
          ),
        ));
  }
}
