import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ShowNewsList extends StatefulWidget {
  @override
  _ShowNewsListState createState() => _ShowNewsListState();
}

class _ShowNewsListState extends State<ShowNewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[400],
        title: Text('Show News List'),
      ),
      body: new Center(
        child: Container(
          child: Text('Show News List'),
        ),
      ),
    );
  }
}
