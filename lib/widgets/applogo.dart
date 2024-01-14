import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
  return Image.asset(ImagesPath.icAppLogo,width: 200,);
  }
}
