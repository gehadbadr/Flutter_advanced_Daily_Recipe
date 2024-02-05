import 'dart:async';

import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<User?>? _listener;

  @override
  void initState() {
    _navigatetohome();
    super.initState();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
  
    _listener = FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.pushReplacementNamed(context, AppRoutes.introScreen);
      } else {
          await Provider.of<ProfileController>(context, listen: false)
                      .getUser();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomepageScreen(
                            profileDetails: Provider.of<ProfileController>(
                                    context,
                                    listen: false)
                                .profileDetails)),
                  );
      //  Navigator.pushReplacementNamed(context, AppRoutes.homepageScreen);
      }
    });
  }

  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            const Positioned.fill(
              //
              child:
                  Image(image: AssetImage(ImagesPath.imgBg), fit: BoxFit.fill),
            ),
            SingleChildScrollView(
                child: SizedBox(
              height: context.screenHeight,
              width: context.screenWidth,
              child: Column(
                children: [
                  SizedBox(
                    height: context.screenHeight / 2.5,
                  ),
                  const AppLogoWidget(),
                ],
              ),
            )),
          ],
        ));
  }
}
