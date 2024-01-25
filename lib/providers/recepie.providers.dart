import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/consts/toastStatus.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:daily_recipe/reuseable_function/toast.function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:overlay_kit/overlay_kit.dart';

class RecipeController extends ChangeNotifier {
  List<Recipe> _recommendedList = [];
  List<Recipe>? _recipeDetails = [];
  List<Recipe> _recipesList = [];
  List<Recipe> _favoriteList = [];

  List<Recipe>? get recipesList => _recipesList;
  List<Recipe>? get recommendedList => _recommendedList;
  List<Recipe>? get recipeDetails => _recipeDetails;
  List<Recipe>? get favoriteList => _favoriteList;

  bool? isAdd;

  void getRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();
      var recommendedResult = await FirebaseFirestore.instance
          .collection('recipes')
          .where('recommended', isEqualTo: true)
          .get();
      if (result.docs.isNotEmpty) {
        _recipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recipesList = [];
      }
      if (recommendedResult.docs.isNotEmpty) {
        _recommendedList = List<Recipe>.from(recommendedResult.docs
            .map((doc) => Recipe.fromJson(doc.data(), doc.id)));
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

  Future<void> getFavoriteRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('fans_ids',
              arrayContains: FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (result.docs.isNotEmpty) {
        _favoriteList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _favoriteList = [];
      }
      notifyListeners();
    } catch (e) {
      _favoriteList = [];
      notifyListeners();
      print(e.toString());
    }
  }

  Future<void> getRecipeById(id) async {
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

  Future<void> addFavoriteToUser(
      String recipeId, isAdd, BuildContext context, String screen) async {
    try {
      OverlayLoadingProgress.start();
      if (!isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "fans_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
        if (context.mounted) {
          ShowToastMessage.showToast(
              context, TextApp.addFavorite, 3000, ToastMessageStatus.success);
        }
        notifyListeners();
      } else {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "fans_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
        if (context.mounted) {
          ShowToastMessage.showToast(context, TextApp.removeFavorite, 3000,
              ToastMessageStatus.success);
        }
        notifyListeners();
      }
      OverlayLoadingProgress.stop();
      if(screen == AppRoutes.recipeDetailsScreen){
        getRecipeById(recipeId);
      }else if(screen == AppRoutes.favoriteRecipesScreen){
        getFavoriteRecipes();
      }else{
        getRecipes();
      }
      notifyListeners();
    } catch (e) {
      OverlayLoadingProgress.stop();
      print(e.toString());
      if (context.mounted) {
        ShowToastMessage.showToast(
            context, TextApp.error, 3000, ToastMessageStatus.failed);
      }
    }
  }

  void addFavoriteMethod(int index, BuildContext context, String screen) {
    isAdd = isFavorite(index);
    addFavoriteToUser(_recipesList[index].docId!, isAdd, context, screen);
  }

  bool? isFavorite(int index) {
    isAdd = _recipesList[index]
        .fanId
        ?.contains(FirebaseAuth.instance.currentUser?.uid);
    return isAdd;
  }

  void addFavoriteMethodById(
      List recipeDetailList, BuildContext context, String screen) {
    isAdd = recipeDetailList[0]
        .fanId
        ?.contains(FirebaseAuth.instance.currentUser?.uid);
    addFavoriteToUser(recipeDetailList[0].docId!, isAdd, context, screen);
  }

  bool? isFavoriteById(List recipeDetailList) {
    isAdd = recipeDetailList[0]
        .fanId
        ?.contains(FirebaseAuth.instance.currentUser?.uid);
    //print(isAdd);
    return isAdd;
  }
}
