import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  static final CollectionReference onibus = FirebaseFirestore.instance.collection('/onibus/horarios/2022');

  static Future<DocumentSnapshot<Object?>?> getOnibusHorarios({required String cidade, required String bairro}) async {
    try {
      DocumentSnapshot snapshot = await onibus.doc(cidade).collection(bairro).doc('documento').get();
      return snapshot;
    } catch (e) {
      return null;
    }
  }
}
