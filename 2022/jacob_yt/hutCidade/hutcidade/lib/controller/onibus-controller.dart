import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/classes/onibus.dart';
import 'package:hutcidade/classes/uteis.dart';
import 'package:hutcidade/services/database.dart';

class OnibusController extends GetxController {
  final onibus = Onibus().obs;
  RxList<Onibus> listaOnibus = <Onibus>[].obs;
  RxBool loading = false.obs;

  String _cidade_anterior = '';
  String _bairro_anterior = '';
  String _labelDataSelecionada_anterior = '';
  SelectedRequest? _selectedRequest_anterior;

  void fetch_lista_horarios_bus(Config config) async {
    if (!_is_same_request(config)) {
      listaOnibus.clear();
      register_config_values(config);
      try {
        loading.value = true;
        final String cidade_firebase = Uteis.formata_caminho_firebase(patch: config.cidadeSelecionada);
        final String bairro_firebase = Uteis.formata_caminho_firebase(patch: config.bairroSelecionado);
        DocumentSnapshot<Object?>? doc = await DatabaseService.getOnibusHorarios(cidade: cidade_firebase, bairro: bairro_firebase);
        var listaHorarios = doc!['registros'][config.labelDataSelecionada]?['horarios'];
        if (listaHorarios != null) {
          for (var horario in listaHorarios) {
            listaOnibus.add(Onibus.fromMap(horario));
          }

          listaOnibus.sort((a, b) => a.hora.compareTo(b.hora));
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
