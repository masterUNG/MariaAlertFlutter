import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool statusRemember = false;
  String user, password;

  String titleUser = 'ลงชื่อเข้าใช้งาน :';
  String titlePassword = 'รหัส :';
  String titleRemember = 'จดจำ ชื่อผู้ใช้งาน และ รหัส';
  String titleHaveSpace = 'มีช่องว่าง';
  String messageHaveSpace = 'กรุณากรอกข้อมูลทุกช่อง คะ';

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
          return messageHaveSpace;
        }
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
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),validator: (String value) {
                if (value.length == 0) {
                  return messageHaveSpace;
                }
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

  Widget loginButton() {
    return RaisedButton(
      color: Colors.blue[700],
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        titleUser,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        print('You Click Login');
        print(formKey.currentState.validate());
        if (formKey.currentState.validate()) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[700], Colors.blue[50]],
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
                          child: loginButton(),
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
