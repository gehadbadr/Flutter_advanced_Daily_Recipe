
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/drawer.widgets.dart';
import 'package:daily_recipe/screens/recipes/components/recipes.components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  State<FavoriteRecipesScreen> createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
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
              const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            TextApp.favorite,
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                        ),
                        Text(
                          TextApp.clear,
                          style: TextStyle(fontWeight: FontWeight.w600,color: ColorsApp.PKColor, fontSize: 16),
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
                      child: TextFormField(
                        cursorColor: ColorsApp.borderLine,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)),
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
                            hintText: TextApp.searchAnyKey,
                            hintStyle: TextStyle(color: ColorsApp.borderLine)),
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
              const SizedBox(
              height: 10,
            ),
            Consumer<RecipeController>(
              builder: (context, recipeController, child) {
            //  recipeController.getRecipes();
                return Column(
                  children: [
                    recipeController.recommendedList!.isEmpty
                        ? const CircularProgressIndicator()
                        : SingleChildScrollView(
                          padding: const EdgeInsets.all(0),
                          scrollDirection: Axis.horizontal,
                          child: Column(
                              children: List.generate(
                                  recipeController.recommendedList!.length,
                                  (index) => Recipes(
                                      id: recipeController
                                          .recommendedList![index].id,
                                      title: recipeController
                                          .recommendedList![index].title!,
                                      image: recipeController
                                          .recommendedList![index].image,
                                      meal_type: recipeController
                                          .recommendedList![index].mealType,
                                      rating: recipeController
                                          .recommendedList![index].rating,
                                      calerios: recipeController
                                          .recommendedList![index].calerios,
                                      serving: recipeController
                                          .recommendedList![index].serving,
                                      prep_time: recipeController
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
