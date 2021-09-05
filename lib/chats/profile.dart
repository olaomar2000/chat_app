import 'dart:ui';

import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:firebase_gsg/chats/updateprofile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = 'profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xffF9F1F3),
        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return provider.user == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffE5B2CA),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(36),
                              bottomLeft: Radius.circular(36)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffE5B2CA).withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 55, left: 80, right: 24, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Group',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .fillControllers();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return UpdateProgile();
                                        }));
                                      },
                                      icon: Icon(Icons.edit),color: Colors.white,),
                                  IconButton(
                                      onPressed: () {
                                        Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .logout();
                                      },
                                      icon: Icon(Icons.logout),color: Colors.white,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(provider.user.imageUrl),
                      ),
                      ItemWidget('Email', provider.user.email),
                      ItemWidget('first Name', provider.user.fName),
                      ItemWidget('last Name', provider.user.lName),
                      //ItemWidget('country Name', provider.user.country),
                      //ItemWidget('city Name', provider.user.city),
                    ],
                  );
          },
        ));
  }
}

class ItemWidget extends StatelessWidget {
  String label;
  String value;

  ItemWidget(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 22),
          )
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    );
  }
}
