import 'package:cloud_firestore/cloud_firestore.dart';

UseFirebase useFirebase() {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchItems() {
    return FirebaseFirestore.instance
        .collection('flights')
        .orderBy('time', descending: true)
        .snapshots();
  }

  void insertItem(Map<String, dynamic> item) {
    FirebaseFirestore.instance.collection('flights').add(item);
  }

  return UseFirebase(fetchItems: fetchItems, insertItem: insertItem);
}

class UseFirebase {
  final Stream<QuerySnapshot<Map<String, dynamic>>> Function() fetchItems;
  final void Function(Map<String, dynamic> item) insertItem;
  UseFirebase({required this.fetchItems, required this.insertItem});
}
