import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class RecipesImages extends StatelessWidget {
  final String?  image;

  const RecipesImages({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(12),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
      color: ColorsApp.whiteColor,
      borderRadius: BorderRadius.circular(10)
      ),
      child: Image.asset(image!, fit: BoxFit.fill,width: 50,height: 50,),
    );
  }

}
