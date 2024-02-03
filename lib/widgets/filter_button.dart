import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorsApp.lightGrey),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.filterScreen);
          },
          icon: const Icon(
            Icons.tune,
            //  size: 25,
          ),
        ));
  }
}
