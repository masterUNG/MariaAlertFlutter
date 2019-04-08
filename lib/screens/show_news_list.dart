import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ShowNewsList extends StatefulWidget {
  @override
  _ShowNewsListState createState() => _ShowNewsListState();
}

class _ShowNewsListState extends State<ShowNewsList> {
  String textValue = 'Show News List';
  FirebaseMessaging firebaseMessageing = new FirebaseMessaging();

  @override
  void initState() {
    firebaseMessageing.configure(onLaunch: (Map<String, dynamic> msg) {
      print('onLaunch Call:');
    }, onResume: (Map<String, dynamic> msg) {
      print('onResume Call:');
    }, onMessage: (Map<String, dynamic> msg) {
      print('onMessage Call:');
    });
    firebaseMessageing.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessageing.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('Ios Setting Registed');
    });
    firebaseMessageing.getToken().then((token) {
      updateToken(token);
    });
  }

  void updateToken(String token) {
    print(token);
    textValue = token;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Show News List'),
      ),
      body: new Center(
        child: Container(
          child: Text(textValue),
        ),
      ),
    );
  }
}
