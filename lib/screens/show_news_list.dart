import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ShowNewsList extends StatefulWidget {
  @override
  _ShowNewsListState createState() => _ShowNewsListState();
}

class _ShowNewsListState extends State<ShowNewsList> {
  String titleAppbar = 'ข่าวสาร น่ารู้';
  String titleTooltip = 'ออกจากผู้ใช้';

  String myToken;
  String textValue = 'Show News List';
  bool rememberBool;
  int idLoginInt;
  String typeString;

  FirebaseMessaging firebaseMessageing = new FirebaseMessaging();

  SharedPreferences sharePreferances;

  @override
  void initState() {
    getCredectial();
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
      myToken = token;
      print('myToken ==>>> $myToken');
      updateToken(token);
    });
  }

  void getCredectial() async {
    sharePreferances = await SharedPreferences.getInstance();
    setState(() {
      rememberBool = sharePreferances.getBool('Remember');
      idLoginInt = sharePreferances.getInt('id');
      typeString = sharePreferances.getString('Type');
      print(
          'Receive from SharePreferance rememberBool => $rememberBool, idLogin => $idLoginInt, typeString => $typeString');
    });
  }

  void updateToken(String token) {
    print(token);
    textValue = token;
    setState(() {});
  }

  Widget exitApp() {
    return IconButton(
      tooltip: titleTooltip,
      icon: Icon(Icons.close),
      onPressed: () {
        clearSharePreferance();
      },
    );
  }

  void clearSharePreferance() async {
    sharePreferances = await SharedPreferences.getInstance();
    setState(() {
      sharePreferances.clear();
      print('Remember ===>> ${sharePreferances.getBool('Remember')}');
      if (sharePreferances.getBool('Remember') == null) {
        exit(0);
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(titleAppbar),
        actions: <Widget>[exitApp()],
      ),
      body: new Center(
        child: Container(
          child: Text(textValue),
        ),
      ),
    );
  }
}
