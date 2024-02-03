import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ingredients extends StatefulWidget {
  final List? ingredients;

  const Ingredients({super.key, required this.ingredients});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Provider.of<RecipeController>(context, listen: false).getUserIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeController>(
        builder: (context, recipeController, child) {
      return //Flexible(
          //  child:
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.ingredients
                ?.map((e) => ListTile(
                    title:
                        Text(e),
                    trailing  :  recipeController.checkIngredientWidget(e)
                    ))
                .toList() ??
            [],
      );
      //);
    });
    // return Flexible(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children:List.generate(
    //        ingredients!.length,
    //         (index) =>
    //             Text(ingredients![index]))),
    // );
  }
}
