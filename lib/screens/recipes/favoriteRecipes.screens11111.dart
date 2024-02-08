import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:daily_recipe/widgets/filter_button.dart';
import 'package:daily_recipe/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  State<FavoriteRecipesScreen> createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
  // ValueNotifier<List<Map>> filtered = ValueNotifier<List<Map>>([]);
  // TextEditingController searchController = TextEditingController();
  // FocusNode searchFocus = FocusNode();
  // bool searching = false;
  @override
  void initState() {
    Provider.of<RecipeController>(context, listen: false).initFavorite();
    super.initState();
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
              onPressLeading: () async{
              await  Provider.of<ProfileController>(context, listen: false)
                      .getUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomepageScreen(
                            profileDetails: Provider.of<ProfileController>(
                                    context,
                                    listen: false)
                                .profileDetails)),
                  );},
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
                        TextApp.favorite,
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
                            Provider.of<RecipeController>(context,
                                    listen: false)
                                .runFilter(value);
                          }) 
                          ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(flex: 1, child: FilterButton()),
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
                  //recipeController.getFavoriteRecipes();
                  return Column(
                    children: [
                      recipeController.foundRecipes == null
                          ? const CircularProgressIndicator()
                          : (recipeController.foundRecipes!.isEmpty ?? false)
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
                                              recipeDetails: recipeController
                                                  .foundRecipes![index],
                                              viewType: 1,
                                              isFavorite: recipeController
                                                  .isFavoriteById(
                                                      recipeController
                                                              .foundRecipes![
                                                          index]),
                                              onPressAction: () {
                                                recipeController
                                                    .addFavoriteMethodById(
                                                        recipeController
                                                                .foundRecipes![
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