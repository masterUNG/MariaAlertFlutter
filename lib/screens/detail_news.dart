import 'package:flutter/material.dart';

class DetailNews extends StatefulWidget {
  // id Receive From Tap ListView
  final int idNewsInt;
  DetailNews({Key key, this.idNewsInt}) : super(key: key);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {

  // Explicit
  int id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.idNewsInt;
    print('id ==> $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail News'),
      ),
      body: Text('Body Detail News'),
    );
  }
}
