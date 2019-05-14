import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../models/children_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../models/user_model.dart';

class AddChildren extends StatefulWidget {
  @override
  _AddChildrenState createState() => _AddChildrenState();
}

class _AddChildrenState extends State<AddChildren> {
  String titleAppBar = 'เพิ่มบุตร หลาน ของท่าน';
  String barcode = '';
  final formKey = GlobalKey<FormState>();
  final snackBarKey = GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = new TextEditingController();
  String nameChildren = 'ชื่อ นามสกุล';
  bool statusSave = false; // false ==> No or Not Complease barcode
  List<String> listChildrens = [];
  String idCodeString, idLogin, urlImage = '';

  @override
  void initState() {
    super.initState();
    getDataFromSharePreFerance(context);
  }

  void getDataFromSharePreFerance(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int idInt = sharedPreferences.getInt('id');
    // print('idInt ==> $idInt');
    idLogin = idInt.toString();

    String urlString =
        'http://tscore.ms.ac.th/App/getUserWhereId.php?isAdd=true&id=$idInt';
    var response = await get(urlString);
    var result = json.decode(response.body);
    print('result ==> $result');

    for (var objJson in result) {
      UserModel userModel = UserModel.fromJson(objJson);
      idCodeString = userModel.idCode.toString();

      if (idCodeString.length != 0) {
        idCodeString = idCodeString.substring(1, ((idCodeString.length) - 1));
        // print('idCodeString ==> $idCodeString');
        List<String> strings = idCodeString.split(',');
        // print('strings.length ==> ${strings.length}');

        for (var value in strings) {
          listChildrens.add(value);
        }
        // print('listChildrens ==> ${listChildrens.toString()}');
      }
    }
  }

  Widget showName() {
    return Text(
      nameChildren,
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget scanButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Colors.blue[900],
      child: Text(
        'Scan Code',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        scanQR();
        debugPrint('QRcode ==> $barcode');
        log('qrCode: $barcode');

        if (barcode.length != 0) {
          textEditingController.text = barcode;
          loadChildren();
        }
      },
    );
  }

  Widget showAvata() {
    if (urlImage.length != 0) {
      return Image.network(urlImage);
    } else {
      return Image.asset('images/child.png');
    }
  }

  Widget saveChildrenButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Colors.blue[300],
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (statusSave) {
          listChildrens.add(barcode);
          print('listChildren ==> ${listChildrens.toString()}');
          uploadToServer(context);
        } else {
          showSnackBar('Bar Code ยังไม่สมบูรณ์ คะ');
        }
      },
    );
  }

  void uploadToServer(BuildContext context) async {
    String urlString =
        'http://tscore.ms.ac.th/App/editUserMariaWhereId.php?isAdd=true&id=$idLogin&idCode=${listChildrens.toString()}';
    var response = await get(urlString);
    var result = json.decode(response.body);
    if ((result.toString() != 'null')) {
      // print('upload OK');
      Navigator.of(context).pop();
    } else {
      showSnackBar('Have Error Please Try Again');
    }
  }

  Widget findChildren() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text('Find'),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          loadChildren();
        }
      },
    );
  }

  Future loadChildren() async {
    String url =
        'http://tscore.ms.ac.th/App/getStudentWhereQR.php?isAdd=true&idcode=$barcode';
    var response = await get(url);
    var result = json.decode(response.body);
    print('result loadChildren ==> $result');

    if (result.toString() == 'null') {
      statusSave = false;
      showSnackBar('ไม่มี QR code นี่ใน ฐานข้อมูล');
    } else {
      statusSave = true;

      for (var objJson in result) {
        ChildrenModel childrenModel = ChildrenModel.objJSON(objJson);
        setState(() {
          nameChildren = childrenModel.fname.toString();
          urlImage = childrenModel.imagePath.toString().trim();
        });
      }

      print('nameChildren ==> $nameChildren');
    }
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.orange[200],
      duration: Duration(seconds: 6),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    snackBarKey.currentState.showSnackBar(snackBar);
  }

  Future scanQR() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        // The user did not grant the camera permission.
      } else {
        // Unknown error.
      }
    } on FormatException {
      // User returned using the "back"-button before scanning anything.
    } catch (e) {
      // Unknown error.
    }
  }

  Widget qrTextFormField() {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: 'QR Readed',
        labelStyle: TextStyle(color: Colors.white),
      ),
      validator: (String value) {
        if (value.length == 0) {
          return 'Have Space';
        }
      },
      onSaved: (String value) {
        barcode = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackBarKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(titleAppBar),
      ),
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue[900]],
                  begin: Alignment(-1, -1))),
          padding: EdgeInsets.only(top: 100.0),
          alignment: Alignment(0, -1),
          child: Column(
            children: <Widget>[
              Container(
                height: 150.0,
                child: showAvata(),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: showName(),
              ),
              Container(
                width: 250.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: qrTextFormField(),
                    ),
                    findChildren()
                  ],
                ),
              ),
              Container(
                width: 250.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: scanButton(),
                    ),
                    Expanded(
                      child: saveChildrenButton(context),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
