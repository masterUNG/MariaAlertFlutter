class UserModel {

  int id;
  String user, password, type;

  UserModel(this.id, this.user, this.password, this.type);

  UserModel.fromJson(Map<String, dynamic> parseJSON){
    id = int.parse(parseJSON['id']);
    user = parseJSON['User'];
    password = parseJSON['Password'];
    type = parseJSON['Type'];
  }
  
}