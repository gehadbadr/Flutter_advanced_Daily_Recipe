import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:daily_recipe/widgets/filter_button.dart';
import 'package:daily_recipe/widgets/search_textfield.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllRecipesScreen extends StatefulWidget {
  const AllRecipesScreen({super.key});

  @override
  State<AllRecipesScreen> createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  // ValueNotifier<List<Map>> filtered = ValueNotifier<List<Map>>([]);
  // TextEditingController searchController = TextEditingController();
  // FocusNode searchFocus = FocusNode();
  // bool searching = false;
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
              actionIcon: Icons.notification_add_outlined,
              onPressAction: () {})),
      body:   Padding(
        padding: const EdgeInsets.only(top:20.0,left:20.0,bottom:20.0),
        child: Consumer<RecipeController>(
              builder: (ctx, recipeController, _) =>
                  recipeController.recipesList == null
                      ? const CircularProgressIndicator()
                      : (recipeController.recipesList?.isEmpty ?? false)
                          ? const Text('No Data Found')
                          : FlexibleGridView(
                              axisCount: MediaQuery.of(context).size.width < 450?GridLayoutEnum.twoElementsInRow:GridLayoutEnum.threeElementsInRow,
                              crossAxisSpacing:1,
                              mainAxisSpacing: 1,
                               children: recipeController.recipesList!
                                  .map((e) =>Recipes(
                                              recipeDetails: e,
                                              viewType: 4,
                                              isFavorite: recipeController
                                                  .isFavoriteById(e),
                                              onPressAction: () {
                                                recipeController
                                                    .addFavoriteMethodById(
                                                        e,
                                                        context,
                                                        AppRoutes.homepageScreen);
                                              }))
                                  .toList(),
                            /*  children: recipeController.recipesList!
                                  .map((e) =>  Recipes(
                                              /*  id: recipeController
                                                  .recipesList![index].docId,
                                              title: recipeController
                                                  .recipesList![index].title!,
                                              image: recipeController
                                                  .recipesList![index].image,
                                              mealType: recipeController
                                                  .recipesList![index].mealType,
                                              rating: recipeController
                                                  .recipesList![index].rating,
                                              calerios: recipeController
                                                  .recipesList![index].calerios,
                                              serving: recipeController
                                                  .recipesList![index].serving,
                                              prepTime: recipeController
                                                  .recipesList![index].prepTime,*/
                                              recipeDetails: e,
                                              viewType: 0,
                                              isFavorite: recipeController
                                                  .isFavoriteById(e),
                                              onPressAction: () {
                                                recipeController
                                                    .addFavoriteMethodById(
                                                        e,
                                                        context,
                                                        AppRoutes.homepageScreen);
                                              }))
                                  .toList(),*/
                            )),
      ),
            
    //  SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.all(20.0),
    //       child: SingleChildScrollView(
    //         physics: const BouncingScrollPhysics(),
    //         child: Column(
    //           children: [
    //             const Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Expanded(
    //                   child: Text(
    //                     TextApp.recipes,
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.w500, fontSize: 25),
    //                   ),
    //                 ),
            
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //          Consumer<RecipeController>(
    //         builder: (ctx, recipeController, _) =>
    //             recipeController.recipesList == null
    //                 ? const CircularProgressIndicator()
    //                 : (recipeController.recipesList?.isEmpty ?? false)
    //                     ? const Text('No Data Found')
    //                     : FlexibleGridView(

    //                         axisCount: GridLayoutEnum.twoElementsInRow,
    //                         crossAxisSpacing: 8,
    //                         mainAxisSpacing: 8,
    //                          children: recipeController.recipesList!
    //                             .map((e) => Text(e.title!))
    //                             .toList(),
    //                       /*  children: recipeController.recipesList!
    //                             .map((e) =>  Recipes(
    //                                         /*  id: recipeController
    //                                             .recipesList![index].docId,
    //                                         title: recipeController
    //                                             .recipesList![index].title!,
    //                                         image: recipeController
    //                                             .recipesList![index].image,
    //                                         mealType: recipeController
    //                                             .recipesList![index].mealType,
    //                                         rating: recipeController
    //                                             .recipesList![index].rating,
    //                                         calerios: recipeController
    //                                             .recipesList![index].calerios,
    //                                         serving: recipeController
    //                                             .recipesList![index].serving,
    //                                         prepTime: recipeController
    //                                             .recipesList![index].prepTime,*/
    //                                         recipeDetails: e,
    //                                         viewType: 0,
    //                                         isFavorite: recipeController
    //                                             .isFavoriteById(e),
    //                                         onPressAction: () {
    //                                           recipeController
    //                                               .addFavoriteMethodById(
    //                                                   e,
    //                                                   context,
    //                                                   AppRoutes.homepageScreen);
    //                                         }))
    //                             .toList(),*/
    //                       ))],
    //         ),
    //       ),
    //     ),
    //   ),
    );
  }
}
