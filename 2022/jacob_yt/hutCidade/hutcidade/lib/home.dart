import 'package:flutter/material.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/layout/body-home.dart';
import 'package:get/get.dart';

import 'controller/config-controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ConfigController>(
      init: ConfigController(),
      initState: (_) {},
      builder: (_cfgController) {
        switch (_cfgController.loadingPrefs.value) {
          case true:
            return const Center(
              child: CircularProgressIndicator(),
            );

          default:
            return Scaffold(
              appBar: AppBar(
                leading: const Icon(
                  Icons.location_city,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _dropDown(
                          items: Config.cidadesDisponiveis(),
                          value: _cfgController.config.value.cidadeSelecionada,
                          onChanged: _cfgController.changeCidade,
                          primaryColor: Theme.of(context).primaryColor),
                      const SizedBox(width: 10),
                      _dropDown(
                          items: Config.retornaBairrosDaCidade(_cfgController.config.value.cidadeSelecionada),
                          value: _cfgController.config.value.bairroSelecionado,
                          onChanged: _cfgController.changeBairro,
                          primaryColor: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),
              body: const BodyHome(),
              persistentFooterButtons: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: null,
                        child: Text(
                          'Horário ${_cfgController.config.value.labelhorarios}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                      color: Colors.white,
                      onPressed: () => _cfgController.toggleListaHorarios(),
                      icon: Icon(
                        Icons.delete_outlined,
                        size: _cfgController.config.value.selectedRequest == SelectedRequest.trash ? 30 : 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.directions_bus_outlined,
                        size: _cfgController.config.value.selectedRequest == SelectedRequest.bus ? 30 : 20,
                      ),
                      color: Colors.white,
                      onPressed: () => _cfgController.toggleListaHorarios(),
                    ),
                  ],
                ),
              ],
            );
        }
      },
    );
  }
}

DropdownButton<String> _dropDown({required Color primaryColor, required List<String> items, required onChanged, required String value}) {
  return DropdownButton<String>(
    dropdownColor: primaryColor,
    value: value,
    isExpanded: false,
    isDense: true,
    style: const TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    icon: const Icon(
      Icons.arrow_downward,
      color: Colors.grey,
    ),
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (String? value) {
      onChanged(value);
    },
  );
}