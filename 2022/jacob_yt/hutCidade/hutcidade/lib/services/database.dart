import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  static final CollectionReference onibus = FirebaseFirestore.instance.collection('/onibus/horarios/2022');

  static Future<DocumentSnapshot<Object?>?> getOnibusHorarios() async {
    try {
      DocumentSnapshot snapshot = await onibus.doc('joacaba').collection('cordazzo').doc('documento').get();
      return snapshot;
    } catch (e) {
      return null;
    }
  }
}
