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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).filter,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).meals,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
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
                            if (recipeController.isArabic()) {
                            recipeController.selectedUserValueUpdate(
                              'mealType', 'فطار');
                          } else {
                          recipeController.selectedUserValueUpdate(
                              'mealType', 'breakfast');
                          }
                        
                        },
                        child: Chip(
                          label: Text(S.of(context).breakfast,
                              style: TextStyle(
                                fontSize: 16,
                                color: recipeController
                                            .selectedUserValue['mealType'] ==
                                        "breakfast"|| recipeController
                                            .selectedUserValue['mealType'] ==
                                        "فطار"
                                    ? ColorsApp.PKColor
                                    : ColorsApp.fontGrey,
                              )),
                          backgroundColor:
                              recipeController.selectedUserValue['mealType'] ==
                                      "breakfast"|| recipeController
                                            .selectedUserValue['mealType'] ==
                                        "فطار"
                                  ? ColorsApp.chips
                                  : ColorsApp.lightGrey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                            if (recipeController.isArabic()) {
                            recipeController.selectedUserValueUpdate(
                              'mealType', 'غداء');
                          } else {
                          recipeController.selectedUserValueUpdate(
                              'mealType', 'lunch');
                          }
                          
                        },
                        child: Chip(
                          label: Text(S.of(context).lunch,
                              style: TextStyle(
                                fontSize: 16,
                                color: recipeController
                                            .selectedUserValue['mealType'] ==
                                        "lunch"|| recipeController
                                            .selectedUserValue['mealType'] ==
                                        "غداء"
                                    ? ColorsApp.PKColor
                                    : ColorsApp.fontGrey,
                              )),
                          backgroundColor:
                              recipeController.selectedUserValue['mealType'] ==
                                      "lunch"|| recipeController
                                            .selectedUserValue['mealType'] ==
                                        "غداء"
                                  ? ColorsApp.chips
                                  : ColorsApp.lightGrey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (recipeController.isArabic()) {
                            recipeController.selectedUserValueUpdate(
                              'mealType', 'عشاء');
                          } else {
                            recipeController.selectedUserValueUpdate(
                              'mealType', 'dinner');
                          }
                          
                        },
                        child: Chip(
                          label: Text(S.of(context).dinner,
                              style: TextStyle(
                                fontSize: 16,
                                color: recipeController
                                            .selectedUserValue['mealType'] ==
                                        "dinner"|| recipeController
                                            .selectedUserValue['mealType'] ==
                                        "عشاء"
                                    ? ColorsApp.PKColor
                                    : ColorsApp.fontGrey,
                              )),
                          backgroundColor:
                              recipeController.selectedUserValue['mealType'] ==
                                      "dinner"|| recipeController
                                            .selectedUserValue['mealType'] ==
                                        "عشاء"
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
                Text(
                  S.of(context).servingFilter,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
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
                    recipeController.updateServingValue(value);
                    recipeController.selectedUserValueUpdate(
                        'serving', recipeController.servingValue);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).prepTime,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
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
                Text(
                  S.of(context).calories,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                RangeSlider(
                  min: 0,
                  max: 1000,
                  divisions: 20, //slide interval
                  labels: RangeLabels(
                      recipeController.currentRangeValues.start
                          .round()
                          .toString(),
                      recipeController.currentRangeValues.end
                          .round()
                          .toString()),
                  values: recipeController.currentRangeValues,
                  onChanged: (RangeValues value) {
                    // setState(() {
                    //     startval = value.start;
                    //     endval = value.end;
                    //  recipeController.updatecaloriesStartval(value);
                    // recipeController.updatecaloriesEndval(value);
                    recipeController.updatecaloriesValue(value);
                    recipeController.selectedUserValueUpdate('caloriesStartval',
                        recipeController.currentRangeValues.start.round());
                    recipeController.selectedUserValueUpdate('caloriesEndval',
                        recipeController.currentRangeValues.end.round());
                    //  });
                  },
                ),
                // Slider(
                //   label: recipeController.caloriesValue.toString(),
                //   divisions: 1000,
                //   min: 0.0,
                //   max: 1000.0,
                //   value: recipeController.caloriesValue,
                //   onChanged: (value) {
                //       recipeController.updatecaloriesValue(value);
                //       recipeController.selectedUserValueUpdate(
                //           'calories', recipeController.caloriesValue);
                //   },
                // ),
                SizedBox(
                  height: context.screenHeight * 0.1,
                ),
                SizedBox(
                    width: context.screenWidth - 50,
                    height: 60,
                    child: CustomButton(
                      bgColor: ColorsApp.PKColor,
                      textColor: ColorsApp.whiteColor,
                      title: S.of(context).apply,
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
