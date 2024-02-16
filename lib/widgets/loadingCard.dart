import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/lang.providers.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListPage extends StatefulWidget {
  final int? viewType;

  const LoadingListPage({super.key, this.viewType});

  @override
  State<LoadingListPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  typeView(BuildContext context) {
    switch (widget.viewType) {
      case 0: //display recipes in vertical card.
        return freshRecipes(context);
      case 1: //display recipes in horizontal card.
        return recommendedRecipes(context);

      case 3: //display recipes in horizontal card with close in=con instead of favorite icon in RecentlyViewedScreen.
        return recommendedRecipes(context);
      case 4: //display recipes in vertical card change img size.
        return freshRecipes(context);
      case 5: //display recipes in horizontal card without favorite icon in FilteredRecipesScreen.
        return recommendedRecipes(context);
      case 6: //ingredients.
        return ingredients(context);
      case 7: //carsoul.
        return carsoul(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: typeView(context));
  }

  Widget freshRecipes(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(top: 10, right: 30, bottom: 10, left: 10),
      width: widget.viewType == 0 ? 200 : 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorsApp.lightGrey,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: ColorsApp.lightGrey,
            blurRadius: 5,
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                favoriteIcon(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: widget.viewType == 0
                      ? recipeImage(130, 130, context)
                      : recipeImage(context.screenWidth / 6, 90, context),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            info(),
            info(),
            info(),
            info(),
          ],
        ),
      ),
    );
  }

  //display recipes in vertical order
  Widget recommendedRecipes(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width < 300) {
      width = 350;
    } else {
      width = MediaQuery.of(context).size.width - 50;
    }
    return Stack(
      alignment: !Provider.of<LangController>(context, listen: false).isArabic()
          ? Alignment.topRight
          : Alignment.topLeft,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: width,
          decoration: BoxDecoration(
            color: ColorsApp.lightGrey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: ColorsApp.lightGrey,
                blurRadius: 5,
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Row(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: recipeImage(90, 50, context)),
                const SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      info(),
                      info(),
                      info(),
                      info(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.viewType == 3
              ? closeIcon()
              : widget.viewType == 5
                  ? Container()
                  : favoriteIcon(),
        )
      ],
    );
  }

  Widget ingredients(BuildContext context) {
    return  Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
      child: ListTile(
        leading: Checkbox(
        value: false,
            onChanged: (value) {
            }),
        title:
            info(),
      ),
    );
  }

  Widget carsoul(BuildContext context) {
    return  Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
    
      child:    Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              child: Column(
                children: [
                  CarouselSlider.builder(
                      //  key: key,
                      //carouselController: homeController.carouselControllerEx,
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 200,
                          viewportFraction: .75,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                          onPageChanged: (index, _) {
                          //  homeController.onSliderChanged(index, _);
                          },
                          enlargeFactor: .3),
                      itemCount: 4,
                      itemBuilder: (context, index, int) => Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color:ColorsApp.lightGrey
                                ),
                              ),
                              
                            ],
                          )),
                  const SizedBox(
                    height: 10,
                  ),
                  DotsIndicator(
                    dotsCount: 4,
                  //  position: homeController.sliderIndex,
                    onTap: (position) async {
                    },
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeColor: ColorsApp.PKColor,
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: true,
              child: Container(
                height: 40,
                width: 40,
                color: ColorsApp.lightGrey.withOpacity(0.5),
                child: IconButton(
                  onPressed: () {
                
                  },
                  icon: const Icon(Icons.navigate_next,
                          size: 30, color: ColorsApp.PKColor),
                ),
              ),
            ),
            Positioned(
              left: context.screenWidth - 80,
              child: Visibility(
                visible: true,
                child: Container(
                  height: 40,
                  width: 40,
                  color: ColorsApp.lightGrey.withOpacity(0.5),
                  child: IconButton(
                    onPressed: () {
                    
                    },
                    icon: const Icon(Icons.navigate_before,
                            size: 30, color: ColorsApp.PKColor),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget recipeImage(double width, double height, BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorsApp.darkFontGrey),
    );
  }

  Widget info() {
    return Column(
      children: [
        Container(
          height: 16,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ColorsApp.darkFontGrey),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget favoriteIcon() {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.favorite_outline,
          color: ColorsApp.borderLine,
        ));
  }

  Widget closeIcon() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.close,
          color: ColorsApp.fontGrey,
        ));
  }
}
