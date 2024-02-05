import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/consts/toastStatus.dart';
import 'package:daily_recipe/models/ingredient.model.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:daily_recipe/reuseable_function/toast.function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:overlay_kit/overlay_kit.dart';

class RecipeController extends ChangeNotifier {
  List<Recipe> _recommendedList = [];
  List<Recipe> _recipesList = [];
  List<Recipe> _favoriteList = [];
  List<Recipe> _viewedList = [];
  List<Recipe> _foundRecipes = [];
  List<Recipe> filteredRecipes = [];
  List<Ingredient> _ingredientsUserList = [];
  Recipe _recipeDetails = Recipe();
  double servingValue = 0;
  double prepTimeValue = 0;
  double caloriesValue = 0;

  List<Recipe>? get recipesList => _recipesList;
  List<Recipe>? get recommendedList => _recommendedList;
  List<Recipe>? get favoriteList => _favoriteList;
  List<Recipe>? get viewedList => _viewedList;
  List<Recipe>? get foundRecipes => _foundRecipes;
  List<Ingredient>? get ingredientsUserList => _ingredientsUserList;
  Recipe get recipeDetails => _recipeDetails;

  bool? isAdd;

  void initFavorite() async {
    getFavoriteRecipes();
//    _foundRecipes = _favoriteList;
  }

  void disposeFoundRecipes() async {
    _foundRecipes = [];
  }



  void disposeFilter() async {
    servingValue = 0;
    prepTimeValue = 0;
    caloriesValue = 0;
  }

  void disposeRecentlyViewed() async {
    _foundRecipes = [];
  }

  void updateServingValue(value) {
    servingValue = value;
    notifyListeners();
  }

  void updateprepTimeValue(value) {
    prepTimeValue = value;
    notifyListeners();
  }

  void updatecaloriesValue(value) {
    caloriesValue = value;
    notifyListeners();
  }

  // void updateServingValue() async {
  //   _foundRecipes = [];
  // }

  var selectedUserValue = {};
  // Recipe? openedRecipe = Recipe();
  // var selectedUserValue = {
  //   'mealType': 'dinner'/*,
  //   'serving': 4,
  //   'prepTime': 45,
  //   'calerios': 352,*/
  // };
  //var selectedUserValue = {"mealType": 'dinner', "serving": 4};

//  var value = {"type": "breakfast", "serving": 4, "total_time": 20};

  Future<void> getFilteredResult() async {
    var ref = FirebaseFirestore.instance.collection('recipes');
    // print(selectedUserValue["mealType"]);
    // for (var entry in selectedUserValue.entries) {
    //   print(selectedUserValue.entries);
    //   print(entry.key);
    //   print(entry.value);
    //   ref.where(entry.key, isEqualTo: entry.value).get();
    // }
    try {
      //  var result = await ref
      //       .where(Filter.and(
      //           Filter('mealType',
      //               isEqualTo: 'dinner' /* selectedUserValue['mealType']*/),
      //           Filter('serving',
      //               isGreaterThanOrEqualTo: selectedUserValue['servingStart']),
      //         // Filter('serving',
      //         //       isLessThanOrEqualTo: selectedUserValue['servingEnd']),
      //           /*,isLessThanOrEqualTo: selectedUserValue["servingEnd"]*/ /*,[*/
      //          Filter('prepTime',
      //               isGreaterThanOrEqualTo: selectedUserValue['prepTimeStart']),
      // Filter('prepTime',
      //     isLessThanOrEqualTo: selectedUserValue["prepTimeEnd"]),*/
      // Filter('calerios',
      //     isGreaterThanOrEqualTo: selectedUserValue['caleriosStart']),
      // Filter('calerios',
      //     isLessThanOrEqualTo: selectedUserValue["caleriosEnd"])

      /*  ] /*as Filter?*/
              /*,
      Filter('prepTime',
          isGreaterThanOrEqualTo: selectedUserValue['prepTimeStart'],isLessThanOrEqualTo: selectedUserValue["prepTimeEnd"]),
      Filter('calerios',
          isGreaterThanOrEqualTo: selectedUserValue['caleriosStart']),
      Filter('calerios',
          isLessThanOrEqualTo: selectedUserValue["caleriosEnd"]),*/
     ))*/
      //     ))
      // .get();

