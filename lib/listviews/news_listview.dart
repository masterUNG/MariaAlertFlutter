import 'package:flutter/material.dart';
import '../models/news_model.dart';

class NewsListView extends StatelessWidget {
  // Field
  List<NewsModel> newsModels;

  // Constructor
  NewsListView(this.newsModels);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsModels.length,
      itemBuilder: (context, int index) {
        return Container(
          child: Text(newsModels[index].name),
        );
      },
    );
  }
}
