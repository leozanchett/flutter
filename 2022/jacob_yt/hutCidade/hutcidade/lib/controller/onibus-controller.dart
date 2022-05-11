import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hutcidade/classes/config.dart';
import 'package:hutcidade/classes/onibus.dart';
import 'package:hutcidade/services/database.dart';

class OnibusController extends GetxController {
  final onibus = Onibus().obs;
  RxMap listaHorarios = {}.obs;
  RxList<Onibus> listaOnibus = <Onibus>[].obs;

  void makeFirebaseRequest(Config config) async {
    DocumentSnapshot<Object?>? doc = await DatabaseService.getOnibusHorarios();
    var listaHorarios = doc!['registros']['semana']['horarios'];
    for (var horario in listaHorarios) {
      listaOnibus.add(Onibus.fromMap(horario));
    }
    listaOnibus.sort((a, b) => a.hora.compareTo(b.hora));
  }
}
