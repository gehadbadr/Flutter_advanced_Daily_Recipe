import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class BgWidget extends StatelessWidget {
  final Widget? child;
  BgWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
    //  width: double.infinity,
      //height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imgBg), fit: BoxFit.fill)),
        child:child );
  }
}

