import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:firebase_gsg/chats/chat_page.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  static final routeName = 'users';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffE5B2CA),
          title: Center(child: Text('All User')),
          actions: [
            IconButton(
              onPressed: () {
                RouteHelper.routeHelper
                    .goToPageWithReplacement(ChatPage.routeName);
              },
              icon: Icon(Icons.group),
            )
          ],
        ),
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
              return ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    return Container(

                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  NetworkImage(provider.users[index].imageUrl),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(provider.users[index].fName +
                                      ' ' +
                                      provider.users[index].lName),
                                  Text(provider.users[index].email)
                                ],
                              ),
                            ),
                          ],
                        ));
                  });
            }
          },
        ));
  }
}
