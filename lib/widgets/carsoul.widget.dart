import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/home.providers.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsoulWidget extends StatefulWidget {
  const CarsoulWidget({super.key});

  @override
  State<CarsoulWidget> createState() => _CarsoulWidgetState();
}

class _CarsoulWidgetState extends State<CarsoulWidget> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Provider.of<HomeController>(context, listen: false).getAds();
    Provider.of<HomeController>(context, listen: false).initCarousal();
  }

  // @override
  // void dispose() async {
  //   Provider.of<HomeController>(context, listen: false).disposeCarousal();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeController, child) {
      homeController.getAds();
      if(homeController.adsList == null){
      return const CircularProgressIndicator();
      }else if (homeController.adsList!.isEmpty ?? false) {
        return const Text('No Data Found');
      } else {
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              child: Column(
                children: [
                  CarouselSlider.builder(
                      //  key: key,
                      carouselController: homeController.carouselControllerEx,
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 200,
                          viewportFraction: .75,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                          onPageChanged: (index, _) {
                            homeController.onSliderChanged(index, _);
                          },
                          enlargeFactor: .3),
                      itemCount: homeController.adsList!.length,
                      itemBuilder: (BuildContext, index, int) => Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: NetworkImage(homeController
                                          .adsList![index].image!),
                                      fit: BoxFit.fill,
                                    )),
                                margin: const EdgeInsets.all(10),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  color: Colors.black38,
                                  //height: 20,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    homeController.adsList![index].title!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: ColorsApp.whiteColor),
                                  ),
                                ),
                              )
                            ],
                          )),
                  const SizedBox(
                    height: 10,
                  ),
                  DotsIndicator(
                    dotsCount: homeController.adsList!.length,
                    position: homeController.sliderIndex,
                    onTap: (position) async {
                      await homeController.dotsIndicator(position);
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
              visible: homeController.showNext,
              child: Container(
                height: 40,
                width: 40,
                color: ColorsApp.lightGrey.withOpacity(0.5),
                child: IconButton(
                  onPressed: () {
                    homeController.previousSlider();
                  },
                  icon: const Icon(
                    Icons.navigate_before,
                    size: 25,
                    color: ColorsApp.PKColor,
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
                  color: ColorsApp.lightGrey.withOpacity(0.5),
                  child: IconButton(
                    onPressed: () {
                      homeController.nextSlider();
                    },
                    icon: const Icon(Icons.navigate_next,
                        size: 30, color: ColorsApp.PKColor),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
