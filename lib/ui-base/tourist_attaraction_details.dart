import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TouristAttractionDetails extends StatefulWidget {
  final List imageUrl;
  final DocumentSnapshot documentSnapshot;

  const TouristAttractionDetails(
      {Key key, this.imageUrl, this.documentSnapshot})
      : super(key: key);

  @override
  _TouristAttractionDetailsState createState() =>
      _TouristAttractionDetailsState();
}

class _TouristAttractionDetailsState extends State<TouristAttractionDetails> {
  Color categoryColor = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    List image = new List(widget.documentSnapshot['photo_url'].length);
    for (var index = 0;
        index < widget.documentSnapshot['photo_url'].length;
        index++) {
      image[index] =
          NetworkImage(widget.documentSnapshot['photo_url'][index.toString()]);
    }

    switch (widget.documentSnapshot['tag']) {
      case "bahari":
        categoryColor = Colors.blue;
        break;
      case "kuliner":
        categoryColor = Colors.deepPurpleAccent;
        break;
      case "edukasi":
        categoryColor = Colors.amber;
        break;
      case "alam":
        categoryColor = Colors.green;
        break;
    }

    DateTime dateTime =
        DateTime.parse(widget.documentSnapshot['updated_at'].toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: new Carousel(
              dotSize: 3.0,
              images: image,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                      child: Text(
                        '${widget.documentSnapshot['name']}',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                  Material(
                    color: categoryColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(10.0)),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0, top: 2.0, right: 10.0, bottom: 2.0),
                      child: Text(widget.documentSnapshot['tag'],
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 16.0, top: 0.0, right: 16.0, bottom: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Terakhir update : ${dateTime.month}/${dateTime.year}',
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.grey[400]),
                      ),
                      Text('${widget.documentSnapshot['location']['city']}, '
                          '${widget.documentSnapshot['location']['province']}, '
                          '${widget.documentSnapshot['location']['country']}'),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text(widget.documentSnapshot['description'])
                    ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
