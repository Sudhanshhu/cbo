import 'package:cloud_firestore/cloud_firestore.dart';

class FirestorePath {
  static CollectionReference employeeRoutePath =
      FirebaseFirestore.instance.collection("employee");
}
