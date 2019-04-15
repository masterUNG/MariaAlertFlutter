import 'package:flutter/material.dart';
import '../models/news_model.dart';

class NewsListView extends StatelessWidget {
  // Field
  List<NewsModel> newsModels;

  // Constructor
  NewsListView(this.newsModels);

  Widget showName(String nameString) {
    return Container(
      width: 170.0,
      child: Text(nameString,
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
    );
  }

  Widget showDetail(String detailString) {
    return Container(
      width: 170.0,
      child: Text(detailString),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsModels.length,
      itemBuilder: (context, int index) {
        return Container(
          decoration: index % 2 == 0
              ? BoxDecoration(color: Colors.blue[100])
              : BoxDecoration(color: Colors.blue[200]),
          child: Row(
            children: <Widget>[
              Container(
                child:
                    Image.network(newsModels[index].picture, fit: BoxFit.cover),
                constraints: BoxConstraints.expand(width: 150.0, height: 150.0),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    showName(newsModels[index].name),
                    showDetail(newsModels[index].detail)
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
