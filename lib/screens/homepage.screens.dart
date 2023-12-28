import 'package:daily_recipe/consts/consts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/providers/home.providers.dart';
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
      appBar: AppBar(
          shadowColor: whiteColor,
          backgroundColor: whiteColor,
          foregroundColor: darkFontGrey,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notification_add_outlined,
                size: 25,
              ),
            ),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            //  physics:AlwaysScrollableScrollPhysics() ,
            child: Container(
                child: Column(
              children: [
                Consumer<AuthController>(
                    builder: (context, authController, child) {
                  String? name = authController.prefsFile!.getString('name');

                  return Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${bonjour},${name}',
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
                            Icons.shape_line_outlined,
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
                                      homeController.onSliderChanged(index, _);
                                    },
                                    enlargeFactor: .3),
                                itemCount: homeController.list.length,
                                itemBuilder: (BuildContext, index, int) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        //  boxShadow: List.filled(3,fill),
                                        border: Border.all(color: PKColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      margin: EdgeInsets.all(10),
                                      child: Center(
                                          child: Image.asset(
                                              homeController.list[index],
                                              fit: BoxFit.fill,
                                              width: double.infinity)),
                                    )),
                            const SizedBox(
                              height: 10,
                            ),
                            DotsIndicator(
                              dotsCount: homeController.list.length,
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
                              homeController.nextSlider();
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
                        left: context.screenWidth - 55,
                        child: Visibility(
                          visible: homeController.showPrev,
                          child: Container(
                            height: 40,
                            width: 40,
                            color: lightGrey.withOpacity(0.5),
                            child: IconButton(
                              onPressed: () {
                                homeController.previousSlider();
                              },
                              icon: const Icon(Icons.navigate_next,
                                  size: 30, color: PKColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today\'s Fresh Recipes',
                      style: TextStyle(fontFamily: bold, fontSize: 20),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(color: PKColor, fontSize: 16),
                    )
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
