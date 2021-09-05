import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:firebase_gsg/chats/chat_page.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  static final routeName = 'users';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffF9F1F3),
        body: Consumer<AuthProvider>(
      builder: (context, provider, x) {
        if (provider.users == null) {
          print('pppppp');
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE5B2CA)),
            ),
          );
        } else {
          return Column(
            children: [
              Container(
                height: 210,
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
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 55, left: 24, right: 24, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Messages',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                  image: NetworkImage(
                                      provider.user.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),

                              ),
                             // Text(provider.user.fName)
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 55,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.users.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 7),
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      provider.users[index].imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: provider.users.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 7),
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Color(0xffE5B2CA).withOpacity(0.9),
                                  //     spreadRadius: 2,
                                  //     blurRadius: 10,
                                  //     offset: Offset(0, 1), // changes position of shadow
                                  //   ),
                                  // ],
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        provider.users[index].imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(provider.users[index].fName +
                                        ' ' +
                                        provider.users[index].lName,style: TextStyle(
                                      fontSize:20 ,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffE5B2CA)
                                    ),),
                                    SizedBox(height: 5,),
                                    Text(provider.users[index].email ,style: TextStyle(
                                        fontSize:15 ,
                                        color: Colors.black54,
                                    ),)
                                  ],
                                ),
                              ),
                            ],
                          ));
                    }),
              )
            ],
          );
        }
      },
    ));
  }
}
