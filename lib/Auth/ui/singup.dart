import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:firebase_gsg/Auth/ui/login.dart';
import 'package:firebase_gsg/Auth/ui/widgets/custom_textfield.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../country_model.dart';
import 'widgets/custom_button.dart';

class singup extends StatelessWidget {
  static final routeName = '/register';
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffE5B2CA),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
/*child: Image.asset(
                    'assets/images/singup.png',
                    height: 290,
                    width: double.infinity,
                  ),*/
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Hi there!',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  'Let’s Get Started',
                  style: TextStyle(fontSize: 34, color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    provider.selectFile();
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.grey,
                    child: provider.file == null
                        ? Container()
                        : Image.file(provider.file, fit: BoxFit.cover),
                  ),
                ),
                CustomTextfield('Email', provider.emailController),
                SizedBox(
                  height: 5,
                ),
                CustomTextfield('Password', provider.passwordController),
                SizedBox(
                  height: 5,
                ),
                CustomTextfield('First name', provider.FName),
                SizedBox(
                  height: 5,
                ),
                CustomTextfield('last name', provider.LName),
                SizedBox(
                  height: 5,
                ),
                provider.countries == null
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<CountryModel>(
                          isExpanded: true,
                          underline: Container(),
                          value: provider.selectedCountry,
                          onChanged: (x) {
                            provider.selectCountry(x);
                          },
                          items: provider.countries.map((e) {
                            return DropdownMenuItem<CountryModel>(
                              child: Text(e.name),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                provider.countries == null
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<dynamic>(
                          isExpanded: true,
                          underline: Container(),
                          value: provider.selectedCity,
                          onChanged: (x) {
                            provider.selectCity(x);
                          },
                          items: provider.cities.map((e) {
                            return DropdownMenuItem<dynamic>(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                CustomButton(
                    provider.register, 'Create an Account', Color(0xff52439A)),
              ],
            ),
          ),
        ),
      );
    });
  }
}
