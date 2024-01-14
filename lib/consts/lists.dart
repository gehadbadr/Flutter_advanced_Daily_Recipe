import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

abstract class ListsApp {
  static const socialIconList = [
    ImagesPath.icFacebookLogo,
    ImagesPath.icGoogleLogo,
    ImagesPath.icTwitterLogo
  ];
  static const sliderList = [
    ImagesPath.slider1,
    ImagesPath.slider2,
    ImagesPath.slider3,
    ImagesPath.slider4,
    ImagesPath.slider5
  ];

    static const drawerList = [
      { "icon":Icons.home,
    "title":TextApp.home,
    "color":ColorsApp.PKColor,
    "path": 'HomepageScreen'},
    { "icon":Icons.home,
    "title":TextApp.home,
    "color":ColorsApp.PKColor,
    "path": 'HomepageScreen'},

  ];
}
