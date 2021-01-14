import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class database {
  final String uid;

  database({this.uid});

  final fb = FirebaseDatabase.instance;

  Future updateUserData(String email, String password) async {
    final ref = fb.reference();
    ref.child('UserId').set({
      'id': uid,
      'Name': email,
      'Phone': password
    });
    final f_ref = FirebaseFirestore.instance;
    f_ref.collection('users').doc(uid).set(
      {
        "user": uid,
        "Email":email,
        "Password": password
      }
    );
  }
}