import 'package:cloud_firestore/cloud_firestore.dart';

import '../../country_model.dart';
import '../register_request.dart';
import '../user_model.dart';
import 'auth_helper.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  Stream<QuerySnapshot> getFirestoreStream() {
    return firebaseFirestore.collection('Chats').orderBy('dateTime').snapshots();
  }

  addMessageToFirestore(Map map) async {
    firebaseFirestore
        .collection('Chats')
        .add({...map, 'userId': AuthHelper.authHelper.getUserId()});
  }
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

  Future<UserModel> getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(userId).get();
    return UserModel.fromMap(documentSnapshot.data());
    print(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('Users').get();
    List docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((e) => UserModel.fromMap(e.data())).toList();

    return users;
  }

  Future<List<CountryModel>> getAllCountries() async {
    try {
      QuerySnapshot querySnapshot =
          await firebaseFirestore.collection('countries').get();
      List<CountryModel> countries = querySnapshot.docs.map((e) {
        Map map = e.data();
        map['id'] = e.id;
        return CountryModel.fromJson(map);
      }).toList();
      return countries;
    } on Exception catch (e) {
      // TODO
    }
  }

  updateProfile(UserModel userModel) async {
    await firebaseFirestore
        .collection('Users')
        .doc(userModel.id)
        .update(userModel.toMap());
  }
}
