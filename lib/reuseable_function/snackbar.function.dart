import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

abstract class ShowSnackbar {
  static void showSnackbar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        title,
        style: const TextStyle(color: ColorsApp.PKColor,fontWeight: FontWeight.w600),
      ),
      //elevation: 1,
      showCloseIcon: true,  
      closeIconColor: ColorsApp.PKColor,
      dismissDirection: DismissDirection.endToStart,
    ));
  }
}
