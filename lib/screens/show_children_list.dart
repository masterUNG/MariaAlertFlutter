import 'package:flutter/material.dart';
import 'add_children.dart';

class ShowChildrenList extends StatefulWidget {
  @override
  _ShowChildrenListState createState() => _ShowChildrenListState();
}

class _ShowChildrenListState extends State<ShowChildrenList>
    with WidgetsBindingObserver {
  String titleAppBar = 'บุตรหลานของ ท่าน';
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print('initState Work');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    setState(() {
      _notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("_appLiftcycleState ==> $_notification");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(titleAppBar),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.group_add),
        onPressed: () {
          print('You click Add');
          var addChildrenRoute = MaterialPageRoute(
              builder: (BuildContext context) => AddChildren());
          Navigator.of(context).push(addChildrenRoute);
        },
      ),
      body: Text('_appLiftcycleState ==> $_notification'),
    );
  }
}
