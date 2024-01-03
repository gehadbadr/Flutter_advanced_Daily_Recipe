import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/ad.models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeController extends ChangeNotifier {
  int sliderIndex = 0;
  CarouselController carouselControllerEx = CarouselController();
  bool showNext = false;
  bool showPrev = false;
  List<Ad> adsLists = [];

  void getAds() async {
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
      //  print(dataDecoded);
    adsLists = dataDecoded.map((e) => Ad.fromJson(e)).toList();

    notifyListeners();
  }

  onSliderChanged(index, _) {
    sliderIndex = index;
    if (sliderIndex != adsLists.length - 1) {
      showNext = true;
    } else {
      showNext = false;
    }
    if (sliderIndex > 0) {
      showPrev = true;
    } else {
      showPrev = false;
    }
    notifyListeners();
  }

  nextSlider() {
    carouselControllerEx.nextPage();
  }

  previousSlider() {
    carouselControllerEx.previousPage();
  }

  dotsIndicator(position) async {
    await carouselControllerEx.animateToPage(position);
    sliderIndex = position;
    notifyListeners();
  }
}
