import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_gsg/Auth/helpers/auth_helper.dart';
import 'package:firebase_gsg/Auth/helpers/firestore_helper.dart';
import 'package:firebase_gsg/Auth/providers/auth_provider.dart';
import 'package:firebase_gsg/services/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

class ChatPage extends StatefulWidget {
  static final String routeName = 'chatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageControler = TextEditingController();

  final ScrollController _controller = ScrollController();

  String sender = AuthHelper.authHelper.getUserId();

  String message;

  sendToFirestore() async {
    FirestoreHelper.firestoreHelper.addMessageToFirestore(
        {'message': this.message, 'dateTime': DateTime.now()});
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
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 55, left: 24, right: 24, bottom: 30),
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
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 640,
                    child: Column(children: [
                  Expanded(
                    child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirestoreHelper.firestoreHelper.getFirestoreStream(),
                        builder: (context, datasnapshot) {
                          Future.delayed(Duration(milliseconds: 100)).then((value) =>
                              {
                                _controller
                                    .jumpTo(_controller.position.maxScrollExtent)
                              });
                          if (!datasnapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                            );
                          }
                          QuerySnapshot querySnapshot = datasnapshot.data;
                          List<Map> messages =
                              querySnapshot.docs.map((e) => e.data()).toList();
                          return ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                              controller: _controller,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                bool isMe = messages[index]['userId'] ==
                                    Provider.of<AuthProvider>(context,
                                        listen: false)
                                        .myId;
                                return isMe
                                    ? Container(
                                  child: ChatBubble(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top: 20),
                                    backGroundColor: Color(0xffb98bc4) ,
                                    child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.7),
                                        child: messages[index]
                                        ['imageUrl'] ==
                                            null
                                            ? Text(
                                            messages[index]['message'] ?? '' ,
                                            style: TextStyle(
                                                color: Colors.black))
                                            : Image.network(messages[index]
                                        ['imageUrl'])),
                                    clipper: ChatBubbleClipper5(
                                        type: BubbleType.sendBubble),
                                  ),
                                )
                                    : ChatBubble(
                                  backGroundColor:  Color(0xffE5B2CA),
                                  margin: EdgeInsets.only(top: 20),
                                  child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.7,
                                      ),
                                      child: messages[index]['imageUrl'] ==
                                          null
                                          ? Text(
                                        messages[index]['message'] ?? '',
                                        style: TextStyle(
                                            color: Colors.white),
                                      )
                                          : Image.network(
                                          messages[index]['imageUrl'])),
                                  clipper: ChatBubbleClipper5(
                                      type: BubbleType.receiverBubble),
                                );
                              });

                        },
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      provider.sendImageToChat();
                                    },
                                    icon: Icon(Icons.attach_file)),
                                Expanded(
                                    child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                  controller: messageControler,
                                  onChanged: (x) {
                                    this.message = x;
                                  },
                                )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffb98bc4),
                                      borderRadius: BorderRadius.circular(80)),
                                  //padding: EdgeInsets.all(2),
                                  margin: EdgeInsets.all(5),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.send,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () {
                                        messageControler.clear();

                                        sendToFirestore();
                                      }))
                      ],
                    ),
                  ),
                ])),
              ],
            ),
          );
        },
      ),
    );
  }
}

