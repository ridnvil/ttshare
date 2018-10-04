import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttshare/ui-base/login.dart';
import 'package:ttshare/ui-base/user_area.dart';
import 'package:ttshare/utils/authentication.dart';
import 'package:ttshare/utils/database.dart';

Future<void> main() async {
  Database.initDatabase();
  Authentication auth = new Authentication();
  bool isSignedIn = await auth.isSignedIn();
  FirebaseUser user = await auth.getCurrentUser();
  runApp(MaterialApp(
    home: isSignedIn ? UserArea(user: user) : Login(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/login': (_) => Login(),
      '/user_area': (_) => UserArea(user: user),
    },
  ));
}
