
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/ad.models.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int sliderIndex = 0;
  CarouselController? carouselControllerEx;
  bool showNext = true;
  bool showPrev = true;
 List<Ad> _adsList = [];
//  List<Ad>? _adsList;

  List<Ad>? get adsList => _adsList;

  

  Future<void> getAds() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('ads')
          .where('isActive', isEqualTo: true)
          .limit(10)
          .get();
      if (result.docs.isNotEmpty) {
        _adsList = List<Ad>.from(
            result.docs.map((doc) => Ad.fromJson(doc.data(), doc.id)));
      } else {
        _adsList = [];
      }
      notifyListeners();
    } catch (e) {
      _adsList = [];
      notifyListeners();
      print(e.toString());

    }
  }

  void initCarousal() {
    carouselControllerEx = CarouselController();
  }

  void disposeCarousal() {
    carouselControllerEx = null;
    
  }

  onSliderChanged(index, _) {
    sliderIndex = index;
    // if (sliderIndex != adsList!.length - 1) {
    //   showNext = true;
    // } else {
    //  showNext = false;
    // }
    // if (sliderIndex > 0) {
    //   showPrev = true;
    // } else {
    //   showPrev = false;
    // }
    notifyListeners();
  }

  nextSlider() {
    carouselControllerEx?.nextPage();
  }

  previousSlider() {
    carouselControllerEx?.previousPage();
  }

  dotsIndicator(position) async {
    await carouselControllerEx?.animateToPage(position);
    sliderIndex = position;
    notifyListeners();
  }
}
