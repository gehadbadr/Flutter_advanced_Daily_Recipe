import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class appLogoWidget extends StatelessWidget {
  const appLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
  return Image.asset(ImagesPath.icAppLogo,width: 200,);
  }
}
