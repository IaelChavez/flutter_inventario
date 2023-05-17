import 'package:cloud_firestore/cloud_firestore.dart';

class DataItem<T> {
  late T item;

  DataItem({required DocumentSnapshot snapshot, required T Function(DocumentSnapshot) fromDocumentSnapshot}) {
    item = fromDocumentSnapshot(snapshot);
  }
}