import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  static Firestore _firestore;

  static initDatabase() async {
    FirebaseApp app = await FirebaseApp.configure(
        name: 'Tour Talk Share',
        options: const FirebaseOptions(
          googleAppID: '1:342922254463:android:4cf7c5d6998b4119',
          apiKey: 'AIzaSyDdz3ttEfrhoMGkuICGTvsLItaNzIo4hyo',
          projectID: 'tour-talk-share',
        ));
    _firestore = Firestore(app: app);
  }

  static Stream<QuerySnapshot> getListTourAttractions() {
    return _firestore
        .collection('tourist_attraction')
        .where('status', isEqualTo: 'published')
        .snapshots();
  }

  static Future<DocumentSnapshot> getUser(String uid) async {
    return await _firestore.collection('users').document(uid).get();
  }

  static Future addNewUser(FirebaseUser user) async {
    await _firestore
        .collection('users')
        .document(user.uid)
        .setData(<String, dynamic>{
      "name": user.displayName,
      "email": user.email,
      "photo_url": user.photoUrl.replaceAll(RegExp(r's96-c'), 's600-c'),
      "created_at": DateTime.now(),
    });
  }
}
