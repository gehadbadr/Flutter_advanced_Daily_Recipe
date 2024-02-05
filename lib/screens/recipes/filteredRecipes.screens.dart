import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/filter/filter.screens.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:daily_recipe/widgets/filter_button.dart';
import 'package:daily_recipe/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilteredRecipesScreen extends StatefulWidget {
  //const FilteredRecipesScreen({super.key});
  final List<Recipe> filteredRecipes;
  const FilteredRecipesScreen({super.key, required this.filteredRecipes});
  @override
  State<FilteredRecipesScreen> createState() => _FilteredRecipesScreenState();
}

class _FilteredRecipesScreenState extends State<FilteredRecipesScreen> {
  // ValueNotifier<List<Map>> filtered = ValueNotifier<List<Map>>([]);
  // TextEditingController searchController = TextEditingController();
  // FocusNode searchFocus = FocusNode();
  // bool searching = false;
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
                Provider.of<ProfileController>(context, listen: false)
                    .getUser();
                Navigator.pushNamed(
                  context,AppRoutes.filterScreen
                );
              },
              actionIcon: Icons.notification_add_outlined,
              onPressAction: () {})),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        TextApp.results,
                        style: TextStyle(
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
                                              /*  id: recipeController
                                              .favoriteList![index].docId,
                                          title: recipeController
                                              .favoriteList![index].title!,
                                          image: recipeController
                                              .favoriteList![index].image,
                                          mealType: recipeController
                                              .favoriteList![index].mealType,
                                          rating: recipeController
                                              .favoriteList![index].rating,
                                          calerios: recipeController
                                              .favoriteList![index].calerios,
                                          serving: recipeController
                                              .favoriteList![index].serving,
                                          prepTime: recipeController
                                              .favoriteList![index].prepTime,*/
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
