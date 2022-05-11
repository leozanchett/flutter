import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SelectedRequest {
  bus,
  trash,
}

class Config {
  String labelhorarios;
  SelectedRequest selectedRequest;
  String cidadeSelecionada;

  Config()
      : labelhorarios = 'ônibus',
        selectedRequest = SelectedRequest.bus,
        cidadeSelecionada = 'Joaçaba';
}

class ConfigController extends GetxController {
  late SharedPreferences _prefs;
  final config = Config().obs;

  @override
  void onInit() {
    _fetchConfig();
    super.onInit();
  }

  Future<void> _fetchConfig() async {
    await SharedPreferences.getInstance()
        .then((value) => {
              _prefs = value,
              config.update((val) {
                val!.cidadeSelecionada = _prefs.getString('cidadeSelecionada') ?? 'Joaçaba';
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
    });
  }
}
