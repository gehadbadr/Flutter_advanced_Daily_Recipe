class UserModel {
    String? name, email, password,imageUrl,docid;
  UserModel({this.name, this.email, this.password, this.imageUrl});

  UserModel.fromJson(Map<String, dynamic> data, [String? id]) {
      docid = data['id'];
      name = data['name'];
      email = data['email'];
      password = data['password'];
      imageUrl = data['imageUrl'];
    
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'imageUrl': imageUrl};
  }
}
