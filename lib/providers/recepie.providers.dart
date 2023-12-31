import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeController extends ChangeNotifier {
  List<Recipe> recipesLists = [];
  List<Recipe> recommendedList = [];

  void getRecipes() async {
    var recipesData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
    recipesLists = dataDecoded.map((e) => Recipe.fromJson(e)).toList();
  
    notifyListeners();
  }

  void getRecommendedRecipes() async {
    var recipesData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
    recipesLists = dataDecoded.map((e) => Recipe.fromJson(e)).toList();
    recommendedList= recipesLists.where((e) => e.recommended == true).toList();
    notifyListeners();
  }
}
