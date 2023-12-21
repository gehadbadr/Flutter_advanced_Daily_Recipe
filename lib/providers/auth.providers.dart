import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool isLoading = false;
  bool obscureText = false;

  changeisLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
  bool _isTrue = true;
  bool _isConfirmPassword = true;
  bool get isTrue => _isTrue;
  bool get isConfirmPassword => _isConfirmPassword;

  get switchPasswordIcon {
    return _isConfirmPassword ? Icon(Icons.visibility_off,color: PKColor,) : Icon(Icons.visibility);
  }
 get switchConfirmPasswordIcon {
    return _isTrue ? Icon(Icons.visibility_off,color: PKColor,) : Icon(Icons.visibility);
  }
  void toggleConfirmPassword() {
    _isConfirmPassword = !_isConfirmPassword;
    notifyListeners();
  }
  void togglePassword() {
    _isTrue = !_isTrue;
    notifyListeners();
  }

}
