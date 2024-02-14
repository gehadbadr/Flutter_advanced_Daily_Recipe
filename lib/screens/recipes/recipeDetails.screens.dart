import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/screens/recipes/components/ingredients.components.dart';
import 'package:daily_recipe/screens/recipes/components/directions.components.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipeDetails;
  const RecipeDetailsScreen({super.key, required this.recipeDetails});

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
        .addViewedRecipeByUserId(widget.recipeDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.lightGrey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              leadingIcon: Icons.arrow_back,
              onPressLeading: ()async {
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
                  );              },
              actionIcon: Icons.language,
              onPressAction: () {})),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: context.screenWidth,
            color: ColorsApp.lightGrey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Consumer<RecipeController>(
                    builder: (context, recipeController, child) {
                
                  return Column(
                    children: [
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Recipes(
                            recipeDetails: widget.recipeDetails,
                              viewType: 2,
                              isFavorite:
                                  recipeController.recipeDetails.docId != null && recipeController.recipeDetails.docId== widget.recipeDetails.docId
                                      ? recipeController.isFavoriteById(
                                          recipeController.recipeDetails)
                                      :
                                  recipeController
                                      .isFavoriteById(widget.recipeDetails),
                              onPressAction: () {
                                var details;
                                if (recipeController.recipeDetails.docId != null && recipeController.recipeDetails.docId== widget.recipeDetails.docId) {
                                   details = recipeController.recipeDetails;
                                } else {
                                details = widget.recipeDetails;
                                 }
                                recipeController.addFavoriteMethodById(details,
                                    context, AppRoutes.recipeDetailsScreen);
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                S.of(context).ingredients,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ),
                            Row(children: [
                              Container(
                                width: context.screenWidth - 50,
                                padding: const EdgeInsets.only(left: 10),
                                child: Ingredients(
                                    ingredients:
                                        widget.recipeDetails.ingredients),
                              )
                            ]),
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
                      //  height: context.screenHeight,
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
                                 Padding(
                                  padding: const EdgeInsets.only(bottom: 5, left: 10),
                                  child: Text(
                                    S.of(context).directions,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ),
                                Directions(
                                    directions:
                                        widget.recipeDetails.directions),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                    //}
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
