import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:ttshare/ui-base/components/explore_card.dart';
import 'package:ttshare/ui-base/tourist_attaraction_details.dart';
import 'package:ttshare/utils/database.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  List<Address> results = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      if (this.mounted)
        setState(() {
          _currentLocation = result;
        });
    });
  }

  initPlatformState() async {
    Map<String, double> location;
    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }
    if (this.mounted)
      setState(() {
        _startLocation = location;
      });
  }

  Future<String> getSubAdminArea(double latitude, longitude) async {
    Coordinates coordinates = new Coordinates(latitude, longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var location = address.first;
    return location.subAdminArea;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.getListTourAttractions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        final messageCount = snapshot.data.documents.length;
        return ListView.builder(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          itemCount: messageCount,
          itemBuilder: (_, index) {
            final DocumentSnapshot doc = snapshot.data.documents[index];
            return ExploreCard(
              name: doc['name'] ?? 'No Name',
              backgroundUrl: doc['photo_url']["0"] ??
                  'https://sl.d.umn.edu/och/PhotoGallery/no-image-available.jpg',
              cityName: doc['location']['city'] ?? 'No City Name',
              category: doc['tag'] ?? 'No Category',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TouristAttractionDetails(
                            documentSnapshot: doc,
                          )),
                );
              },
            );
            /*return ListTile(
              title: Text(doc['name'] ?? '<No message retrieved>'),
              subtitle: Text(doc['location']['city'] ?? 'No location'),
            );*/
          },
        );
      },
    );
  }
}
