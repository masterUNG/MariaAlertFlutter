import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:developer';

class AddChildren extends StatefulWidget {
  @override
  _AddChildrenState createState() => _AddChildrenState();
}

class _AddChildrenState extends State<AddChildren> {
  String titleAppBar = 'เพิ่มบุตร หลาน ของท่าน';
  String barcode = '';

  Widget showName() {
    return Text(
      'ชื่อ นามสกุล',
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
      },
    );
  }

  Widget showAvata() {
    return Image.asset('images/child.png');
  }

  Widget saveChildrenButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Colors.blue[300],
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(titleAppBar),
      ),
      body: Container(
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
                    child: scanButton(),
                  ),
                  Expanded(
                    child: saveChildrenButton(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
