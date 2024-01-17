import 'dart:convert';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeController extends ChangeNotifier {
  List<Recipe> recipesLists = [];
  List<Recipe> recommendedList = [];
  List<Recipe> recipeDetails = [];

  void getRecipes() async {
    var recipesData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
    recipesLists = dataDecoded.map((e) => Recipe.fromJson(e)).toList();
    recommendedList = recipesLists.where((e) => e.recommended == true).toList();
    notifyListeners();
  }

  void getRecipeById(id) async {
    if (id != null) {
      var recipesData = await rootBundle.loadString('assets/data/sample.json');
      var dataDecoded =
          List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
      recipeDetails = recipesLists.where((e) => e.id == id).toList();
      notifyListeners();
    }
  }

}
