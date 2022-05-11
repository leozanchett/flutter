import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/config.dart';

class ConfigController extends GetxController {
  late SharedPreferences _prefs;
  final config = Config().obs;
  Rx<bool> loadingPrefs = true.obs;

  @override
  Future<void> onInit() async {
    await _fetchConfig();
    super.onInit();
  }

  @override
  void onReady() {
    loadingPrefs.value = false;
    super.onReady();
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
      val.bairroSelecionado = Config.bairrosDisponiveis(cidade).first;
    });
  }

  void changeBairro(String? bairro) {
    _prefs.setString('bairroSelecionado', bairro!);
    config.update((val) {
      val!.bairroSelecionado = bairro;
    });
  }
}
