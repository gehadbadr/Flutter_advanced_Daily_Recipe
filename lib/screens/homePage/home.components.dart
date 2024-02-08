import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/user.models.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homePage/components/carsoul.widget.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/filter_button.dart';
import 'package:daily_recipe/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  final ZoomDrawerController? controller;
  final UserModel profileDetails;
  const HomeWidget(
      {super.key, required this.controller, required this.profileDetails});
  //const HomeWidget({super.key, required this.controller});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Provider.of<RecipeController>(context, listen: false).getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              leadingIcon: Icons.menu,
              actionIcon: Icons.notification_add_outlined,
              onPressLeading: () {
                widget.controller!.toggle!();
              },
              onPressAction: () {})),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Consumer<ProfileController>(
                //     builder: (context, profileController, child) =>
                //   profileController.profileDetails == null
                //       ? const Text('No Data Found')
                //       : profileController.profileDetails.docid!.isEmpty
                //           ? const CircularProgressIndicator()
                //           : Align(
                //               alignment: Alignment.centerLeft,
                //               child: Text(
                //                   '${TextApp.bonjour}, ${widget.profileDetails.name}',
                //                   style: const TextStyle(
                //                       fontSize: 20,
                //                       color: ColorsApp.fontGrey)))
                // ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        '${TextApp.bonjour}, ${widget.profileDetails.name}',
                        style: const TextStyle(
                            fontSize: 20, color: ColorsApp.fontGrey))),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    TextApp.whatToCook,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                  ),
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
                          child: SearchTextField(onClick: () {
                            Navigator.pushNamed(
                                context, AppRoutes.filterScreen);
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
                const CarsoulWidget(),
                const SizedBox(
                  height: 10,
                ),
                Consumer<RecipeController>(
                    builder: (context, recipeController, child) {
                  //call here to add favorite
                  //recipeController.getRecipes();
                  return Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              TextApp.todayFreshRecipe,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                          ),
                          InkWell(
                            onTap: () {    Navigator.pushNamed(
                                  context, AppRoutes.allRecipesScreen);
                            },
                            child: const Text(
                              TextApp.seeAll,
                              style: TextStyle(
                                  color: ColorsApp.PKColor, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      recipeController.recipesList! == null
                          ? const Text('No Data Found')
                          : recipeController.recipesList!.isEmpty
                              ? const CircularProgressIndicator()
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        recipeController.recipesList!.length,
                                        (index) => Recipes(
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
                                            recipeDetails: recipeController
                                                .recipesList![index],
                                            viewType: 0,
                                            isFavorite: recipeController
                                                .isFavoriteById(recipeController
                                                    .recipesList![index]),
                                            onPressAction: () {
                                              recipeController
                                                  .addFavoriteMethodById(
                                                      recipeController
                                                          .recipesList![index],
                                                      context,
                                                      AppRoutes.homepageScreen);
                                            })),
                                  ),
                                ),
                      const Divider(),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              TextApp.recomended,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                          ),
                      InkWell(
                            onTap: () {    Navigator.pushNamed(
                                  context, AppRoutes.allRecipesScreen);
                            },
                            child: const Text(
                              TextApp.seeAll,
                              style: TextStyle(
                                  color: ColorsApp.PKColor, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      recipeController.recommendedList!.isEmpty
                          ? const CircularProgressIndicator()
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  recipeController.recommendedList!.length,
                                  (index) => Recipes(
                                      /*  id: recipeController
                                          .recommendedList![index].docId,
                                      title: recipeController
                                          .recommendedList![index].title!,
                                      image: recipeController
                                          .recommendedList![index].image,
                                      mealType: recipeController
                                          .recommendedList![index].mealType,
                                      rating: recipeController
                                          .recommendedList![index].rating,
                                      calerios: recipeController
                                          .recommendedList![index].calerios,
                                      serving: recipeController
                                          .recommendedList![index].serving,
                                      prepTime: recipeController
                                          .recommendedList![index].prepTime,*/
                                      recipeDetails: recipeController
                                          .recommendedList![index],
                                      viewType: 1,
                                      isFavorite: recipeController
                                          .isFavoriteById(recipeController
                                              .recommendedList![index]),
                                      onPressAction: () {
                                        recipeController.addFavoriteMethodById(
                                            recipeController
                                                .recommendedList![index],
                                            context,
                                            AppRoutes.homepageScreen);
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
