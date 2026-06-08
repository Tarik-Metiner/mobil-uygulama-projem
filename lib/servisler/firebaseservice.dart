import 'package:cloud_firestore/cloud_firestore.dart';

import '../modeller/besinmodeli.dart';
import '../modeller/egzersizmodeli.dart';

class FirebaseService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  CollectionReference get besinler =>
      _firestore.collection("besinler");

  CollectionReference get egzersizler =>
      _firestore.collection("egzersizler");

  // BESİNLER

  Stream<List<BesinModeli>> getBesinler() {
    return besinler.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data =
            doc.data() as Map<String, dynamic>?;

        return BesinModeli.fromFirestore(data);
      }).toList();
    });
  }

  Future<void> addBesin(
    BesinModeli besin,
  ) async {
    await besinler
        .doc(besin.id)
        .set(besin.toFirestore());
  }

  Future<void> updateBesin(
    BesinModeli besin,
  ) async {
    await besinler
        .doc(besin.id)
        .update(besin.toFirestore());
  }

  Future<void> deleteBesin(
    String id,
  ) async {
    await besinler.doc(id).delete();
  }

  // EGZERSİZLER

  Stream<List<EgzersizModeli>>
      getEgzersizler() {
    return egzersizler
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data =
            doc.data() as Map<String, dynamic>?;

        return EgzersizModeli.fromFirestore(
          data ?? {},
        );
      }).toList();
    });
  }

  Future<void> addEgzersiz(
    EgzersizModeli egzersiz,
  ) async {
    await egzersizler
        .doc(egzersiz.id)
        .set(egzersiz.toFirestore());
  }

  Future<void> updateEgzersiz(
    EgzersizModeli egzersiz,
  ) async {
    await egzersizler
        .doc(egzersiz.id)
        .update(
          egzersiz.toFirestore(),
        );
  }

  Future<void> deleteEgzersiz(
    String id,
  ) async {
    await egzersizler.doc(id).delete();
  }
}