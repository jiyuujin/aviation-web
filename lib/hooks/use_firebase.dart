import 'package:cloud_firestore/cloud_firestore.dart';

UseFirebase useFirebase() {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchItems() {
    return FirebaseFirestore.instance
        .collection('flights')
        .orderBy('time', descending: true)
        .snapshots();
  }

  return UseFirebase(fetchItems: fetchItems);
}

class UseFirebase {
  final Stream<QuerySnapshot<Map<String, dynamic>>> Function() fetchItems;
  UseFirebase({required this.fetchItems});
}
