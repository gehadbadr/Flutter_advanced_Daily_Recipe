import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/recipes/components/images.components.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/drawer.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String? recipeId;
  const RecipeDetailsScreen({super.key, required this.recipeId});
  int idInt() {
    int id = int.parse(recipeId!);
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              leadingIcon: Icons.menu,
              actionIcon: Icons.notification_add_outlined,
              onPressLeading: () {},
              onPressAction: () {})),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: context.screenWidth,
              color: ColorsApp.lightGrey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<RecipeController>(
                      builder: (context, recipeController, child) {
                    print(recipeId);
                    recipeController.getRecipes();
                    //  int id =idInt();
                    recipeController.getRecipeById(4);
                    return Column(
                      children: [
                        recipeController.recipeDetails.isEmpty
                            ? const CircularProgressIndicator()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(children: [
                                  Recipes(
                                      id: recipeController.recipeDetails[0].id,
                                      title: recipeController
                                          .recipeDetails[0].title!,
                                      image: recipeController
                                          .recipeDetails[0].image,
                                      meal_type: recipeController
                                          .recipeDetails[0].meal_type,
                                      rating: recipeController
                                          .recipeDetails[0].rating,
                                      calerios: recipeController
                                          .recipeDetails[0].calerios,
                                      serving: recipeController
                                          .recipeDetails[0].serving,
                                      prep_time: recipeController
                                          .recipeDetails[0].prep_time,
                                      viewType: 2),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                      width: context.screenWidth - 50,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            TextApp.ingredients,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                children:
                                                    List.generate(7, (index) {
                                              return RecipesImages(
                                                  image: recipeController
                                                      .recipeDetails[0].image);
                                            })),
                                          ),
                                        ],
                                      )),
                                ]),
                              ),
                      ],
                    );
                    //}
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
