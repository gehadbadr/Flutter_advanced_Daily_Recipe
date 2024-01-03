import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/providers/home.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homepage.screens.dart';
import 'package:daily_recipe/screens/intro.screens.dart';
import 'package:daily_recipe/screens/login_screen.dart';
import 'package:daily_recipe/screens/signup_screen.dart';
import 'package:daily_recipe/screens/splash.screens.dart';
import 'package:daily_recipe/services/prefrences.services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    //  PrefrencesService.prefs = await SharedPreferences.getInstance();
      var prefrence  = await SharedPreferences.getInstance();
      GetIt.I.registerSingleton<SharedPreferences>(prefrence);
  } catch (e) {
    print(e.toString());
  }
  runApp(const MyApp());
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
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Daily Recipe',
          /*    theme: ThemeData(
      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),*/
         theme: ThemeData(
          
        fontFamily: 'Hellix',
    
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xfff45b00),
          primary: Color(0xfff45b00),
          secondary: Color(0xfff45b00),
        ),
        useMaterial3: true,
      ),

          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            'IntroScreen/': (context) => IntroScreen(),
            'LoginScreen/': (context) => LoginScreen(),
            'SignupScreen/': (context) => SignupScreen(),
            'HomepageScreen/': (context) => HomepageScreen(),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
