import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  List list = sliderList;
  int sliderIndex = 0;
  CarouselController carouselControllerEx = CarouselController();
  bool showNext = false;
  bool showPrev = false;

  onSliderChanged(index, _) {
    sliderIndex = index;
    if (sliderIndex != list.length - 1) {
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
