import 'package:cloud_firestore/cloud_firestore.dart';
class database {
  final String uid;
  database({this.uid});

  final CollectionReference ref = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String email , String password) async {
    return await ref.doc(await uid).set({
      'Email': email,
      'Password': password,
    });

  }
}