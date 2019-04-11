import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRemember = false;

  Widget showLogo() {
    return Image.asset('images/logo1.png');
  }

  Widget emailTextFromField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address:',
          hintText: 'you@email.com',
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget passwordTextFromField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password:',
          hintText: 'Your Password',
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget rememberCheckBox() {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        'Remember Me',
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
        'Login',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomPadding: false,
      body: Container(
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
              emailTextFromField(),
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
    );
  }
}
