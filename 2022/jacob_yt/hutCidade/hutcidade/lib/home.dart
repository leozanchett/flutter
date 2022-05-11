import 'package:flutter/material.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/layout/body-home.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<String> title;
  final _cfgController = Get.put(ConfigController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.location_city,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Obx(
          () => DropdownButton<String>(
            dropdownColor: Theme.of(context).primaryColor,
            value: _cfgController.config.value.cidadeSelecionada,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            icon: const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
            ),
            items: <String>['Joaçaba', 'Herval D"Oeste'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              _cfgController.changeCidade(value);
            },
          ),
        ),
      ),
      body: const BodyHome(),
      persistentFooterButtons: [
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text(
                    'Horários ${_cfgController.config.value.labelhorarios}',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () => _cfgController.toggleListaHorarios(),
                icon: Icon(
                  Icons.restore_from_trash,
                  size: _cfgController.config.value.selectedRequest == SelectedRequest.trash ? 30 : 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(
                  Icons.bus_alert,
                  size: _cfgController.config.value.selectedRequest == SelectedRequest.bus ? 30 : 20,
                ),
                color: Colors.white,
                onPressed: () => _cfgController.toggleListaHorarios(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
