import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'life_panel.dart';
import 'map_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
//  static final MapController mapc = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
        init: MapController(),
        builder: (mc) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text("SLG Home"),
                  mc.dirty ? const Text("*") : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () {
                            mc.clear(1, 1);
                            Get.to(const LifePanel(title: "SLG Editor"));
                          },
                          child: const Text('New')),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(const LifePanel(title: "SLG Editor"));
                          },
                          child: const Text('Edit')),
                      ElevatedButton(
                          onPressed: () {
                            mc.map().loadLexi(0);
                            Get.to(const LifePanel(title: "SLG Editor"));
                          },
                          child: const Text('Load')),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Settings')),
                    ],
                  )
                ]));
  }
}
