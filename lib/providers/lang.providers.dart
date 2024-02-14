
import 'package:daily_recipe/consts/consts.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangController extends ChangeNotifier {
  String _appLocale = 'en';
  String get appLocal => _appLocale;

  final prefsFile = GetIt.I.get<SharedPreferences>();


  Future getLocal() async {
    _appLocale = prefsFile.getString('lang') ?? 'en';
    return _appLocale;
  }

  // Future<void> saveLocale(String Locale) async {
  //   await prefsFile.setString('lang', Locale);
  // }

  // void getLocale() async {
  //   var recipesData = await rootBundle.loadString('assets/data/sample.json');
  //   var dataDecoded =
  //       List<Map<String, dynamic>>.from(jsonDecode(recipesData)['lang']);
  //   lang = dataDecoded.map((e) => Lang.fromJson(e)).toList();

  //   notifyListeners();
  // }

  void setLocale(String locale, BuildContext context)async {
        OverlayLoadingProgress.start();

    _appLocale = locale;

    // PrefrencesService.getLang();
    // print('old');
    // print(PrefrencesService.lang);
    await prefsFile.setString('lang', _appLocale);
    S.load(Locale(locale));
    
        notifyListeners();

   await Future.delayed(const Duration(seconds: 2), () {});
    OverlayLoadingProgress.stop();
  //  Navigator.pushNamed(context, AppRoutes.splash);

    //  await S.load(const Locale.fromSubtags(languageCode: 'ar'));

    // print('new');
    // PrefrencesService.getLang();
    // print(PrefrencesService.lang);
    //  await PrefrencesService.saveLocale('en');
    // await saveLocale(local);
    //saveLocale(_appLocale);
    // print('local');
    // print(locale);
    // print('_appLocale');
    // print(_appLocale);
//     if (local == Locale("ar")) {
//       _appLocale = Locale("ar");
//       //   Locale _locale = await setLocale(language.languageCode);
// //    MyApp.setLocale(context, _appLocale);
//       // context.setLocale(_newLocale);
//       //await context.setLocale(newLocale); // change `easy_localization` locale
//     } else {
//       _appLocale = Locale("en");
//       //      MyApp.setLocale(context, _appLocale);
//     }
//       print('1111111111111111111');  print(_appLocale);
//     notifyListeners();
  }

  // bool isArabic() {
  //   return Intl.getCurrentLocale() == 'ar';
  // }

  bool isArabic() {
    return _appLocale == 'ar';
  }
  // String islocal() {
  //   return  Intl.getCurrentLocale();
  // }
}
