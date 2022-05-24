import 'package:flutter/material.dart';
import 'life_panel.dart';

void main() {
  runApp(const LifeGameApp());
}

class LifeGameApp extends StatelessWidget {
  const LifeGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple LifeGame',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LifePanel(title: 'SLG Home'),
    );
  }
}
