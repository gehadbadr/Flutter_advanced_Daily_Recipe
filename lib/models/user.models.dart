class UserModel {
    String? name, email, password;
  bool? login;
  UserModel({this.name, this.email, this.password,this.login});

  UserModel.fromJson(Map<String, dynamic> data) {
     if (data == null) {
      return;
    } else {
      name = data['name'];
      email = data['email'];
      password = data['password'];
      login = data['login'];
    }
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'login': login};
  }
}
