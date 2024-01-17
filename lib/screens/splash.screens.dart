import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    if (FirebaseAuth.instance.currentUser  != null) {
      context.replaceNamed('HomepageScreen');
    } else {
      context.replaceNamed('IntroScreen');

      //Navigator.pushReplacementNamed(context, 'IntroScreen/');
    }
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
