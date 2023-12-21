import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefrencesService {
  static SharedPreferences? prefs;

  static Future isLogin() async {
    bool? value = prefs!.getBool('login');
    return value;
  }

}
