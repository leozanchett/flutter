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
    await _fetchConfig();
    super.onInit();
  }

  @override
  void onReady() {
    cidades_disponiveis.sort();
    bairros_das_cidades();
    loadingPrefs.value = false;
    update();
    super.onReady();
  }

  void bairros_das_cidades() {
    _bairros = {
      cidades_disponiveis[cidades_disponiveis.indexOf('Joaçaba')]: ['Vila Cordazzo', 'Vila Pedrine', 'Centro', 'João Paulo II'],
      cidades_disponiveis[cidades_disponiveis.indexOf('Herval D" Oeste')]: ['Rupp', 'Viradouro', 'Centro', 'Vila Pedrine']
    };
  }

  Future<void> _fetchConfig() async {
    await SharedPreferences.getInstance()
        .then((value) => {
              _prefs = value,
              config.update((val) {
                val!.cidadeSelecionada = _prefs.getString('cidadeSelecionada') ?? 'Joaçaba';
                val.bairroSelecionado = _prefs.getString('bairroSelecionado') ?? 'Centro';
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
  }

  String _getLabelHorarios() => config.value.selectedRequest == SelectedRequest.trash ? 'caminhão do lixo' : 'ônibus';

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
    });
  }

  List<String> retornaBairrosDaCidade(String? cidade) {
    List<String> bairrosPorCidade = _bairros[cidade] ?? [];
    bairrosPorCidade.sort();
    return bairrosPorCidade;
  }
}
