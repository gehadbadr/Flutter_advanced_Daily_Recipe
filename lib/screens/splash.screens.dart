import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/services/prefrences.services.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  //final prefsFile = PrefrencesService.prefs;

  SplashScreen({super.key});

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
    await Future.delayed(Duration(seconds: 4), () {});
    bool? res = await PrefrencesService.isLogin();
    if (res == true) {
      Navigator.pushReplacementNamed(context, 'HomepageScreen/');
    } else {
      Navigator.pushReplacementNamed(context, 'IntroScreen/');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              //
              child: Image(image: AssetImage(ImagesPath .imgBg), fit: BoxFit.fill),
            ),
            SingleChildScrollView(
                child: Container(
              height: context.screenHeight,
              width: context.screenWidth,
              child: Column(
                children: [
                  SizedBox(
                    height: context.screenHeight / 2.5,
                  ),
                  appLogoWidget(),
                ],
              ),
            )),
          ],
        ));
  }
}
