class NotiModel {
  
  String title, body;

  NotiModel(this.title, this.body);

  NotiModel.fromJSON(Map<dynamic, dynamic> parseJSON){
    title = parseJSON['title'];
    body = parseJSON['body'];
  }

}