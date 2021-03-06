import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:mariealert/listviews/score_listview.dart';
import 'dart:convert';

import 'package:mariealert/models/score_model.dart';

class ShowScoreList extends StatefulWidget {
  final String idCode;
  ShowScoreList({Key key, this.idCode}) : super(key: key);

  @override
  _ShowScoreListState createState() => _ShowScoreListState();
}

class _ShowScoreListState extends State<ShowScoreList> {

  List<ScoreModel> scoreModels = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String idcode = widget.idCode;
    String urlString = 'http://tscore.ms.ac.th/App/getScoreWhereIdCode.php?isAdd=true&idcode=$idcode';
    var response = await get(urlString);
    var result = json.decode(response.body);
    print('result = $result');
    for (var objData in result) {
      ScoreModel scoreModel = ScoreModel.fromJson(objData);
      setState(() {
        scoreModels.add(scoreModel);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Score'),
      ),
      body: ScoreListView(scoreModels),
    );
  }
}
