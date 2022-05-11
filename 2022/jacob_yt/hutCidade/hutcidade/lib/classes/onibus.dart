import 'package:cloud_firestore/cloud_firestore.dart';

class Onibus {
  String hora;
  String rota;

  Onibus()
      : hora = '',
        rota = '';

  Onibus.fromMap(Map<String, dynamic> map)
      : hora = map['hora'],
        rota = map['rota'];
}
