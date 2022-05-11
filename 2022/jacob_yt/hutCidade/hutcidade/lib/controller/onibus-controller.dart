import 'package:get/get.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/classes/onibus.dart';

class OnibusController extends GetxController {
  final onibus = Onibus().obs;
  RxMap listaHorarios = {}.obs;
  RxList<Onibus> listaOnibus = <Onibus>[].obs;

  void makeFirebaseRequest(Config config) async {
    Onibus novoOnibus = Onibus();
    novoOnibus.data = config.dataRequest;
    novoOnibus.hora = '13:30';
    novoOnibus.empresa = 'Estrelatur';

    listaOnibus.add(novoOnibus);
  }
}
