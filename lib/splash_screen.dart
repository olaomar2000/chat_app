import 'dart:async';

import 'package:firebase_gsg/Auth/helpers/sp_helper.dart';
import 'package:firebase_gsg/Auth/ui/singup.dart';
import 'package:firebase_gsg/chats/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget{
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      String user = await SPHelper.spHelper.getUser();
      if(user == null || user ==''){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => singup()),
        );
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Text('CHAT APP'),
    ),
  );
  }
}