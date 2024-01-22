import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/screens/homePage/components/carsoul.widget.dart';
import 'package:daily_recipe/widgets/drawer.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
    @override
  void initState() {
  //  init();
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
              onPressLeading: () {},
              onPressAction: () {})),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Consumer<AuthController>(
                    builder: (context, authController, child) {
                  authController.getDisplayName();
                  String? name = authController.displayName;

                  return Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${TextApp.bonjour}, $name',
                          style: const TextStyle(
                              fontSize: 20, color: ColorsApp.fontGrey)));
                }),
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
                          child: TextFormField(
                            cursorColor: ColorsApp.borderLine,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: ColorsApp.borderLine,
                                ),
                                filled: true,
                                fillColor: ColorsApp.lightGrey,
                                hintText: TextApp.searchAnyThing,
                                hintStyle:
                                    TextStyle(color: ColorsApp.borderLine)),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorsApp.lightGrey),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.tune,
                            //  size: 25,
                          ),
                        ),
                      ),
                    ),
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
                  recipeController.getRecipes();
                  return Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              TextApp.todayFreshRecipe,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                          ),
                          Text(
                            TextApp.seeAll,
                            style: TextStyle(
                                color: ColorsApp.PKColor, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      recipeController.recipesList!.isEmpty
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
                                          id: recipeController
                                              .recipesList![index].id,
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
                                              .recipesList![index].prepTime,
                                          viewType: 0,
                                        )),
                              ),
                            ),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              TextApp.recomended,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                          ),
                          Text(
                            TextApp.seeAll,
                            style: TextStyle(
                                color: ColorsApp.PKColor, fontSize: 16),
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
                                      id: recipeController
                                          .recommendedList![index].id,
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
                                          .recommendedList![index].prepTime,
                                      viewType: 1),
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
