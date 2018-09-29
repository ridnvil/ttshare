import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ttshare/ui-base/login.dart';
import 'package:ttshare/ui-base/user_area.dart';
import 'package:ttshare/utils/authentication.dart';
import 'package:ttshare/utils/database.dart';

Future<void> main() async {
  Database.initDatabase();
  Authentication auth = new Authentication();
  bool isSignedIn = await auth.isSignedIn();
  runApp(MaterialApp(
    home: isSignedIn ? UserArea() : Login(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/login': (_) => Login(),
      '/user_area': (_) => UserArea(),
    },
  ));
}
