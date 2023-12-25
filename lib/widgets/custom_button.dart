import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? bgColor;
  final Color? textColor;
  final String? title;
  final Function()? onPress;
  const CustomButton(
      {super.key, this.bgColor, this.textColor, this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom( 
            backgroundColor: bgColor!, padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
        ),),
            
        onPressed:onPress,
        child: Text(title!,style: TextStyle(color: textColor,fontFamily: bold,fontSize: 16),)
        );
  }
}
