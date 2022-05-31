import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/config.dart';

class ConfigController extends GetxController {
  late SharedPreferences _prefs;
  final config = Config().obs;
  Map<String, List<String>> _bairros = {};
  List<String> cidades_disponiveis = ['Joaçaba', 'Herval D" Oeste'];
  late RxBool loadingPrefs = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void bairros_das_cidades() {
    _bairros = {
      cidades_disponiveis[cidades_disponiveis.indexOf('Joaçaba')]: ['Cordazzo'], // 'Vila Pedrine', 'Centro', 'João Paulo II'],
      cidades_disponiveis[cidades_disponiveis.indexOf('Herval D" Oeste')]: ['Rupp', 'Centro'] // 'Viradouro',
    };
  }

  Future<void> fetchConfig() async {
    try {
      await SharedPreferences.getInstance()
          .then((value) => {
                _prefs = value,
                config.update((val) {
                  val!.cidadeSelecionada = _prefs.getString('cidadeSelecionada') ?? 'Joaçaba';
                  val.bairroSelecionado = _prefs.getString('bairroSelecionado') ?? 'Cordazzo';
                  switch (_prefs.getString('selectedRequest') ?? 'SelectedRequest.bus') {
                    case 'SelectedRequest.bus':
                      val.selectedRequest = SelectedRequest.bus;
                      break;
                    case 'SelectedRequest.trash':
                      val.selectedRequest = SelectedRequest.trash;
                      break;
                  }
                  val.labelhorarios = _getLabelHorarios();
                }),
              })
          .catchError(
            (e) => {
              config.update((val) {
                val!.cidadeSelecionada = 'Joaçaba';
                val.selectedRequest = SelectedRequest.bus;
                val.labelhorarios = _getLabelHorarios();
              })
            },
          );
    } finally {
      cidades_disponiveis.sort();
      bairros_das_cidades();
      loadingPrefs.value = false;
      update();
    }
  }

  String _getLabelHorarios() => config.value.selectedRequest == SelectedRequest.trash ? 'coleta de lixo' : 'ônibus';

  void toggleListaHorarios() {
    config.update((val) {
      val!.selectedRequest = val.selectedRequest == SelectedRequest.bus ? SelectedRequest.trash : SelectedRequest.bus;
      val.labelhorarios = _getLabelHorarios();
    });
    _prefs.setString('selectedRequest', config.value.selectedRequest.toString());
  }

  void changeCidade(String? cidade) {
    _prefs.setString('cidadeSelecionada', cidade!);
    config.update((val) {
      val!.cidadeSelecionada = cidade;
      val.bairroSelecionado = retornaBairrosDaCidade(cidade).first;
    });
  }

  void changeBairro(String? bairro) {
    _prefs.setString('bairroSelecionado', bairro!);
    config.update((val) {
      val!.bairroSelecionado = bairro;
    });
  }

  void changeDataRequest(String dataRequest) {
    config.update((val) {
      val!.dataRequest = dataRequest;
    });
  }

  void setDataRequest(DateTime date) {
    config.update((val) {
      val!.dataRequest = DateFormat('dd-MM-yyyy').format(date);
      // verifica se a data é um dia de semana
      if ((date.weekday != DateTime.saturday) & (date.weekday != DateTime.sunday)) {
        val.labelDataSelecionada = 'semana';
      } else {
        val.labelDataSelecionada = 'fds';
      }
    });
  }

  List<String> retornaBairrosDaCidade(String? cidade) {
    List<String> bairrosPorCidade = _bairros[cidade] ?? [];
    bairrosPorCidade.sort();
    return bairrosPorCidade;
  }
}
