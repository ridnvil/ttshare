import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttshare/ui-base/explore.dart';
import 'package:ttshare/ui-base/feeds.dart';
import 'package:ttshare/ui-base/plans.dart';
import 'package:ttshare/ui-base/profile.dart';
import 'package:ttshare/ui-base/tourist_chat.dart';

class UserArea extends StatefulWidget {
  final FirebaseUser user;

  const UserArea({Key key, @required this.user}) : super(key: key);

  @override
  _UserAreaState createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  int _currentIndex = 0;
  String title = "Feeds";

  final List<Widget> _children = [];

  void onTabTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          title = "Feeds";
          break;
        case 1:
          title = "Explore";
          break;
        case 2:
          title = "Plan";
          break;
      }
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _children.addAll([
      Feeds(),
      Explore(),
      Plans(),
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
        leading: Container(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Profile(uid: widget.user.uid, isMe: true)),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[400],
              backgroundImage: NetworkImage(widget.user.photoUrl),
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            color: Colors.grey[600],
            onPressed: () =>
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TouristChat(user: widget.user))),
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: Icon(Icons.home, color: Colors.black),
            icon: Icon(Icons.home, color: Colors.grey[600]),
            title: Text('Feeds', style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: Icon(Icons.explore, color: Colors.black),
            icon: Icon(Icons.explore, color: Colors.grey[600]),
            title: Text('Explore', style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: Icon(Icons.date_range, color: Colors.black),
            icon: Icon(Icons.date_range, color: Colors.grey[600]),
            title: Text('Plan', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
