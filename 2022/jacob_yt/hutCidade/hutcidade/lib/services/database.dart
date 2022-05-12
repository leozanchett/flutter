import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static int requestCount = 0;

  // collection reference
  static final CollectionReference onibus = FirebaseFirestore.instance.collection('/onibus/horarios/2022');
  static final CollectionReference trash = FirebaseFirestore.instance.collection('/trash/horarios/2022');

  static Future<DocumentSnapshot<Object?>?> getOnibusHorarios({required String cidade, required String bairro, required bool isBus}) async {
    requestCount++;
    try {
      DocumentSnapshot snapshot;
      if (isBus) {
        snapshot = await onibus.doc(cidade).collection(bairro).doc('documento').get();
      } else {
        snapshot = await trash.doc(cidade).collection(bairro).doc('documento').get();
      }
      return snapshot;
    } catch (e) {
      return null;
    }
  }
}
