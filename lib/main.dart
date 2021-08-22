import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:firebase_gsg/Auth/ui/login.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:firebase_gsg/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Auth/ui/reset_password_page.dart';
import 'Auth/ui/singup.dart';
import 'chats/home_page.dart';
// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (context)=> AuthProvider(),
//     child: MaterialApp(home: firebase_conf(),)));
// }
void main() {
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(
          routes: {

            login.routeName: (context) => login(),
            singup.routeName: (context) => singup(),
            ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
            HomePage.routeName: (context) => HomePage(),
          },
          navigatorKey: RouteHelper.routeHelper.navKey,
          home: firebase_conf())));
}
 

class firebase_conf extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<FirebaseApp>(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, AsyncSnapshot<FirebaseApp> snapshot) {
        
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('done');
          return splash();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

}