import 'package:flutter/material.dart';
import '../models/news_model.dart';

class DetailListView extends StatelessWidget {

  NewsModel newsModel;

  DetailListView(this.newsModel);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(30.0),
          alignment: Alignment(0, -1),
          child: Container(
            height: 200,
            child: Image.network(newsModel.picture.toString(), fit: BoxFit.fitHeight,),
          ),
        )
      ],
    );
  }
}