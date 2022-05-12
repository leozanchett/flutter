import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/classes/horario.dart';
import 'package:hutcidade/classes/uteis.dart';
import 'package:hutcidade/services/database.dart';

class HorarioController extends GetxController {
  final horarios = Horarios().obs;
  RxList<Horarios> listaHorarios = <Horarios>[].obs;
  RxBool loading = false.obs;

  String _cidade_anterior = '';
  String _bairro_anterior = '';
  String _labelDataSelecionada_anterior = '';
  SelectedRequest? _selectedRequest_anterior;

  void fetch_lista_horarios(Config config) async {
    if (!_is_same_request(config)) {
      listaHorarios.clear();
      register_config_values(config);
      try {
        loading.value = true;
        final String cidade_firebase = Uteis.formata_caminho_firebase(patch: config.cidadeSelecionada);
        final String bairro_firebase = Uteis.formata_caminho_firebase(patch: config.bairroSelecionado);
        DocumentSnapshot<Object?>? doc = await DatabaseService.getOnibusHorarios(
            cidade: cidade_firebase, bairro: bairro_firebase, isBus: config.selectedRequest == SelectedRequest.bus);
        var listaDocs = doc!['registros'][config.labelDataSelecionada]?['horarios'];
        if (listaDocs != null) {
          listaDocs.forEach((element) {
            listaHorarios.add(Horarios.fromMap(element));
          });
          listaHorarios.sort((a, b) => a.hora.compareTo(b.hora));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      } finally {
        loading.value = false;
      }
    }
  }

  bool _is_same_request(Config config) {
    return config.selectedRequest == _selectedRequest_anterior &&
        config.cidadeSelecionada == _cidade_anterior &&
        config.labelDataSelecionada == _labelDataSelecionada_anterior &&
        config.bairroSelecionado == _bairro_anterior;
  }

  void register_config_values(Config config) {
    _selectedRequest_anterior = config.selectedRequest;
    _cidade_anterior = config.cidadeSelecionada;
    _bairro_anterior = config.bairroSelecionado;
    _labelDataSelecionada_anterior = config.labelDataSelecionada;
  }
}
