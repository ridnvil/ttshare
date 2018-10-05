import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttshare/utils/authentication.dart';
import 'package:ttshare/utils/database.dart';

class Profile extends StatefulWidget {
  final String uid;
  final bool isMe;

  const Profile({Key key, @required this.uid, this.isMe = false})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: !widget.isMe
          ? FutureBuilder<DocumentSnapshot>(
          future: Database.getUser(widget.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return Text(snapshot.data['name']);
          })
          : FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, user) {
          if (!user.hasData)
            return Center(child: CircularProgressIndicator());
          return ProfileDetail(
            displayName: user.data.displayName,
            photoUrl: user.data.photoUrl,
          );
        },
      ),
    );
  }
}

class ProfileDetail extends StatefulWidget {
  final String displayName, photoUrl;

  const ProfileDetail({Key key, this.displayName, this.photoUrl})
      : super(key: key);

  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 120.0,
            width: 120.0,
            child: CircleAvatar(
              backgroundColor: Colors.grey[400],
              backgroundImage: NetworkImage(widget.photoUrl),
            ),
          ),
          Text(
            widget.displayName,
            style: TextStyle(fontSize: 18.0),
          ),
          RaisedButton(
              color: Colors.red[400],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.exit_to_app, color: Colors.white),
                  Text('Keluar dari akun',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              onPressed: () {
                var auth = new Authentication();
                auth.signOut().whenComplete(() {
                  Navigator.pushReplacementNamed(context, '/login');
                });
              })
        ],
      ),
    );
  }
}
