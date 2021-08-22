import 'package:firebase_gsg/Auth/register_request.dart';
import 'package:firebase_gsg/Auth/helpers/auth_helper.dart';
import 'package:firebase_gsg/Auth/helpers/firebase_helper.dart';
import 'package:firebase_gsg/Auth/ui/login.dart';
import 'package:firebase_gsg/chats/home_page.dart';
import 'package:firebase_gsg/services/custom_dialoug.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_gsg/Auth/ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthProvider extends ChangeNotifier {
// TabController tabController;
 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();
 TextEditingController FName = TextEditingController();
 TextEditingController LName = TextEditingController();
 resetControllers() {
  emailController.clear();
  passwordController.clear();
 }

 register() async {
  try {
   UserCredential userCredinial = await AuthHelper.authHelper
       .signup(emailController.text, passwordController.text);

   RegisterRequest registerRequest = RegisterRequest(
    id:userCredinial.user.uid,
    email: emailController.text,
    LName: LName.text,
    FName: FName.text

   );
   await FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
   await AuthHelper.authHelper.verifyEmail();
   await AuthHelper.authHelper.logout();
  // tabController.animateTo(1);
  } on Exception catch (e) {
   print('eeeeeeeeeeeeeeeeee');
  }
  RouteHelper.routeHelper.goToPage(login.routeName);


  resetControllers();
 }

 login1() async {
  UserCredential userCredinial =await AuthHelper.authHelper
      .signin(emailController.text, passwordController.text);
  FirestoreHelper.firestoreHelper
      .getUserFromFirestore(userCredinial.user.uid);
  bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
  if (isVerifiedEmail) {
   print('done');
   RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
  } else {
   CustomDialoug.customDialoug.showCustomDialoug(
       'You have to verify your email, press ok to send another email',
       sendVericiafion);
  }
  resetControllers();
 }

 sendVericiafion() {
  AuthHelper.authHelper.verifyEmail();
  AuthHelper.authHelper.logout();
 }

 resetPassword() async {
  AuthHelper.authHelper.resetPassword(emailController.text);
  resetControllers();
 }




}

