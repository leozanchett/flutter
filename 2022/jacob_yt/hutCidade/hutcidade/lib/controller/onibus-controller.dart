import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/classes/onibus.dart';
import 'package:hutcidade/services/database.dart';

class OnibusController extends GetxController {
  final onibus = Onibus().obs;
  RxMap listaHorarios = {}.obs;
  RxList<Onibus> listaOnibus = <Onibus>[].obs;
  RxBool loading = false.obs;

  String _data_anterior = '';
  String _cidade_anterior = '';
  String _bairro_anterior = '';
  SelectedRequest? _selectedRequest_anterior;

  void fetch_lista_horarios_bus(Config config) async {
    if (!_is_same_request(config)) {
      register_config_values(config);
      try {
        loading.value = true;
        DocumentSnapshot<Object?>? doc = await DatabaseService.getOnibusHorarios();
        var listaHorarios = doc!['registros']['semana']['horarios'];
        for (var horario in listaHorarios) {
          listaOnibus.add(Onibus.fromMap(horario));
        }
        listaOnibus.sort((a, b) => a.hora.compareTo(b.hora));
      } finally {
        loading.value = false;
      }
    }
  }

  bool _is_same_request(Config config) {
    return config.selectedRequest == _selectedRequest_anterior &&
        config.cidadeSelecionada == _cidade_anterior &&
        config.dataRequest == _data_anterior &&
        config.bairroSelecionado == _bairro_anterior;
  }

  void register_config_values(Config config) {
    _selectedRequest_anterior = config.selectedRequest;
    _cidade_anterior = config.cidadeSelecionada;
    _bairro_anterior = config.bairroSelecionado;
    _data_anterior = config.dataRequest;
  }
}
