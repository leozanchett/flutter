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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final config = Config().obs;

  @override
  void onInit() {
    _fetchConfig();
    super.onInit();
  }

  void _fetchConfig() async {
    await Future.delayed(const Duration(seconds: 3));
    config.update((val) {
      val!.selectedRequest = SelectedRequest.trash;
    });
  }

  SelectedRequest toggleRequest() {
    return config.value.selectedRequest == SelectedRequest.bus
        ? config.value.selectedRequest = SelectedRequest.trash
        : config.value.selectedRequest = SelectedRequest.bus;
  }
}
