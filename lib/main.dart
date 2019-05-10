import 'package:flutter/material.dart';
import 'screens/authen.dart';
import 'screens/show_news_list.dart';
import 'package:flutter/services.dart';
import 'screens/my_notification.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authen(),
    );
  }
}
