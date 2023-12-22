import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/services/prefrences.services.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: <Widget>[
      Positioned.fill(
        //
        child: Image(image: AssetImage(imgBg), fit: BoxFit.fill),
      ),
            SingleChildScrollView(
                child: Container(
                  height: context.screenHeight,
                  width: context.screenWidth,
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
                        Navigator.pushNamed(context, 'LoginScreen/');
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: context.screenWidth - 50,
                  child: CustomButton(
                    bgColor: Colors.transparent,
                    textColor: whiteColor,
                    title: signup,
                    onPress: () async {
                        Navigator.pushNamed(context, 'SignupScreen/');
                    },
                  ),
                ),

                //  ),
              ],
            ))),
          ],
        ));
  }
}
