import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../models/news_model.dart';
import '../listviews/detail_listview.dart';
import 'dart:async';
import './show_detail_news.dart';

class DetailNews extends StatefulWidget {
  // id Receive From Tap ListView
  final int idNewsInt;
  DetailNews({Key key, this.idNewsInt}) : super(key: key);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  NewsModel newsModel;
  List<NewsModel> newsModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int id = widget.idNewsInt;
    getNewsFromJSON(id);
  }

  getNewsFromJSON(int idInt) async {
    String urlString =
        "http://tscore.ms.ac.th/App/getNewsWhereId.php?isAdd=true&id=$idInt";
    var response = await get(urlString);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print('id ==> $idInt, result ==> $result');
      for (var objJson in result) {
        setState(() {
          newsModels.add(NewsModel.fromJSON(objJson));
          newsModel = NewsModel.fromJSON(objJson);
        });
      }
    } else {
      throw Exception('Error Master UNG');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail News'),
      ),
      body: DetailListView(newsModel),
    );
  }
}
