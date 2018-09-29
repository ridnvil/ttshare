import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final bool isMe;
  final String accountName;
  final String photoUrl;
  final String message;

  const ChatItem(
      {Key key,
      @required this.isMe,
      this.message,
      this.accountName,
      this.photoUrl})
      : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return widget.isMe ? getSentMessageLayout() : getReceivedMessageLayout();
  }

  Widget getSentMessageLayout() {
    return Container(
      padding: EdgeInsets.only(left: 64.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Flexible(
          child: Material(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(widget.message),
                  )
                ],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.photoUrl),
                )),
          ],
        ),
      ]),
    );
  }

  Widget getReceivedMessageLayout() {
    return Container(
      margin: EdgeInsets.only(right: 64.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.photoUrl),
                )),
          ],
        ),
        Flexible(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.accountName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(widget.message),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
