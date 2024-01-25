import 'package:flutter/material.dart';

class Ingredients extends StatelessWidget {
  final List? ingredients;

  const Ingredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:List.generate(
         ingredients!.length,
          (index) =>
              Text(ingredients![index]))),
  );
  
  }
}
