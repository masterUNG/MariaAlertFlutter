import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../models/news_model.dart';
import '../listviews/detail_listview.dart';
import 'dart:async';
import './show_detail_news.dart';

class DetailNews extends StatefulWidget {
  final NewsModel newsModel;
  DetailNews({Key key, this.newsModel}) : super(key: key);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // int id = widget.idNewsInt;
    // getNewsFromJSON(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail News'),
      ),
      body: DetailListView(widget.newsModel),
    );
  }
}
