import 'package:get/get.dart';

class LayoutController extends GetxController {
  static const scriptPadrao = 'Script Padrão';
  static const drawer1 = 'drawer1';

  RxString pagAtual = 'Topaz Client'.obs;

  void setPagAtual(String pagName) {
    pagAtual.value = pagName;
  }
}
