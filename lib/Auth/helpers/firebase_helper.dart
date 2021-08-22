import 'package:cloud_firestore/cloud_firestore.dart';

import '../RegisterRequest.dart';
class FirestoreHelper{

  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addUserToFirebase(RegisterRequest registerRequest)async{
    firestore.collection('user').add(registerRequest.toMap());
  }
}

