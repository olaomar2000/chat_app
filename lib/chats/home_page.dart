import 'package:firebase_gsg/Auth/helpers/firebase_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final routeName = '/home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Center(
        child: RaisedButton(onPressed: () {
      FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
    }
    ),
      ),
    );
  }
}
