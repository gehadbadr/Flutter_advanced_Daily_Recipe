import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:daily_recipe/widgets/filter_button.dart';
import 'package:daily_recipe/widgets/loadingCard.dart';
import 'package:daily_recipe/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              onPressLeading: () async {
                await Provider.of<ProfileController>(context, listen: false)
                    .getUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomepageScreen(
                          profileDetails: Provider.of<ProfileController>(
                                  context,
                                  listen: false)
                              .profileDetails)),
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).recentlyViewed,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    ),
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
                                .runFilter(
                                    value, AppRoutes.viewedRecipesScreen);
                          })),
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
                  return Column(
                    children: [
                      recipeController.foundRecipes == null
                          ? SingleChildScrollView(
                              padding: const EdgeInsets.all(0),
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                    ListsApp.loadingCardList.length,
                                    (index) => const LoadingListPage(
                                          viewType: 3,
                                        )),
                              ))
                          : (recipeController.foundRecipes!.isEmpty ?? false)
                              ? Text(S.of(context).noDataFound)
                              : recipeController.foundRecipes!.isEmpty
                                  ? SingleChildScrollView(
                                      padding: const EdgeInsets.all(0),
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                            ListsApp.loadingCardList.length,
                                            (index) => const LoadingListPage(
                                                  viewType: 3,
                                                )),
                                      ))
                                  : SingleChildScrollView(
                                      padding: const EdgeInsets.all(0),
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: List.generate(
                                          recipeController.foundRecipes!.length,
                                          (index) => Dismissible(
                                            key: UniqueKey(),
                                            onDismissed: (direction) {
                                              HapticFeedback.heavyImpact();
                                              recipeController
                                                  .removeViewedRecipe(
                                                      recipeController
                                                          .foundRecipes![index]
                                                          .docId!,
                                                      context);
                                            },
                                            background: Container(
                                              margin: const EdgeInsets.symmetric(
                                                  vertical: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red.shade700,
                                                ),
                                              ),
                                            ),
                                            child: Recipes(
                                                recipeDetails: recipeController
                                                    .foundRecipes![index],
                                                viewType: 3,
                                                isFavorite: recipeController
                                                    .isFavoriteById(
                                                        recipeController
                                                                .foundRecipes![
                                                            index]),
                                                onPressAction: () {
                                                  recipeController
                                                      .removeViewedRecipe(
                                                          recipeController
                                                              .foundRecipes![
                                                                  index]
                                                              .docId!,
                                                          context);
                                                }),
                                          ),
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
