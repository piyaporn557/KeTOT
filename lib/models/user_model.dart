class UserModel {

  // Field
  String id, name, user, password, avatar;


  // Comstructor
  UserModel(this.id, this.name, this.password, this.user, this.avatar);

  UserModel.fromJSON(Map<String, dynamic> map){
    id = map['id'];
    name = map['Name'];
    user = map['User'];
    password = map['Password'];
    avatar = map['Avatar'];
  }
  
}