
import 'package:firebase_gsg/chats/chat_page.dart';
import 'package:firebase_gsg/chats/profile.dart';
import 'package:firebase_gsg/chats/user.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

class Home extends StatefulWidget {
  static final routeName = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          UsersPage(),
          ChatPage(),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Color(0xffE5B2CA),
          ),
          BottomBarItem(
            icon: Icon(Icons.group),
            title: Text('Group'),
            activeColor: Color(0xffE5B2CA),
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('profile'),
            activeColor: Color(0xffE5B2CA),

          ),

        ],
      ),
    );
  }
}
