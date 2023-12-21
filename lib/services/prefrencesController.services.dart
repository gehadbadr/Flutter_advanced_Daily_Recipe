import 'dart:convert';

import 'package:advanced_login/models/user.models.dart';
import 'package:advanced_login/services/prefrences.services.dart';

class PrefrencesController{
    final prefsFile = PrefrencesService.prefs;

 Future getName() async {
    String? value = prefsFile!.getString('userModel');
    UserModel usermodel = UserModel.fromJson(json.decode(value!));
    //  print(usermodel.toJson());
    return usermodel.name ;
    /*  prefs.setString('email', email);
      prefs.setString('password', password);
      print(prefs.getString('name'));
      print(prefs.getString('email'));
      print(prefs.getString('password'));*/
  }
}