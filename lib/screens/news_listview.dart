import 'package:flutter/material.dart';

class NewsListview extends StatefulWidget {
  @override
  _NewsListviewState createState() => _NewsListviewState();
}

class _NewsListviewState extends State<NewsListview> {
  String titleAppbar = 'ข่าวสาร น่ารู้';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppbar),
      ),
      body: Text('body ListView'),
    );
  }
}