      /*    var query =
          ref.where('mealType', isEqualTo: selectedUserValue['mealType']);
      var query1 = query.where('serving',
          isGreaterThanOrEqualTo: selectedUserValue['servingStart']); 
     var query2 = query1.where('serving',
          isLessThanOrEqualTo: selectedUserValue["servingEnd"]);
   var query3 = query2.where('prepTime',
          isGreaterThanOrEqualTo: selectedUserValue['prepTimeStart']); */ /*
    var query4 = query3.where('prepTime',
          isLessThanOrEqualTo: selectedUserValue["prepTimeEnd"]);*/ /*
      var reff3 = reff2.where('calerios',
          isGreaterThanOrEqualTo: selectedUserValue['caleriosEnd'],
          isLessThanOrEqualTo: selectedUserValue["caleriosEnd"]);
      var reff4 = reff3.where('serving',
          isGreaterThanOrEqualTo: selectedUserValue["servingStart"],
          isLessThanOrEqualTo: selectedUserValue["servingEnd"]);
      var reff5 =
          reff4.where('prepTime', isEqualTo: selectedUserValue["prepTime"]);

      /*    ref
          .where('mealType', isEqualTo: selectedUserValue['mealType'])
          .where('serving',
              isGreaterThanOrEqualTo: selectedUserValue['servingEnd'],
              isLessThanOrEqualTo: selectedUserValue["servingEnd"])
          .where('prepTime',
              isGreaterThanOrEqualTo: selectedUserValue['prepTimeEnd'],
              isLessThanOrEqualTo: selectedUserValue["prepTimeEnd"])
          .where('calerios',
              isGreaterThanOrEqualTo: selectedUserValue['caleriosEnd'],
              isLessThanOrEqualTo: selectedUserValue["caleriosEnd"])
          .where('serving',
              isGreaterThanOrEqualTo: selectedUserValue["servingStart"],
              isLessThanOrEqualTo: selectedUserValue["servingEnd"])
          .where('prepTime', isEqualTo: selectedUserValue["prepTime"]);*/*/
      var result = await ref
          .where('mealType', isEqualTo: selectedUserValue['mealType'])
          .where('serving', isEqualTo: selectedUserValue['serving'])
          .where('prepTime', isEqualTo: selectedUserValue['prepTime'])
          .where('calerios', isEqualTo: selectedUserValue['calories'])
          .get();
      print(result.docs);

      if (result.docs.isNotEmpty) {
        filteredRecipes = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        filteredRecipes = [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  selectedUserValueUpdate(String key, dynamic value) {
    //  selectedUserValue.update(key, value);
    selectedUserValue.update(key, (v) => value, ifAbsent: () => value);
    notifyListeners();
  //  print(selectedUserValue.toString());
  }

  Future<void> getOpenedRecipe(recipeId) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .get();
      if (result.data() != null) {
        _recipeDetails = Recipe.fromJson(result.data()!, result.id);
      } else {
        return;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void getAllRecipes() async {
    try {
      var result =
          await FirebaseFirestore.instance.collection('recipes').limit(6).get();
      if (result.docs.isNotEmpty) {
        _recipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _recipesList = [];
      notifyListeners();
      print(e.toString());
    }
  }

  void getRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isFresh', isEqualTo: true)
          .limit(6)
          .get();
      var recommendedResult = await FirebaseFirestore.instance
          .collection('recipes')
          .where('recommended', isEqualTo: true)
          .limit(9)
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
        _foundRecipes = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _favoriteList = [];
        _foundRecipes = [];
      }
      notifyListeners();
    } catch (e) {
      _favoriteList = [];
      _foundRecipes = [];

      notifyListeners();
      print(e.toString());
    }
  }

  Future<void> getViewedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('viewers_ids',
              arrayContains: FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (result.docs.isNotEmpty) {
        _viewedList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
        _foundRecipes = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _viewedList = [];
        _foundRecipes = [];
      }
      notifyListeners();
    } catch (e) {
      _viewedList = [];
      _foundRecipes = [];

      notifyListeners();
      print(e.toString());
    }
  }

  // Future<void> getRecipeById(id) async {
  //   try {
  //     var result = await FirebaseFirestore.instance
  //         .collection('recipes')
  //         .where('id', isEqualTo: id.toString())
  //         .get();
  //     if (result.docs.isNotEmpty) {
  //       _recipeDetails = List<Recipe>.from(
  //           result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
  //     } else {
  //       _recipeDetails = [];
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     _recipesList = [];
  //     notifyListeners();
  //     print(e.toString());
  //   }
  // }

