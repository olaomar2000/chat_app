import 'package:firebase_gsg/Auth/helpers/firestore_helper.dart';
import 'package:firebase_gsg/chats/profile.dart';
import 'package:firebase_gsg/chats/user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final routeName = '/home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child:
            Scaffold(body: TabBarView(children: [UsersPage(), ProfilePage()])));
  }
}
