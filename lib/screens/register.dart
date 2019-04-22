import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Key
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Variable
  String user, password, token;

  // Text
  String titleAppBar = 'สมัครสมาชิก';
  String titleUser = 'ลงชื่อใช้งาน';
  String titlePassword = 'รหัส';
  String titleHaveSpace = 'ห้ามมี ช่องวาง คะ';
  String messgeHaveSpace = 'กรุณา กรองข้อมูล ทุกช่อง คะ';
  String hindUser = 'กรอก ชื่อใช้งานที่อยากได้';
  String hiddPassword = 'กรอก รหัสที่อยากได้';
  String passwordFalse1 = 'รหัส ต้องมีไม่ต่ำกว่า 6 ตัวอักษร คะ';

  // Firebase
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() { 
    super.initState();

    firebaseMessaging.getToken().then((String value){
      token = value;
    });
    
  }

  Widget userTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: titleUser,
          hintText: hindUser,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.white, width: 1.0))),
      validator: (String value) {
        if (checkHaveSpace(value)) {
          return titleHaveSpace;
        }
      },
      onSaved: (String value) {
        user = value;
      },
    );
  }

  bool checkHaveSpace(String value) {
    if (value.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      duration: Duration(seconds: 8),
      backgroundColor: Colors.blue[900],
      content: Text(message),
      action: SnackBarAction(textColor: Colors.yellow,
        label: 'Close',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void checkUserAndUpload(BuildContext context) async {
    String urlCheckUser =
        'http://tscore.ms.ac.th/App/getUserWhereUser.php?isAdd=true&User=$user';

    var response = await get(urlCheckUser);
    var result = json.decode(response.body);

    if (result.toString() != 'null') {
      showSnackBar('ไม่สามารถใช้ $user ลงทะเบียนได้ เพราะมีคนอื่นใช้ไปแล้ว คะ');
    } else {
      print('user = $user, password = $password, token = $token');
      String urlAddUser = 'http://tscore.ms.ac.th/App/addUser.php?isAdd=true&User=$user&Password=$password&Token=$token';
      var responseAddUser = await get(urlAddUser);
      var resultAddUser = json.decode(responseAddUser.body);
      print('resultAddUser ==>> $resultAddUser');
      Navigator.pop(context);
    }
  }

  Widget passwordTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: titlePassword,
          hintText: hiddPassword,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.white, width: 1.0))),
      validator: (String value) {
        if (checkHaveSpace(value)) {
          return messgeHaveSpace;
        } else if (value.length <= 5) {
          return passwordFalse1;
        }
      },
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget uploadToServer(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          checkUserAndUpload(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(titleAppBar),
          actions: <Widget>[uploadToServer(context)],
        ),
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(-1, -1),
                    colors: [Colors.blue[50], Colors.blue[900]])),
            padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
            alignment: Alignment(0, -1),
            child: Column(
              children: <Widget>[
                userTextFormField(),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: passwordTextFormField(),
                )
              ],
            ),
          ),
        ));
  }
}
