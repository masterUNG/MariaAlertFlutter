import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String titleAppBar = 'สมัครสมาชิค';
  String titleUser = 'ลงชื่อใช้งาน';
  String titlePassword = 'รหัส';
  String titleHaveSpace = 'ห้ามมี ช่องวาง คะ';
  String messgeHaveSpace = 'กรุณา กรองข้อมูล ทุกช่อง คะ';
  String hindUser = 'กรอก ชื่อใช้งานที่อยากได้';
  String hiddPassword = 'กรอก รหัสที่อยากได้';

  Widget userTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: titleUser,
          hintText: hindUser,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.white, width: 1.0))),
    );
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
    );
  }

  Widget uploadToServer(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {print('Click Upload');},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(titleAppBar),actions: <Widget>[uploadToServer(context)],
      ),
      body: Container(
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
    );
  }
}
