import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilteredRecipesScreen extends StatefulWidget {
  final List<Recipe> filteredRecipes;
  const FilteredRecipesScreen({super.key, required this.filteredRecipes});
  @override
  State<FilteredRecipesScreen> createState() => _FilteredRecipesScreenState();
}

class _FilteredRecipesScreenState extends State<FilteredRecipesScreen> {

  @override
  void initState() {
    //init();
    super.initState();
  }

  init() {
    Provider.of<RecipeController>(context, listen: false).getFilteredResult();
  }

  @override
  void deactivate() {
    Provider.of<RecipeController>(context, listen: false).disposeFoundRecipes();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              leadingIcon: Icons.arrow_back,
              onPressLeading: () {
                // Provider.of<ProfileController>(context, listen: false)
                //     .getUser();
                Navigator.pushNamed(
                  context,AppRoutes.filterScreen
                );
              },
              actionIcon: Icons.language,
              onPressAction: () {})),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).results,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    ),
                  ],
                ),          
                const SizedBox(
                  height: 30,
                ),
                Consumer<RecipeController>(
                    builder: (context, recipeController, child) {
                  //recipeController.getFavoriteRecipes();
                  return Column(
                    children: [
                      recipeController.filteredRecipes == null
                          ? const CircularProgressIndicator()
                          : (widget.filteredRecipes.isEmpty ?? false)
                              ? const Text('No Data Found')
                              :widget.filteredRecipes.isEmpty
                                  ? const CircularProgressIndicator()
                                  : SingleChildScrollView(
                                      padding: const EdgeInsets.all(0),
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: List.generate(
                                          widget.filteredRecipes.length,
                                          (index) => Recipes(
                                              recipeDetails: widget.filteredRecipes[index],
                                              viewType: 5,
                                              isFavorite: recipeController
                                                  .isFavoriteById(
                                                      widget.filteredRecipes[
                                                          index]),
                                              onPressAction: () {
                                                recipeController
                                                    .addFavoriteMethodById(
                                                      widget.filteredRecipes[
                                                            index],
                                                        context,
                                                        AppRoutes
                                                            .favoriteRecipesScreen);
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
