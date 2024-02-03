import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:daily_recipe/widgets/filter_button.dart';
import 'package:daily_recipe/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewedRecipesScreen extends StatefulWidget {
  const ViewedRecipesScreen({super.key});

  @override
  State<ViewedRecipesScreen> createState() => _ViewedRecipesScreenState();
}

class _ViewedRecipesScreenState extends State<ViewedRecipesScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Provider.of<RecipeController>(context, listen: false).getViewedRecipes();
  }

    @override
  void deactivate() {
    Provider.of<RecipeController>(context, listen: false).disposeRecentlyViewed();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              actionIcon: Icons.notification_add_outlined,
              onPressAction: () {})),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        TextApp.recentlyViewed,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    ),
                    Text(
                      TextApp.clear,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ColorsApp.PKColor,
                          fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorsApp.lightGrey,
                          ),
                          child: SearchTextField(onChanged: (value) {
                            Provider.of<RecipeController>(context, listen: false).runFilter(value);
                          })),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      flex: 1,
                      child: FilterButton()
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<RecipeController>(
                    builder: (context, recipeController, child) {
                  return Column(
                    children: [
                      recipeController.foundRecipes == null
                          ? const CircularProgressIndicator()
                  :(recipeController.foundRecipes?.isEmpty ?? false)
                      ? const Text('No Data Found') 
                          : recipeController.foundRecipes!.isEmpty
                              ? const CircularProgressIndicator()
                              : SingleChildScrollView(
                                  padding: const EdgeInsets.all(0),
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: List.generate(
                                      recipeController.foundRecipes!.length,
                                      (index) => Recipes(
                                        /*  id: recipeController
                                              .foundRecipes![index].docId,
                                          title: recipeController
                                              .foundRecipes![index].title!,
                                          image: recipeController
                                              .foundRecipes![index].image,
                                          mealType: recipeController
                                              .foundRecipes![index].mealType,
                                          rating: recipeController
                                              .foundRecipes![index].rating,
                                          calerios: recipeController
                                              .foundRecipes![index].calerios,
                                          serving: recipeController
                                              .foundRecipes![index].serving,
                                          prepTime: recipeController
                                              .foundRecipes![index].prepTime,*/
                                                recipeDetails: recipeController
                                                .foundRecipes![index],
                                          viewType: 3,
                                          isFavorite: recipeController
                                              .isFavoriteById(recipeController
                                                .foundRecipes![index]),
                                          onPressAction: () {
                                            recipeController.removeViewedRecipe(
                                                recipeController
                                                .foundRecipes![index].docId!, context);
                                          }),
                                    ),
                                  ),
                                ),
                    ],
                  );
                  //}
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}