import 'package:flutter/material.dart';

class Feeds extends StatefulWidget {
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('test'),
    );
    /*return StreamBuilder<QuerySnapshot>(
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
            return FeedCard(
              nameOfUser: 'Example',
              photoProfileOfUser: doc['photo_url']["0"] ??
                  'https://sl.d.umn.edu/och/PhotoGallery/no-image-available.jpg',
              isLiked: index % 2 == 1 ? true : false,
              totalLikes: 120,
              contentMediaUrl: doc['photo_url']["1"] ??
                  'https://sl.d.umn.edu/och/PhotoGallery/no-image-available.jpg',
              information: doc['description'] ?? 'No Item',
              location:
                  '${doc['name']}, ${doc['location']['city']}, ${doc['location']['province']}, ${doc['location']['country']}.' ??
                      'No Item',
            );
            */ /*return ExploreCard(
              name: doc['name'] ?? 'No Name',
              backgroundUrl: doc['photo_url']["0"] ??
                  'https://sl.d.umn.edu/och/PhotoGallery/no-image-available.jpg',
              cityName: doc['location']['city'] ?? 'No City Name',
              category: doc['tag'] ?? 'No Category',
            );*/ /*
            */ /*return ListTile(
              title: Text(doc['name'] ?? '<No message retrieved>'),
              subtitle: Text(doc['location']['city'] ?? 'No location'),
            );*/ /*
          },
        );
      },
    );*/
  }
}
