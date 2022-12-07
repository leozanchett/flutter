import 'package:flutter/material.dart';
import 'package:gerado_scripts/layout/nav_drawer.dart';
import 'package:gerado_scripts/screens/script_padrao.dart';
import 'package:get/get.dart';

import 'controllers/layout_controllers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey[400],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      initialBinding: BindingsBuilder(() => {Get.put(LayoutController())}),
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final LayoutController layoutController = Get.find<LayoutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Obx(() => Text(layoutController.pagAtual.value)),
        ),
        drawer: GetBuilder<LayoutController>(
          init: LayoutController(),
          builder: (controller) => const NavDrawer(),
        ),
        body: Container(
          color: Colors.blue,
          child: Obx(() => indexDrawer(layoutController.pagAtual.value)),
        ));
  }

  Widget indexDrawer(String drawerPag) {
    debugPrint(drawerPag);
    switch (drawerPag) {
      case LayoutController.scriptPadrao:
        return const ScriptPadrao();
      case LayoutController.drawer1:
        return const Text('drawer 1');
      default:
        return const Text('nenhum drawer');
    }
  }
}
