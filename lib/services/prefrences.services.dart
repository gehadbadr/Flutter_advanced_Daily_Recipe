import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefrencesService {
  static SharedPreferences? prefs;
  static final prefsFile = GetIt.I.get<SharedPreferences>();
  static String? lang ;

  static Future<String?> getLang() async {
    lang = await prefsFile.getString('lang') ;
    return lang ;
  }

  static Future<void> saveLocale(String Locale) async {
    await prefsFile.setString('lang', Locale);
  }

}
