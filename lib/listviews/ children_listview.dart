import 'package:flutter/material.dart';
import '../models/children_model.dart';

class ChildrenListView extends StatelessWidget {
  List<ChildrenModel> childrenModels;
  ChildrenListView(this.childrenModels);

  Widget showImage(int index) {
    String urlImage = childrenModels[index].imagePath.toString();

    if (urlImage.length != 0) {
      return Container(
        height: 200.0,
        padding: EdgeInsets.all(20.0),
        child: Image.network(urlImage),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(20.0),
        height: 200.0,
        child: Image.asset('images/child.png'),
      );
    }
  }

  Widget showName(int index) {
    print('fname ==> ${childrenModels[index].fname}');
    return Text(
      childrenModels[index].fname,
      style: TextStyle(fontSize: 24.0, color: Colors.white),
    );
  }

  Widget showRoom(int index) {
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment(0, 0),
              child: Text(
                '${childrenModels[index].studentClass}',
                style: TextStyle(fontSize: 18.0, color: Colors.blue[800]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment(0, 0),
              child: Text(
                'ห้อง  ${childrenModels[index].room}',
                style: TextStyle(fontSize: 18.0, color: Colors.blue[800]),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showList() {
    for (var value in childrenModels) {
      print('value ==> $value');
    }
    return ListView.builder(
      itemCount: childrenModels.length,
      itemBuilder: (context, int index) {
        return Container(
          child: Column(
            children: <Widget>[
              showImage(index),
              showName(index),
              showRoom(index)
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(radius: 2.0,
              colors: [Colors.white, Colors.blue], center: Alignment(1, 1))),
      child: showList(),
    );
  }
}
