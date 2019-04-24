import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';
import '../listviews/news_listview.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/noti_model.dart';
import './show_notification.dart';
import './show_children_list.dart';
import './add_children.dart';

class ShowNewsList extends StatefulWidget {
  @override
  _ShowNewsListState createState() => _ShowNewsListState();
}

class _ShowNewsListState extends State<ShowNewsList> {
  String titleAppbar = 'ข่าวสาร น่ารู้';
  String titleTooltip = 'ออกจากผู้ใช้';
  String titleNotification = 'ข้อความจาก มาลี';

  String urlJson = 'http://tscore.ms.ac.th/App/getAllNews.php';
  List<NewsModel> newModels = [];
  List<NotiModel> notiModels = [];

  String myToken;
  String textValue = 'Show News List';
  bool rememberBool;
  int idLoginInt;
  String typeString;

  //  Abour Firebase
  FirebaseMessaging firebaseMessageing = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  SharedPreferences sharePreferances;

  @override
  void initState() {
    // Get Data From Json for Create ListView
    getAllDataFromJson();

    // Load Config Setting from SharePreferance
    getCredectial();

    // About Firebase Messageing
    var android = new AndroidInitializationSettings('app_icon');
    var iOS = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: onSelectNotification);

    firebaseMessageing.configure(onLaunch: (Map<String, dynamic> msg) {
      print('onLaunch Call: ==> $msg');
      setState(() {
        var notimodel = NotiModel.fromDATA(msg);
        notiModels.add(notimodel);
      });
    }, onResume: (Map<String, dynamic> msg) {
      print('onResume Call: ==> $msg');
    }, onMessage: (Map<String, dynamic> msg) {
      print('onMessage Call: ==> $msg');
      setState(() {
        var notiModel = NotiModel.fromOBJECT(msg);
        notiModels.add(notiModel);
        showNotification(msg);
        print(
            'title ==> ${notiModels[0].title.toString()}, body ==> ${notiModels[0].body.toString()}');
      });
    });

    firebaseMessageing.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));

    firebaseMessageing.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('Ios Setting Registed');
    });

    // Find Token
    firebaseMessageing.getToken().then((token) {
      myToken = token;
      print('myToken ==>>> $myToken');
      updateToken(token);
    });
  } // initial

  Future onSelectNotification(String payload) async {
    debugPrint("payload : $payload");

    if (payload == null) {
      payload = "Message is null";
    }

    var goToShowNoti = MaterialPageRoute(
        builder: (BuildContext context) => ShowNotificationMessage(
              messageString: payload,
            ));
    await Navigator.push(context, goToShowNoti);

    // showDialog(
    //   context: context,
    //   builder: (_) => new AlertDialog(
    //         title: new Text(titleNotification),
    //         content: new Text('$payload'),
    //       ),
    // );
  }

  void showNotification(Map<String, dynamic> msg) async {
    print('showNoti Work msg ==> $msg');

    var objNotification = msg['notification'];
    print('objNoti ==> $objNotification');

    var notiModel = NotiModel.fromJSON(objNotification);
    String title = notiModel.title.toString();
    String body = notiModel.body.toString();

    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);

    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform,
        payload: body);
  }

  void getAllDataFromJson() async {
    var response = await http.get(urlJson);
    var result = json.decode(response.body);
    print(result);
    setState(() {
      for (var objJson in result) {
        newModels.add(NewsModel.fromJSON(objJson));
      }
    });
  }

  void getCredectial() async {
    sharePreferances = await SharedPreferences.getInstance();
    setState(() {
      rememberBool = sharePreferances.getBool('Remember');
      idLoginInt = sharePreferances.getInt('id');
      typeString = sharePreferances.getString('Type');
      // print(
      //     'Receive from SharePreferance rememberBool => $rememberBool, idLogin => $idLoginInt, typeString => $typeString');
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

  Widget menuDrawer(BuildContext context) {
    String titleH1 = 'โรงเรียนมารีย์อนุสรณ์';
    String titleH2 = 'อำเภอเมือง จังหวัดบุรีรัมย์';
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[300]),
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 70.0,
                    height: 70.0,
                    child: Image.asset('images/logo1.png'),
                  ),
                  Text(
                    titleH1,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    titleH2,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.child_friendly,
              color: Colors.blue,
            ),
            title: Text(
              'บุตรหลานของ ท่าน',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800]),
            ),
            onTap: () {
              print('Click Memu1');
              var showChildrenListRoute = MaterialPageRoute(
                  builder: (BuildContext context) => ShowChildrenList());
              Navigator.of(context).pop();
              Navigator.of(context).push(showChildrenListRoute);
            },
          ),
          ListTile(
            title: Text(
              'เพิ่ม บุตร หลาน ของท่าน',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800]),
            ),
            leading: Icon(
              Icons.group_add,
              color: Colors.blue,
            ),
            onTap: () {
              var addChildrenRoute = MaterialPageRoute(
                  builder: (BuildContext context) => AddChildren());
                  Navigator.of(context).pop();
                  Navigator.of(context).push(addChildrenRoute);
            },
          )
        ],
      ),
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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(titleAppbar),
        actions: <Widget>[exitApp()],
      ),
      body: NewsListView(newModels),
      drawer: menuDrawer(context),
    );
  }
}
