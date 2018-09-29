import 'package:flutter/material.dart';

class FeedCard extends StatefulWidget {
  final String nameOfUser,
      photoProfileOfUser,
      location,
      contentMediaUrl,
      information;
  final bool isLiked;
  final int totalLikes;

  const FeedCard(
      {Key key,
      @required this.nameOfUser,
      @required this.photoProfileOfUser,
      this.location,
      @required this.contentMediaUrl,
      this.information,
      @required this.isLiked,
      @required this.totalLikes})
      : super(key: key);

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: <Widget>[
          FeedCardHeader(
            nameOfUser: widget.nameOfUser,
            profilePhotoOfUser: widget.photoProfileOfUser,
            location: widget.location,
          ),
          FeedCardContent(
            contentMediaUrl: widget.contentMediaUrl,
          ),
          FeedCardFooter(
            isLiked: widget.isLiked,
            totalLikes: widget.totalLikes,
            information: widget.information,
          ),
        ],
      ),
    );
  }
}

class FeedCardHeader extends StatefulWidget {
  final String profilePhotoOfUser;
  final String nameOfUser;
  final String location;

  const FeedCardHeader(
      {Key key,
      @required this.profilePhotoOfUser,
      @required this.nameOfUser,
      @required this.location})
      : super(key: key);

  @override
  _FeedCardHeaderState createState() => _FeedCardHeaderState();
}

class _FeedCardHeaderState extends State<FeedCardHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              widget.profilePhotoOfUser,
              width: 30.0,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.nameOfUser,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FeedCardContent extends StatefulWidget {
  final String contentMediaUrl;

  const FeedCardContent({Key key, @required this.contentMediaUrl})
      : super(key: key);

  @override
  _FeedCardContentState createState() => _FeedCardContentState();
}

class _FeedCardContentState extends State<FeedCardContent> {
  @override
  Widget build(BuildContext context) {
    return Image.network(widget.contentMediaUrl);
  }
}

class FeedCardFooter extends StatefulWidget {
  final bool isLiked;
  final int totalLikes;
  final String information;

  const FeedCardFooter(
      {Key key,
      @required this.isLiked,
      @required this.totalLikes,
      @required this.information})
      : super(key: key);

  @override
  _FeedCardFooterState createState() => _FeedCardFooterState();
}

class _FeedCardFooterState extends State<FeedCardFooter> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = widget.isLiked;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: widget.isLiked
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                  Text(
                    '${widget.totalLikes} suka',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.chat_bubble_outline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(
            widget.information,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
