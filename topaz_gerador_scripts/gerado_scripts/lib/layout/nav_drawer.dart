import 'package:flutter/material.dart';
import 'package:gerado_scripts/controllers/layout_controllers.dart';
import 'package:get/get.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find<LayoutController>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text('Script Padrão'),
            onTap: () {
              //drawerKey.currentState!.openEndDrawer();
              //controller.text = '0';
              layoutController.setPagAtual(LayoutController.scriptPadrao);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              layoutController.setPagAtual(LayoutController.drawer1);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
