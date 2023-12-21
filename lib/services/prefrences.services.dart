import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefrencesService {
  static SharedPreferences? prefs;


  static Future savePrefs({email, password, name, login}) async {
    prefs!.setString('name', name);
    prefs!.setString('email', email);
    prefs!.setString('password', password);
    prefs!.setBool('login', login);
  }

  static Future isLogin() async {
    bool? value = prefs!.getBool('login');
    return value;
  }

  static Future logOut() async {
    prefs!.setBool('login', false);
  }
}
