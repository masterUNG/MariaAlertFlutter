import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../models/user_model.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool statusRemember = false;
  int idLogin;
  String user, password, truePassword, typeLogin;

  String titleUser = 'ลงชื่อเข้าใช้งาน :';
  String titlePassword = 'รหัส :';
  String titleRemember = 'จดจำผู้ใช้งาน และ รหัส';
  String titleHaveSpace = 'มีช่องว่าง';
  String messageHaveSpaceUser = 'กรุณากรอก ชื่อผู้ใช้งาน คะ';
  String messageHaveSpacePassword = 'กรุณากรอก รหัส คะ';
  String messageUserFalse = 'ไม่มี ชื่อใช้งานนี้ใน ฐานข้อมูล คะ';
  String messagePasswordFalse = 'ลองใหม่ รหัสผิด คะ';

  Widget showLogo() {
    return Image.asset('images/logo1.png');
  }

  Widget userTextFromField() {
    return TextFormField(
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          labelText: titleUser,
          hintText: 'Your User',
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      validator: (String value) {
        if (value.length == 0) {
          return messageHaveSpaceUser;
        }
      },
      onSaved: (String value) {
        user = value;
      },
    );
  }

  Widget passwordTextFromField() {
    return TextFormField(
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          labelText: titlePassword,
          hintText: 'Your Password',
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      validator: (String value) {
        if (value.length == 0) {
          return messageHaveSpacePassword;
        }
      },
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget rememberCheckBox() {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        titleRemember,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      value: statusRemember,
      onChanged: (bool value) {
        onRememberCheck(value);
      },
    );
  }

  void onRememberCheck(bool value) {
    setState(() {
      statusRemember = value;
    });
  }

  Widget loginButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[900],
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        titleUser,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        print('You Click Login');
        print(formKey.currentState.validate());
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'user ==> $user, password ==> $password, remember ==> $statusRemember');
          String urlAPI =
              'http://tscore.ms.ac.th/App/getUserWhereUser.php?isAdd=true&User=$user';
          checkAuthen(context, urlAPI);
        }
      },
    );
  }

  void checkAuthen(BuildContext context, String urlAPI) async {
    var response = await get(urlAPI);
    var result = json.decode(response.body);
    print(result);

    if (result.toString() == 'null') {
      print('User False');
      showSnackBar(messageUserFalse);
    } else {
      for (var data in result) {
        var userModel = UserModel.fromJson(data);
        truePassword = userModel.password.toString();
        idLogin = userModel.id;
      }

      if (password == truePassword) {
        print('Authen True');
      } else {
        print('Password False');
        showSnackBar(messagePasswordFalse);
      }
    }
  }

  void showSnackBar(String message) {
    final snackBar = new SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue[900],
      duration: new Duration(seconds: 6),
      action: new SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.lightBlue[900], Colors.lightBlue[50]],
                    begin: Alignment(-1, -1))),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(width: 150, height: 150),
                    child: showLogo(),
                  ),
                  userTextFromField(),
                  passwordTextFromField(),
                  rememberCheckBox(),
                  Row(
                    children: <Widget>[
                      new Expanded(
                        child: Container(
                          child: loginButton(context),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
