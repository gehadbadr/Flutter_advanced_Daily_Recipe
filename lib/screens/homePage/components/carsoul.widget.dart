import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/home.providers.dart';
import 'package:daily_recipe/providers/lang.providers.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsoulWidget extends StatefulWidget {
  const CarsoulWidget({super.key});

  @override
  State<CarsoulWidget> createState() => _CarsoulWidgetState();
}

class _CarsoulWidgetState extends State<CarsoulWidget> {
  bool isArabic = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Provider.of<HomeController>(context, listen: false).getAds();
    Provider.of<HomeController>(context, listen: false).initCarousal();
    isArabic = Provider.of<LangController>(context, listen: false).isArabic();
  }

  // @override
  // void dispose() async {
  //   Provider.of<HomeController>(context, listen: false).disposeCarousal();
  //   super.dispose();
  // }

  @override
  void deactivate() {
    Provider.of<HomeController>(context, listen: false).disposeCarousal();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeController, child) {
      homeController.getAds();
      if (homeController.adsList == null) {
        return const CircularProgressIndicator();
      } else if (homeController.adsList!.isEmpty /*?? false*/) {
        return Text(S.of(context).noDataFound);
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
                      itemBuilder: (context, index, int) => Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        homeController.adsList![index].image!,
                                    //  placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
                    !isArabic
                        ? homeController.previousSlider()
                        : homeController.nextSlider();
                  },
                  icon: !isArabic
                      ? const Icon(Icons.navigate_before,
                          size: 30, color: ColorsApp.PKColor)
                      : const Icon(Icons.navigate_next,
                          size: 30, color: ColorsApp.PKColor),
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
                      !isArabic
                          ? homeController.nextSlider()
                          : homeController.previousSlider();
                    },
                    icon: !isArabic
                        ? const Icon(Icons.navigate_next,
                            size: 30, color: ColorsApp.PKColor)
                        : const Icon(Icons.navigate_before,
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
