import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_gsg/country_model.dart';

import '../register_request.dart';
import '../user_model.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      // await firebaseFirestore.collection('Users').add(registerRequest.toMap());
      await firebaseFirestore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } on Exception catch (e) {
      print(e);
    }
  }

  getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
    await firebaseFirestore.collection('Users').doc(userId).get();

    print(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    List<UserModel> users =
    docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }

  Future<List<CountryModel>> getAllCountries() async {
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('Countries').get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs.map((e) {
Map map = e.data();
map['id'] = e.id;
return CountryModel.fromJson(map);
    }).cast<QueryDocumentSnapshot>().toList();

  }



}

