import 'package:flutter/material.dart';
import 'package:ttshare/ui-base/components/chat_item.dart';

class TouristChat extends StatefulWidget {
  @override
  _TouristChatState createState() => _TouristChatState();
}

class _TouristChatState extends State<TouristChat> {
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
            child: ListView(
              padding:
                  EdgeInsets.only(left: 8.0, top: 5.0, right: 8.0, bottom: 5.0),
              children: <Widget>[
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
                        'Kenapa pukhjk hjk hj hkj kh hjkh k hkj l l jk hkjhkjh kjh kjh kj hkj hk k hjkh kj hkjh kh i',
                    isMe: false,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100.0,
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
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
