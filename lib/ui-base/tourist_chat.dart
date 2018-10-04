import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttshare/ui-base/components/chat_item.dart';
import 'package:ttshare/utils/chat.dart';
import 'package:ttshare/utils/database.dart';

class TouristChat extends StatefulWidget {
  final FirebaseUser user;

  const TouristChat({Key key, @required this.user}) : super(key: key);

  @override
  _TouristChatState createState() => _TouristChatState();
}

class _TouristChatState extends State<TouristChat> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController _messageText = new TextEditingController();
  Chat worldChat;

  @override
  void initState() {
    super.initState();
    worldChat = new Chat(user: widget.user);
  }

  @override
  void dispose() {
    _messageText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
        iconTheme: IconThemeData(color: Colors.grey[600]),
        title: Text(
          "Tourist Chat",
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Database.getListMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                final messageCount = snapshot.data.documents.length;
                return ListView.builder(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  itemCount: messageCount,
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final DocumentSnapshot doc = snapshot.data.documents[index];
                    if (doc['uid'] == widget.user.uid) {
                      return Container(
                        margin: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ChatItem(
                          accountName: doc['name'],
                          photoUrl: doc['photo_url'],
                          message: doc['message'],
                          isMe: true,
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(
                            left: 8.0, top: 5.00, right: 8.0, bottom: 5.0),
                        child: ChatItem(
                          accountName: doc['name'],
                          photoUrl: doc['photo_url'],
                          message: doc['message'],
                          isMe: false,
                        ),
                      );
                    }
                  },
                );
              },
              /*child: ListView(
                controller: _scrollController,
                reverse: true,
                shrinkWrap: true,
                padding:
                    EdgeInsets.only(left: 8.0, top: 5.0, right: 8.0, bottom: 5.0),
                children: <Widget>[
                  */ /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Database.getListMessages(),
                          builder: (context, snapshot) {
                            final messageCount = snapshot.data.documents.length;
                          },
                        ),
                      ),
                    ],
                  ),*/ /*
                  Container(
                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ChatItem(
                      accountName: 'Achmad Irianto Eka Putra',
                      photoUrl:
                          'https://udemy-images.udemy.com/course/750x422/1319746_e9b5_3.jpg',
                      message:
                          'hy iskanda jfdlsa lfdjs aljf dsal fdls flsa lfjdalj fdlsaj fdlsa j fjdlsa fdlksajfldksja ',
                      isMe: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 8.0, top: 5.00, right: 8.0, bottom: 5.0),
                    child: ChatItem(
                      accountName: 'Iskandar',
                      photoUrl:
                          'https://udemy-images.udemy.com/course/750x422/1319746_e9b5_3.jpg',
                      message:
                          'Kenapa pukhjk hjk hj hkj kh hjkh k hkj l l jk hkjhkjh kjh kjh kj hkj hk k hjkh kj hkjh kh iKenapa pukhjk hjk hj hkj kh hjkh k hkj l l jk hkjhkjh kjh kjh kj hkj hk k hjkh kj hkjh kh iKenapa pukhjk hjk hj hkj kh hjkh k hkj l l jk hkjhkjh kjh kjh kj hkj hk k hjkh kj hkjh kh iKenapa pukhjk hjk hj hkj kh hjkh k hkj l l jk hkjhkjh kjh kjh kj hkj hk k hjkh kj hkjh kh i',
                      isMe: false,
                    ),
                  ),
                ],
              ),*/
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0, top: 2.0, right: 12.0, bottom: 2.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            child: TextField(
                              controller: _messageText,
                              maxLines: null,
                              decoration:
                              InputDecoration(border: InputBorder.none),
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          var message = _messageText.text;
                          _messageText.clear();
                          await worldChat
                              .sendChat(message, "default")
                              .then((docRef) {})
                              .catchError((err) {
                            print(err.toString());
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
