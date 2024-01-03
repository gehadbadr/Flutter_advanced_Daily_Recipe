import 'package:daily_recipe/consts/consts.dart';
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
              child: Image(image: AssetImage(ImagesPath .imgBg), fit: BoxFit.fill),
            ),
             Container(
                  height: context.screenHeight,
                  width: context.screenWidth,
                    child: SingleChildScrollView(
                      child: Column(
                                  children: [
                                    SizedBox(
                                      height: context.screenHeight / 3,
                                    ),
                                    appLogoWidget(),
                                    Text(
                                      TextApp.slogen,
                                      style: TextStyle(fontSize: 20, color: ColorsApp.fontGrey),
                                    ),
                                    SizedBox(
                                      height: context.screenHeight / 4,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: context.screenWidth - 50,
                                      child: CustomButton(
                      bgColor: ColorsApp.PKColor,
                      textColor: ColorsApp.whiteColor,
                      title: TextApp.login,
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
                      textColor: ColorsApp.whiteColor,
                      title: TextApp.signup,
                      onPress: () async {
                          Navigator.pushNamed(context, 'SignupScreen/');
                      },
                                      ),
                                    ),
                    
                                    //  ),
                                  ],
                                ),
                    )),
          ],
        ));
  }
}
