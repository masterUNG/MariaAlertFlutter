import 'package:flutter/material.dart';

class ShowDetailImage extends StatefulWidget {
  final String urlString;
  ShowDetailImage({Key key, this.urlString}) : super(key: key);

  @override
  _ShowDetailImageState createState() => _ShowDetailImageState();
}

class _ShowDetailImageState extends State<ShowDetailImage> {
  String url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      url = widget.urlString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ภาพขยาย'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        child: Image.network(url, fit: BoxFit.fill,),
      ),
    );
  }
}
