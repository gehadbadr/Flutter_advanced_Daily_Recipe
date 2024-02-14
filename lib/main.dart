
import 'package:daily_recipe/app_router.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/providers/home.providers.dart';
import 'package:daily_recipe/providers/ingredient.providers.dart';
import 'package:daily_recipe/providers/lang.providers.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/services/prefrences.services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var prefrence = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(prefrence);

    await PrefrencesService.getLang();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider<RecipeController>(
          create: (context) => RecipeController(),
        ),
        ChangeNotifierProvider<IngredientController>(
          create: (context) => IngredientController(),
        ),
        ChangeNotifierProvider<ProfileController>(
          create: (context) => ProfileController(),
        ),
        ChangeNotifierProvider<LangController>(
          create: (context) => LangController(),
        ),
      ],
      child: OverlayKit(
        child:
            Consumer<LangController>(builder: (context, langController, child) {
         langController.getLocal();
          String lang = langController.appLocal; /* langController.appLocal ?? PrefrencesService.lang ?? */ //'ar';

          return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: Locale(
                  lang),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                fontFamily: 'Hellix',
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xfff45b00),
                  primary: const Color(0xfff45b00),
                  secondary: const Color(0xfff45b00),
                ),
                useMaterial3: true,
              ),
              initialRoute: '/',
              routes: AppRouter.router);
        }),
      ),
    );
  }
}