  Future<void> addViewedRecipe(String recipeId, isAdd) async {
    try {
      if (!isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "viewers_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        return;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addViewedRecipeByUserId(Recipe recipeDetails) {
    isAdd = recipeDetails.viewerId
        ?.contains(FirebaseAuth.instance.currentUser?.uid);
    addViewedRecipe(recipeDetails.docId!, isAdd);
  }

  Future<void> removeViewedRecipe(String recipeId, BuildContext context) async {
    try {
      OverlayLoadingProgress.start();

      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .update({
        "viewers_ids":
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
      });
      if (context.mounted) {
        ShowToastMessage.showToast(context, TextApp.removeViewedrecipe, 3000,
            ToastMessageStatus.success);
      }
      getViewedRecipes();

      OverlayLoadingProgress.stop();

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  // bool? isViewedRecipeById(Recipe recipeDetails) {
  //   isAdd =
  //       recipeDetails.viewerId?.contains(FirebaseAuth.instance.currentUser?.uid);
  //   return isAdd;
  // }

  // check isfavorite from recipeDetailsScreen
  void addFavoriteMethodById(
      Recipe recipeDetails, BuildContext context, String screen) {
    isAdd =
        recipeDetails.fanId?.contains(FirebaseAuth.instance.currentUser?.uid);
    addFavoriteToUser(recipeDetails.docId!, isAdd, context, screen);
  }
//to call favorite value in ui to toggle favorite icon

  bool? isFavoriteById(Recipe recipeDetails) {
    isAdd =
        recipeDetails.fanId?.contains(FirebaseAuth.instance.currentUser?.uid);
    return isAdd;
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
      if (screen == AppRoutes.recipeDetailsScreen) {
        getOpenedRecipe(recipeId);
      } else if (screen == AppRoutes.favoriteRecipesScreen) {
        getFavoriteRecipes();
      } else {
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
/*
// check isfavorite from lists of homePageScreen,ViewedRecipesScreen,favoritesScreen and recentlyViewedScreen
  void addFavoriteMethod(int index, BuildContext context, String screen) {
    isAdd = isFavorite(index);
    addFavoriteToUser(_recipesList[index].docId!, isAdd, context, screen);
  }
//to call favorite value in ui to toggle favorite icon
  bool? isFavorite(int index) {
    isAdd = _recipesList[index]
        .fanId
        ?.contains(FirebaseAuth.instance.currentUser?.uid);
    return isAdd;
  }
*/

  Future<void> getUserIngredients() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('ingredients')
          .where('users_ids',
              arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (result.docs.isNotEmpty) {
        _ingredientsUserList = List<Ingredient>.from(
            result.docs.map((doc) => Ingredient.fromJson(doc.data(), doc.id)));

        // var userIngredientsTitles =
        //     _ingredientsUserList.map((e) => e.name).toList();
      } else {
        _ingredientsUserList = [];
      }
      notifyListeners();
    } catch (e) {
      _ingredientsUserList = [];
      notifyListeners();
      print(e.toString());
    }
  }

  Widget checkIngredientWidget(dynamic recipeIngredient) {
    // print('recipeIngredient');
    // print(recipeIngredient);

    //print('ingredientsUser');
    var userIngredientsTitles =
        _ingredientsUserList.map((e) => e.name).toList();
    bool isExsist = false;
    for (var userIngredientsTitle in userIngredientsTitles) {
      if (recipeIngredient.contains(userIngredientsTitle)) {
        isExsist = true;
        //ingredientsTitle(userIngredientsTitle,Icons.check, ColorsApp.PKColor);
        break;
      } else {
        isExsist = false;
        //  ingredientsTitle(userIngredientsTitle,Icons.close, ColorsApp.PKColor);
      }
    }

    if (isExsist) {
      return const Icon(Icons.check, color: ColorsApp.PKColor);
    } else {
      return const Icon(Icons.close);
    }
  }

  void runFilter(String? value) {
    List<Recipe> results = [];

    if (value!.isEmpty) {
      results = _favoriteList;
    } else {
      results = _favoriteList
          .where((e) => e.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      _foundRecipes.forEach((e) {
        print(e.title);
      });
    }

    _foundRecipes = results;
    notifyListeners();
  }

  // void addFavoriteMethodById(
  //     List recipeDetailList, BuildContext context, String screen) {
  //   isAdd = recipeDetailList[0]
  //       .fanId
  //       ?.contains(FirebaseAuth.instance.currentUser?.uid);
  //   addFavoriteToUser(recipeDetailList[0].docId!, isAdd, context, screen);
  // }

  // bool? isFavoriteById(List recipeDetailList) {
  //   isAdd = recipeDetailList[0]
  //       .fanId
  //       ?.contains(FirebaseAuth.instance.currentUser?.uid);
  //   //print(isAdd);
  //   return isAdd;
  // }
}
