import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'show_news_list.dart';
import 'register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool statusRemember = false;
  SharedPreferences sharedPreferences;

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
  String titleRegister = 'สมัครใช้งานแอพ :';
  String labelRegister = 'สมัคร';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromSharePreferance(context);
  }

  void getDataFromSharePreferance(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      bool currentStatus = sharedPreferences.getBool('Remember');
      print('currentStatus ==>>> $currentStatus');
      if (currentStatus != null) {
        print('Remember ==> $currentStatus');
        if (currentStatus) {
          moveToNewsListView(context);
        }
      }
    });
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo1.png'),
    );
  }

  Widget userTextFromField() {
    return Container(
      margin: EdgeInsets.only(top: 24.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(20.0)),
            hintStyle: TextStyle(color: Colors.white),
            labelText: titleUser,
            hintText: 'Your User',
            labelStyle: TextStyle(color: Colors.white)),
        validator: (String value) {
          if (value.length == 0) {
            return messageHaveSpaceUser;
          }
        },
        onSaved: (String value) {
          user = value;
        },
      ),
    );
  }

  Widget passwordTextFromField() {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(20.0)),
            hintStyle: TextStyle(color: Colors.white),
            labelText: titlePassword,
            hintText: 'Your Password',
            labelStyle: TextStyle(color: Colors.white)),
        validator: (String value) {
          if (value.length == 0) {
            return messageHaveSpacePassword;
          }
        },
        onSaved: (String value) {
          password = value;
        },
      ),
    );
  }

  Widget rememberCheckBox() {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        titleRemember,
        style: TextStyle(color: Colors.white),
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
      print('statusRemember ==>>> $statusRemember');
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
        // print('You Click Login');
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
      // print('User False');
      showSnackBar(messageUserFalse);
    } else {
      for (var data in result) {
        var userModel = UserModel.fromJson(data);
        truePassword = userModel.password.toString();
        idLogin = userModel.id;
        typeLogin = userModel.type.toString();
      }

      if (password == truePassword) {
        print('Authen True');
        setupSharePreferance();
        moveToNewsListView(context);
      } else {
        print('Password False');
        showSnackBar(messagePasswordFalse);
      }
    }
  }

  setupSharePreferance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setBool('Remember', statusRemember);
      sharedPreferences.setInt('id', idLogin);
      sharedPreferences.setString('Type', typeLogin);
      sharedPreferences.commit();
    });
  }

  moveToNewsListView(BuildContext context) {
    var newsRoute = new MaterialPageRoute(
        builder: (BuildContext context) => ShowNewsList());
    Navigator.of(context)
        .pushAndRemoveUntil(newsRoute, (Route<dynamic> route) => false);
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

  Widget myRegisger(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            titleRegister,
            style: TextStyle(color: Colors.white),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue[900],
            child: Text(
              labelRegister,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              var goToRegister = new MaterialPageRoute(
                  builder: (BuildContext context) => Register());
              Navigator.of(context).push(goToRegister);
            },
          )
        ],
      ),
    );
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
                  colors: [Colors.lightBlue[50], Colors.blue[700]],
                  begin: Alignment(-1, -1))),
          child: Container(
            child: Column(
              children: <Widget>[
                showLogo(),
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
                ),
                myRegisger(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
