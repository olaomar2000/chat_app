
import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:firebase_gsg/Auth/ui/login.dart';
import 'package:firebase_gsg/Auth/ui/widgets/custom_textfield.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_button.dart';

class singup extends StatelessWidget{
  static final routeName = '/register';
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
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Image.asset(
                        'assets/images/singup.png', height: 290,
                        width: double.infinity,),
                    ),
                    SizedBox(height: 30,),
                    Text('Hi there!',
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                    Text('Let’s Get Started',
                      style: TextStyle(fontSize: 34, color: Colors.white),),
                    CustomTextfield('Email',provider. emailController),
                    SizedBox(height: 5,),
                    CustomTextfield('Password',provider. passwordController),
                    SizedBox(height: 5,),
                    CustomButton(provider.register, 'Create an Account', Color(0xff52439A)),


                  ],
                ),
              ),
            ),
          );
        }
        );
  }

}