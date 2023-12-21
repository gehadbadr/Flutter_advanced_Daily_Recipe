import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/services/prefrences.services.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:daily_recipe/widgets/bg.widgets.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final prefsFile = PrefrencesService.prefs;

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
    //print(res);
    if (res == true) {
      Navigator.pushReplacementNamed(context, 'HomepageScreen/');
    } else {
      Navigator.pushReplacementNamed(context, 'LoginScreen/');
    }
  }

  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned.fill(
        //
        child: Image(image: AssetImage(imgBg), fit: BoxFit.fill),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Center(
                  child: Column(
            children: [
              SizedBox(
                height: context.screenHeight / 3,
              ),
              appLogoWidget(),
              Text(
                slogen,
                style: TextStyle(fontSize: 20, color: fontGrey),
              ),
              SizedBox(
                height: context.screenHeight / 4,
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: context.screenWidth - 50,
                child: CustomButton(
                  bgColor: PKColor,
                  textColor: whiteColor,
                  title: login,
                  onPress: () async {
                    _navigatetohome();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: CustomButton(
                  bgColor: Colors.transparent,
                  textColor: whiteColor,
                  title: signup,
                  onPress: () async {
                    _navigatetohome();
                  },
                ),
              ),

              //  ),
            ],
          )))),
    ]);
  }
}
