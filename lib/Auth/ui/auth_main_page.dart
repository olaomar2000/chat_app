import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthMainPage extends StatefulWidget {
  static final routeName = 'AuthMainPage';
  @override
  State<AuthMainPage> createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
    );
  }
}
