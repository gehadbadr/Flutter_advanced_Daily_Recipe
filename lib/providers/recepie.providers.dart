import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class RecipeController extends ChangeNotifier {
  List<Recipe> _recommendedList = [];
  List<Recipe> _recipeDetails = [];
  List<Recipe> _recipesList = [];

  List<Recipe>? get recipesList => _recipesList;
  List<Recipe>? get recommendedList => _recommendedList;
  List<Recipe>? get recipeDetails => _recipeDetails;

  void getRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();
      var recommendedResult = await FirebaseFirestore.instance
          .collection('recipes')
          .where('recommended', isEqualTo: true)
          .get();
      if (recommendedResult.docs.isNotEmpty) {
        _recipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recipesList = [];
      }
      if (result.docs.isNotEmpty) {
        _recommendedList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recommendedList = [];
      }
      notifyListeners();
    } catch (e) {
      _recipesList = [];
      notifyListeners();
      print(e.toString());
    }
  }

  void getRecipeById(id) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('id', isEqualTo: id.toString())
          .get();
      if (result.docs.isNotEmpty) {
  

        _recipeDetails = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recipeDetails = [];
      }
      notifyListeners();
    } catch (e) {
      _recipesList = [];
      notifyListeners();
      print(e.toString());
    }
  }

  // void getRecipes() async {
  //   var recipesData = await rootBundle.loadString('assets/data/sample.json');
  //   var dataDecoded =
  //       List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
  //   recipesLists = dataDecoded.map((e) => Recipe.fromJson(e)).toList();
  //   recommendedList = recipesLists.where((e) => e.recommended == true).toList();
  //   notifyListeners();
  // }

  // void getRecipeById(id) async {
  //   if (id != null) {
  //     var recipesData = await rootBundle.loadString('assets/data/sample.json');
  //     var dataDecoded =
  //         List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
  //     recipeDetails = recipesList.where((e) => e.id == id).toList();
  //     notifyListeners();
  //   }
  // }
}
