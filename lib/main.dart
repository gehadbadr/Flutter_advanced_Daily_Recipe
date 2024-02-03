import 'package:daily_recipe/app_router.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/providers/home.providers.dart';
import 'package:daily_recipe/providers/ingredient.providers.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:overlay_kit/overlay_kit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var prefrence = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(prefrence);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
  } catch (e) {
    print(e.toString());
  }
  runApp(const  MyApp());

}

class MyApp extends StatelessWidget {
  const  MyApp({super.key});

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
      ],
       child: OverlayKit(
         child: MaterialApp(
             //  .router(
             // routerDelegate: routerDelegate,
             // routeInformationParser: BeamerParser(),
             // backButtonDispatcher:
             //     BeamerBackButtonDispatcher(delegate: routerDelegate),
          // routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          // title: 'Daily Recipe',
          /*    theme: ThemeData(
             //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),*/
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
            routes:AppRouter.router
             ),
       ),
    );
  }
}
