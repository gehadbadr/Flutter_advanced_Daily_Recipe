import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/screens/recipes/filteredRecipes.screens.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void deactivate() {
    Provider.of<RecipeController>(context, listen: false).disposeFilter();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              actionIcon: Icons.notification_add_outlined,
              onPressAction: () {})),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<RecipeController>(
              builder: (context, recipeController, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        TextApp.filter,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  TextApp.meals,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                    // spa1ce between chips
                    spacing: 10,
                    // list of chips
                    children: [
                      InkWell(
                        onTap: () {
                          recipeController.selectedUserValueUpdate(
                              'mealType', 'breakfast');
                        },
                        child: Chip(
                          label: Text(TextApp.breakfast,
                              style: TextStyle(
                                fontSize: 16,
                                color: recipeController
                                            .selectedUserValue['mealType'] ==
                                        "breakfast"
                                    ? ColorsApp.PKColor
                                    : ColorsApp.fontGrey,
                              )),
                          backgroundColor:
                              recipeController.selectedUserValue['mealType'] ==
                                      "breakfast"
                                  ? ColorsApp.chips
                                  : ColorsApp.lightGrey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          recipeController.selectedUserValueUpdate(
                              'mealType', 'lunch');
                        },
                        child: Chip(
                          label: Text(TextApp.lunch,
                              style: TextStyle(
                                fontSize: 16,
                                color: recipeController
                                            .selectedUserValue['mealType'] ==
                                        "lunch"
                                    ? ColorsApp.PKColor
                                    : ColorsApp.fontGrey,
                              )),
                          backgroundColor:
                              recipeController.selectedUserValue['mealType'] ==
                                      "lunch"
                                  ? ColorsApp.chips
                                  : ColorsApp.lightGrey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          recipeController.selectedUserValueUpdate(
                              'mealType', 'dinner');
                        },
                        child: Chip(
                          label: Text(TextApp.dinner,
                              style: TextStyle(
                                fontSize: 16,
                                color: recipeController
                                            .selectedUserValue['mealType'] ==
                                        "dinner"
                                    ? ColorsApp.PKColor
                                    : ColorsApp.fontGrey,
                              )),
                          backgroundColor:
                              recipeController.selectedUserValue['mealType'] ==
                                      "dinner"
                                  ? ColorsApp.chips
                                  : ColorsApp.lightGrey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  TextApp.servingFilter,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Slider(
                  label: recipeController.servingValue.toString(),
                  divisions: 10,
                  min: 0.0,
                  max: 20.0,
                  value: recipeController.servingValue,
                  onChanged: (value) {
                    //  setState(() {
                    recipeController.updateServingValue(value);
                    recipeController.selectedUserValueUpdate(
                        'serving', recipeController.servingValue);
                    //    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  TextApp.prepTime,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Slider(
                  label: recipeController.prepTimeValue.toString(),
                  divisions: 100,
                  min: 0.0,
                  max: 200.0,
                  value: recipeController.prepTimeValue,
                  onChanged: (value) {
                      recipeController.updateprepTimeValue(value);
                      recipeController.selectedUserValueUpdate(
                          'prepTime', recipeController.prepTimeValue);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  TextApp.calories,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Slider(
                  label: recipeController.caloriesValue.toString(),
                  divisions: 1000,
                  min: 0.0,
                  max: 1000.0,
                  value: recipeController.caloriesValue,
                  onChanged: (value) {
                      recipeController.updatecaloriesValue(value);
                      recipeController.selectedUserValueUpdate(
                          'calories', recipeController.caloriesValue);
                  },
                ),
                 SizedBox(
                  height: context.screenHeight*0.2,
                ),
                SizedBox(
                    width: context.screenWidth - 50,
                    height: 60,
                    child: CustomButton(
                      bgColor: ColorsApp.PKColor,
                      textColor: ColorsApp.whiteColor,
                      title: TextApp.apply,
                      onPress: () async {
                        await recipeController.getFilteredResult();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilteredRecipesScreen(
                                    filteredRecipes:
                                        recipeController.filteredRecipes)));

                        //authController.signIn(context);
                      },
                    )),
              ],
            );
          }),
        ),
      ),
    );
  }
}
