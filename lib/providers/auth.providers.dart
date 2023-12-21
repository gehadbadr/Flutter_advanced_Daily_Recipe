import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/services/prefrences.services.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool isLoading = false;
  bool obscureText = false;
  final prefsFile = PrefrencesService.prefs;

  changeisLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool _isTrue = true;
  bool _isConfirmPassword = true;
  bool get isTrue => _isTrue;
  bool get isConfirmPassword => _isConfirmPassword;

  get switchPasswordIcon {
    return _isConfirmPassword
        ? Icon(
            Icons.visibility_off,
            color: PKColor,
          )
        : Icon(Icons.visibility);
  }

  get switchConfirmPasswordIcon {
    return _isTrue
        ? Icon(
            Icons.visibility_off,
            color: PKColor,
          )
        : Icon(Icons.visibility);
  }

  void toggleConfirmPassword() {
    _isConfirmPassword = !_isConfirmPassword;
    notifyListeners();
  }

  void togglePassword() {
    _isTrue = !_isTrue;
    notifyListeners();
  }

  //SharedPrefrence

  Future savePrefs({email, password, name, login}) async {
    prefsFile!.setString('name', name);
    prefsFile!.setString('email', email);
    prefsFile!.setString('password', password);
    prefsFile!.setBool('login', login);
    notifyListeners();

  }

  Future isLogin() async {
    bool? value = prefsFile!.getBool('login');
    return value;
  }

  Future logOut() async {
    prefsFile!.setBool('login', false);
    notifyListeners();
  }

  Future getName() async {
    String? userValue = prefsFile!.getString('name');
    String? emailValue = prefsFile!.getString('email');
    String? passwordValue = prefsFile!.getString('password');
    bool? loginValue = prefsFile!.getBool('login');
    List data =[userValue,emailValue,passwordValue,loginValue];
    return data;
    notifyListeners();
  }
}
