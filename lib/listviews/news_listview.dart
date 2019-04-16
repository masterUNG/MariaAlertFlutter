import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../screens/detail_news.dart';

class NewsListView extends StatelessWidget {
  // Field
  List<NewsModel> newsModels;

  // Constructor
  NewsListView(this.newsModels);

  Widget showName(String nameString) {
    return Container(
      width: 170.0,
      child: Text(nameString,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900])),
    );
  }

  Widget showDetail(String detailString) {
    String detail = detailString;
    if (detailString.length > 100) {
      detail = detailString.substring(0, 100) + '...';
    }

    return Container(
      width: 170.0,
      child: Text(detail),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsModels.length,
      itemBuilder: (context, int index) {
        return GestureDetector(
          child: Container(
            decoration: index % 2 == 0
                ? BoxDecoration(color: Colors.blue[100])
                : BoxDecoration(color: Colors.blue[200]),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Image.network(newsModels[index].picture,
                      fit: BoxFit.cover),
                  constraints:
                      BoxConstraints.expand(width: 150.0, height: 150.0),
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
          ),
          onTap: () {
            int idNewsInt = newsModels[index].id;
            print('You Tap index = $index, idNewsInt = $idNewsInt');

            var goToDetailNews = new MaterialPageRoute(
                builder: (BuildContext context) => DetailNews(
                      idNewsInt: idNewsInt,
                    ));
            Navigator.of(context).push(goToDetailNews);
          },
        );
      },
    );
  }
}
