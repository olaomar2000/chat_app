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
      appBar: AppBar(
        backgroundColor: Color(0xffE5B2CA),
        title: Center(child: Text('Group Chat')),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Container(
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
                          // return MessageBubble(
                          //   sender: messages[index]['userId'],
                          //   text: messages[index]['message'],
                          //   isMe: this.sender == messages[index]['userId'],
                          //   time: messages[index]['dateTime'],
                          // );

                          //Text(messages[index]['message']);
                       // });
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
          ]));
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;

  final bool isMe;
  final Timestamp time;

  MessageBubble({this.sender, this.text, this.isMe, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender ?? ' ',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))
                : BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
            elevation: 2.0,
            color: isMe ? Color(0xffb98bc4) : Color(0xffE5B2CA),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 13.0),
              child: Text(
                '$text' ?? '',
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.black54 : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
