import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting', textAlign: TextAlign.center ),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => {
          },
          child: const Text('select pattern'),
        ),
      )
    );
  }
}