import 'dart:ui';

import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProgile extends StatefulWidget {
  static final routeName = 'updateprofile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UpdateProgile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xffF9F1F3),

        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return SingleChildScrollView(
              child: Column(
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
                          IconButton(
                            onPressed: () {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .updateProfile();
                            },
                            icon: Icon(Icons.done,color: Colors.white,),
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      provider.captureUpdateProfileImage();
                    },
                    child: provider.updatedFile == null
                        ? CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage(provider.user.imageUrl),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: FileImage(provider.updatedFile),
                          ),
                  ),
                  ItemWidget('first Name', provider.FName),
                  ItemWidget('last Name', provider.LName),
                  //  ItemWidget('country Name', provider.countryController),
                  //ItemWidget('city Name', provider.cituController),
                ],
              ),
            );
          },
        ));
  }
}

class ItemWidget extends StatelessWidget {
  String label;
  TextEditingController valueController;
  ItemWidget(this.label, this.valueController);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: valueController,
              style: TextStyle(fontSize: 22),
            ),
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
