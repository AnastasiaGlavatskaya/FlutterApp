import 'package:flutter/material.dart';

class ReadingListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading List"),
      ),
      body: ListView(children: <Widget>[
        ListTile(
          title: Text('Book title'),
          trailing: Icon(Icons.star),
          subtitle: Text('author'),
          isThreeLine: true,
        ),
    ListTile(title: Text('test 2')),
    ListTile(title: Text('test 3'))
    ])

      /* Container(
        child: Column(
          children: [
            ListView.builder(itemBuilder: null)
          ],
        )
      ), */
    );
  }

}