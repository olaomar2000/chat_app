
import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:firebase_gsg/Auth/ui/reset_password_page.dart';
import 'package:firebase_gsg/Auth/ui/singup.dart';
import 'package:firebase_gsg/Auth/ui/widgets/custom_textfield.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_button.dart';

class login extends StatelessWidget {
  static final routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xffE5B2CA),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Image.asset('assets/images/login.png', height: 290,
                        width: double.infinity,),
                    ),
                    SizedBox(height: 30,),
                    Text('Welcome Back!',
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                    Text('Please, Log In.',
                      style: TextStyle(fontSize: 34, color: Colors.white),),
                    CustomTextfield('Email', provider.emailController),
                    SizedBox(height: 5,),
                    CustomTextfield('Password', provider.passwordController),
                    SizedBox(height: 5,),
                    CustomButton(provider.login1, 'login', Color(0xff78258B)),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        RouteHelper.routeHelper.goToPage(
                            ResetPasswordPage.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Forget Password?',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),



                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

