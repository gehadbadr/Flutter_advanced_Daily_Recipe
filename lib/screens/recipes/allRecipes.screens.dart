import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:daily_recipe/widgets/loadingCard.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllRecipesScreen extends StatefulWidget {
  const AllRecipesScreen({super.key});

  @override
  State<AllRecipesScreen> createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  @override
  void initState() {
    Provider.of<RecipeController>(context, listen: false).getAllRecipes();
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
        child: Consumer<RecipeController>(
            builder: (ctx, recipeController, _) => recipeController
                        .recipesList ==
                    null
                ?  FlexibleGridView(
                        axisCount: MediaQuery.of(context).size.width < 450
                            ? GridLayoutEnum.twoElementsInRow
                            : GridLayoutEnum.threeElementsInRow,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        children: ListsApp.loadingCardList
                            .map((e) => LoadingListPage(viewType: 4))
                            .toList(),
                      )
                : (recipeController.recipesList?.isEmpty ?? false)
                    ? const Text('No Data Found')
                    :FlexibleGridView(
                        axisCount: MediaQuery.of(context).size.width < 450
                            ? GridLayoutEnum.twoElementsInRow
                            : GridLayoutEnum.threeElementsInRow,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        children: recipeController.recipesList!
                            .map((e) => Recipes(
                                recipeDetails: e,
                                viewType: 4,
                                isFavorite: recipeController.isFavoriteById(e),
                                onPressAction: () {
                                  recipeController.addFavoriteMethodById(
                                      e, context, AppRoutes.homepageScreen);
                                }))
                            .toList(),
                      )
                    // :FlexibleGridView(
                    //     axisCount: MediaQuery.of(context).size.width < 450
                    //         ? GridLayoutEnum.twoElementsInRow
                    //         : GridLayoutEnum.threeElementsInRow,
                    //     crossAxisSpacing: 1,
                    //     mainAxisSpacing: 1,
                    //     children: ListsApp.loadingCardList
                    //         .map((e) => LoadingListPage(viewType: 4))
                    //         .toList(),
                    //   )
     ),
     ),
    );
  }
}
