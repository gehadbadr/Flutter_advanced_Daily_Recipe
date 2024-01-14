import 'package:daily_recipe/app_router.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/providers/home.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    //  PrefrencesService.prefs = await SharedPreferences.getInstance();
    var prefrence = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(prefrence);
  } catch (e) {
    print(e.toString());
  }
  runApp(const MyApp());

  /// The route configuration.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'Daily Recipe',
        /*    theme: ThemeData(
      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),*/
        theme: ThemeData(
          fontFamily: 'Hellix',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xfff45b00),
            primary: const Color(0xfff45b00),
            secondary: const Color(0xfff45b00),
          ),
          useMaterial3: true,
        ),

        /*initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            'IntroScreen/': (context) => const IntroScreen(),
            'LoginScreen/': (context) => LoginScreen(),
            'SignupScreen/': (context) => SignupScreen(),
            'HomepageScreen/': (context) => const HomepageScreen(),
            'ViewedRecipesScreen/': (context) => const ViewedRecipesScreen(),
            'FavoriteRecipesScreen/': (context) => const FavoriteRecipesScreen(),
            'RecipeDetailsScreen/': (context) => const RecipeDetailsScreen(),
          }*/
      ),
    );
  }
}
