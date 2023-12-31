import 'package:daily_recipe/consts/consts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/providers/home.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/fresh_recipes.widget.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatefulWidget {
  HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: CustomAppBar(
              leadingIcon: Icons.menu,
              actionIcon: Icons.notification_add_outlined,
              onPressLeading: () {},
              onPressAction: () {})),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                child: Column(
              children: [
                Consumer<AuthController>(
                    builder: (context, authController, child) {
                  String? name = authController.prefsFile!.getString('name');
                  return Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${bonjour}, ${name}',
                          style: TextStyle(fontSize: 20, color: fontGrey)));
                }),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    whatToCook,
                    style: TextStyle(fontFamily: bold, fontSize: 25),
                  ),
                ),
                SizedBox(
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
                            color: lightGrey,
                          ),
                          child: TextFormField(
                            cursorColor: borderLine,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: borderLine,
                                ),
                                filled: true,
                                fillColor: lightGrey,
                                hintText: searchAnyThing,
                                hintStyle: TextStyle(color: borderLine)),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 60,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.tune,
                            //  size: 25,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: lightGrey),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<HomeController>(
                    builder: (context, homeController, child) {
                  homeController.getAds();
                  if (homeController.adsLists.isEmpty) {
                    return CircularProgressIndicator();
                  } else {
                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Positioned(
                          child: Column(
                            children: [
                              CarouselSlider.builder(
                                  //  key: key,
                                  carouselController:
                                      homeController.carouselControllerEx,
                                  options: CarouselOptions(
                                      autoPlay: true,
                                      height: 200,
                                      viewportFraction: .75,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.height,
                                      enlargeCenterPage: true,
                                      onPageChanged: (index, _) {
                                        homeController.onSliderChanged(
                                            index, _);
                                      },
                                      enlargeFactor: .3),
                                  itemCount: homeController.adsLists.length,
                                  itemBuilder: (BuildContext, index, int) =>
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      homeController
                                                          .adsLists[index]
                                                          .image!),
                                                  fit: BoxFit.fill,
                                                )),
                                            margin: EdgeInsets.all(10),
                                          
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              color: Colors.black38,
                                              //height: 20,
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                homeController
                                                    .adsLists[index].title!,
                                                style: TextStyle(
                                                    fontFamily: bold,
                                                    color: whiteColor),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                              const SizedBox(
                                height: 10,
                              ),
                              DotsIndicator(
                                dotsCount: homeController.adsLists.length,
                                position: homeController.sliderIndex,
                                onTap: (position) async {
                                  await homeController.dotsIndicator(position);
                                },
                                decorator: DotsDecorator(
                                  size: const Size.square(9.0),
                                  activeSize: const Size(18.0, 9.0),
                                  activeColor: PKColor,
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: homeController.showNext,
                          child: Container(
                            height: 40,
                            width: 40,
                            color: lightGrey.withOpacity(0.5),
                            child: IconButton(
                              onPressed: () {
                                homeController.previousSlider();
                              },
                              icon: const Icon(
                                Icons.navigate_before,
                                size: 25,
                                color: PKColor,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: context.screenWidth - 80,
                          child: Visibility(
                            visible: homeController.showPrev,
                            child: Container(
                              height: 40,
                              width: 40,
                              color: lightGrey.withOpacity(0.5),
                              child: IconButton(
                                onPressed: () {
                                  homeController.nextSlider();
                                },
                                icon: const Icon(Icons.navigate_next,
                                    size: 30, color: PKColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
                const SizedBox(
                  height: 10,
                ),
                Consumer<RecipeController>(
                    builder: (context, recipeController, child) {
                  recipeController.getRecipes();
                  recipeController.getRecommendedRecipes();
                  if (recipeController.recipesLists.isEmpty) {
                    return CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Today\'s Fresh Recipes',
                                style:
                                    TextStyle(fontFamily: bold, fontSize: 20),
                              ),
                            ),
                            Text(
                              'See all',
                              style: TextStyle(color: PKColor, fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                recipeController.recipesLists.length,
                                (index) => FreshRecipes(
                                    id: recipeController.recipesLists[index].id,
                                    title: recipeController
                                        .recipesLists[index].title!,
                                    image: recipeController
                                        .recipesLists[index].image,
                                    meal_type: recipeController
                                        .recipesLists[index].meal_type,
                                    rating: recipeController
                                        .recipesLists[index].rating,
                                    calerios: recipeController
                                        .recipesLists[index].calerios,
                                    serving: recipeController
                                        .recipesLists[index].serving,
                                    prep_time: recipeController
                                        .recipesLists[index].prep_time,
                                        recommended: false,)),
                          ),
                        ),
                        Divider(),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Recommended',
                                style:
                                    TextStyle(fontFamily: bold, fontSize: 20),
                              ),
                            ),
                            Text(
                              'See all',
                              style: TextStyle(color: PKColor, fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                          recipeController.recommendedList.isEmpty?
                    CircularProgressIndicator():
                        Column(
                            children: List.generate(
                                recipeController.recommendedList.length,
                                (index) => FreshRecipes(
                                    id: recipeController.recommendedList[index].id,
                                    title: recipeController
                                        .recommendedList[index].title!,
                                    image: recipeController
                                        .recommendedList[index].image,
                                    meal_type: recipeController
                                        .recommendedList[index].meal_type,
                                    rating: recipeController
                                        .recommendedList[index].rating,
                                    calerios: recipeController
                                        .recommendedList[index].calerios,
                                    serving: recipeController
                                        .recommendedList[index].serving,
                                    prep_time: recipeController
                                        .recommendedList[index].prep_time,
                                        recommended: true)),
                          ),
                      ],
                    );
                  }
                })
              ],
            )),
          ),
        ),
      ),
    );
  }
}
