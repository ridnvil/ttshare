import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExploreCard extends StatefulWidget {
  final String backgroundUrl, name, cityName, category;
  final Function onTap;

  const ExploreCard({Key key,
    this.backgroundUrl,
    this.name,
    this.cityName,
    this.category,
    this.onTap})
      : super(key: key);

  @override
  _ExploreCardState createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  Color categoryColor = Colors.grey[300];

  @override
  void initState() {
    super.initState();

    switch (widget.category) {
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding:
        EdgeInsets.only(left: 16.0, top: 5.0, right: 16.0, bottom: 5.0),
        child: Container(
          height: 120.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            elevation: 2.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.backgroundUrl,
                      width: 100.0,
                      height: 120.0,
                      fit: BoxFit.cover,
                      errorWidget: Icon(Icons.error),
                    )
                  /*Image.network(
                    widget.backgroundUrl,
                    width: 100.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),*/
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.cityName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey[600]),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Material(
                          color: categoryColor,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10.0, top: 2.0, right: 10.0, bottom: 2.0),
                            child: Text(widget.category,
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
