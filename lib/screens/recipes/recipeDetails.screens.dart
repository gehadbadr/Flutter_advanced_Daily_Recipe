import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/recipes/components/ingredients.components.dart';
import 'package:daily_recipe/screens/recipes/components/directions.components.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final String? recipeId;
  const RecipeDetailsScreen({super.key, required this.recipeId});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Provider.of<RecipeController>(context, listen: false)
        .getRecipeById(widget.recipeId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.lightGrey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              actionIcon: Icons.notification_add_outlined,
              onPressAction: () {})),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            //  padding: const EdgeInsets.all(20.0),
            width: context.screenWidth,
            color: ColorsApp.lightGrey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Consumer<RecipeController>(
                    builder: (context, recipeController, child) {
                  if (recipeController.recipeDetails == null) {
                    return const Text('No Data Found');
                  } else if (recipeController.recipeDetails!.isEmpty) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Recipes(
                                id: recipeController.recipeDetails![0].docId,
                                title:
                                    recipeController.recipeDetails![0].title!,
                                image: recipeController.recipeDetails![0].image,
                                mealType:
                                    recipeController.recipeDetails![0].mealType,
                                rating:
                                    recipeController.recipeDetails![0].rating,
                                calerios:
                                    recipeController.recipeDetails![0].calerios,
                                serving:
                                    recipeController.recipeDetails![0].serving,
                                prepTime: recipeController
                                    .recipeDetails![0].prepTime!,
                                viewType: 2,
                                isFavorite: recipeController.isFavoriteById(recipeController.recipeDetails!),
                                onPressAction: () {
                                          recipeController.addFavoriteMethodById(
                                              recipeController.recipeDetails!, context);
                                        }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    TextApp.ingredients,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Ingredients(
                                          ingredients: recipeController
                                              .recipeDetails![0].ingredients),
                                    )
                                  ]),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: ColorsApp.whiteColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            padding: const EdgeInsets.all(20),
                            height: context.screenHeight,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 150,
                                  height: 5,
                                  color: ColorsApp.lightGrey,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 5, left: 10),
                                      child: Text(
                                        TextApp.directions,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Directions(
                                        directions: recipeController
                                            .recipeDetails![0].directions),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
