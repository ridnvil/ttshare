import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ttshare/utils/database.dart';

class Chat {
  final FirebaseUser user;

  Chat({this.user});

  Future<DocumentReference> sendChat(String messages, String type) async {
    if (messages == null || messages == "") {
      throw FormatException('The message cannot be empty.');
    }
    return await Database.addNewMessage(user, messages, type);
  }
}
