import 'package:flutter/material.dart';

class ShowChildrenList extends StatefulWidget {
  @override
  _ShowChildrenListState createState() => _ShowChildrenListState();
}

class _ShowChildrenListState extends State<ShowChildrenList> {
  String titleAppBar = 'บุตรหลานของ ท่าน';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(titleAppBar),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.blue[900],
        child: Icon(Icons.group_add),
        onPressed: () {
          print('You click Add');
        },
      ),
      body: Text(titleAppBar),
    );
  }
}
