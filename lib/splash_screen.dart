import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) =>
        Provider.of<AuthProvider>(context, listen: false).checkLogin());
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffE5B2CA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Text('CHAT APP',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
