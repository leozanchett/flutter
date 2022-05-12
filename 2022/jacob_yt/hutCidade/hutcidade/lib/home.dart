import 'package:flutter/material.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/layout/body-home.dart';
import 'package:get/get.dart';
import 'package:hutcidade/services/adMob.dart';

import 'controller/config-controller.dart';
import 'controller/horarios-controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final HorarioController _horarioController = Get.put(HorarioController());
  final ADMobService _adMobService = Get.put(ADMobService());
  @override
  Widget build(BuildContext context) {
    return GetX<ConfigController>(
      init: ConfigController(),
      initState: (_) {},
      builder: (_cfgController) {
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.location_city,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            title: _cfgController.loadingPrefs.value
                ? Container()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _dropDown(
                            items: _cfgController.cidades_disponiveis,
                            value: _cfgController.config.value.cidadeSelecionada,
                            onChanged: _cfgController.changeCidade,
                            bairro: false,
                            primaryColor: Theme.of(context).primaryColor),
                        const SizedBox(width: 10),
                        _dropDown(
                            items: _cfgController.retornaBairrosDaCidade(_cfgController.config.value.cidadeSelecionada),
                            value: _cfgController.config.value.bairroSelecionado,
                            bairro: true,
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
                  onPressed: _horarioController.loading.value
                      ? null
                      : () {
                          _horarioController.listaHorarios.clear();
                          _cfgController.toggleListaHorarios();
                          _horarioController.fetch_lista_horarios(_cfgController.config.value);
                        },
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
                  onPressed: _horarioController.loading.value
                      ? null
                      : () {
                          _horarioController.listaHorarios.clear();
                          _cfgController.toggleListaHorarios();
                          _horarioController.fetch_lista_horarios(_cfgController.config.value);
                        },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

DropdownButton<String> _dropDown(
    {required Color primaryColor, required List<String> items, required onChanged, required String value, required bool bairro}) {
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
      Get.find<HorarioController>().listaHorarios.clear();
      onChanged(value);
      if (bairro) {
        Get.find<HorarioController>().fetch_lista_horarios(Get.find<ConfigController>().config.value);
      }
    },
  );
}
