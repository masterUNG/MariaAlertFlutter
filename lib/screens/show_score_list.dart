import 'package:flutter/material.dart';

class ShowScoreList extends StatefulWidget {
  final String idCode;
  ShowScoreList({Key key, this.idCode}) : super(key: key);

  @override
  _ShowScoreListState createState() => _ShowScoreListState();
}

class _ShowScoreListState extends State<ShowScoreList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Score'),
      ),
      body: Text('body'),
    );
  }
}
