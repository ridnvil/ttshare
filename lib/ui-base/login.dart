import 'package:flutter/material.dart';
import 'package:ttshare/ui-base/user_area.dart';
import 'package:ttshare/utils/authentication.dart';
import 'package:ttshare/utils/database.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/ico_login.png',
                  width: 180.0,
                  height: 180.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 40.0, right: 16.0),
                  child: Text(
                    'Tour, Talk and Share your experience',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 24.0),
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 30.0, right: 20.0, bottom: 10.0),
                child: RaisedButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/google_logo.png',
                          width: 24.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5.0),
                        ),
                        Text(
                          'Masuk dengan Google',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    onPressed: () {
                      //Navigator.pushReplacementNamed(context, '/user_area'),
                      Authentication auth = new Authentication();
                      auth.signIn().then((user) async {
                        var userData = await Database.getUser(user.uid);
                        if (!userData.exists) {
                          await Database.addNewUser(user);
                        }
                        await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserArea(
                                      user: user,
                                    )));
                      });
                    }),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'Copyright 2018 by Iskandar & Nani',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
