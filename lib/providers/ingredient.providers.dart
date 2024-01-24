import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/consts/toastStatus.dart';
import 'package:daily_recipe/models/ingredient.model.dart';
import 'package:daily_recipe/reuseable_function/toast.function.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:overlay_kit/overlay_kit.dart';

class IngredientController extends ChangeNotifier {
    List<Ingredient>? _ingredientsList;

  List<Ingredient>? get ingredientsList => _ingredientsList;

  Future<void> getIngredients() async {
    try {
      var result =
          await FirebaseFirestore.instance.collection('ingredients').get();

      if (result.docs.isNotEmpty) {
        _ingredientsList = List<Ingredient>.from(
            result.docs.map((doc) => Ingredient.fromJson(doc.data(), doc.id)));
      } else {
        _ingredientsList = [];
      }
      notifyListeners();
    } catch (e) {
      _ingredientsList = [];
      notifyListeners();
    }
  }

  Future<void> addIngredientToUser(String ingredientId, bool isAdd,BuildContext context) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredientId)
            .update({
          "users_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
        if (context.mounted) {
          ShowToastMessage.showToast(context, TextApp.addIngredient, 3000,
              ToastMessageStatus.success);
        }
      } else {
        await FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredientId)
            .update({
          "users_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
        if (context.mounted) {
          ShowToastMessage.showToast(context, TextApp.removeIngredient, 3000,
              ToastMessageStatus.success);
        }
      }
      OverlayLoadingProgress.stop();
      getIngredients();
    } catch (e) {
      OverlayLoadingProgress.stop();
      if (context.mounted) {
          ShowToastMessage.showToast(context, TextApp.error, 3000,
              ToastMessageStatus.failed);
        }
      
    }
  }

  
}