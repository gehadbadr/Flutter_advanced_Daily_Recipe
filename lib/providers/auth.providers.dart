import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/reuseable_function/snackbar.function.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  late GlobalKey<FormState>? globalKey;
  late TextEditingController? nameController;
  late TextEditingController? passwordController;
  late TextEditingController? repasswordController;
  late TextEditingController? emailController;
  late bool islogin;
  String? displayName;
  bool? isLoading;
  bool? obscureText;
  late bool _isTrue;
  late bool _isConfirmPassword;
  bool get isTrue => _isTrue;
  bool get isConfirmPassword => _isConfirmPassword;

  void providerInit() {
    globalKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    repasswordController = TextEditingController();
    isLoading = false;
    islogin = true;
    obscureText = false;
    _isTrue = true;
    _isConfirmPassword = true;
    displayName = null;

  }

  void providerDispose() {
    emailController = null;
    passwordController = null;
    globalKey = null;
    nameController = null;
    islogin = true;
    obscureText = false;
    _isTrue = true;
    _isConfirmPassword = true;
    displayName = null;

  }

  changeisLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  get switchPasswordIcon {
    return _isConfirmPassword
        ? const Icon(
            Icons.visibility_off,
            color: ColorsApp.PKColor,
          )
        : const Icon(Icons.visibility);
  }

  get switchConfirmPasswordIcon {
    return _isTrue
        ? const Icon(
            Icons.visibility_off,
            color: ColorsApp.PKColor,
          )
        : const Icon(Icons.visibility);
  }

  void toggleConfirmPassword() {
    _isConfirmPassword = !_isConfirmPassword;
    notifyListeners();
  }

  void togglePassword() {
    _isTrue = !_isTrue;
    notifyListeners();
  }

//---------------start Sign Up------------------
  Future<void> signUp(BuildContext context) async {
    changeisLoading(true);
    if (passwordController?.text == repasswordController?.text) {
      if (globalKey?.currentState?.validate() ?? false) {
        globalKey?.currentState?.save();
        try {
          signupMehtod(emailController!.text, passwordController!.text,
              nameController!.text, context);
        } catch (e) {
          print(e.toString());
          changeisLoading(false);
        }
      } else {
        changeisLoading(false);
      }
    } else {
      changeisLoading(false);
      ShowSnackbar.showSnackbar(context, TextApp.errorRepassword);
    }
  }

  Future<void> signupMehtod(
      String email, String password, String name, BuildContext context) async {
    UserCredential? userCredential;

    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ShowSnackbar.showSnackbar(context, TextApp.invalidEmail);
      } else if (e.code == 'email-already-in-use') {
        ShowSnackbar.showSnackbar(context, TextApp.errorRegisteredBefore);
      } else if (e.code == 'weak-password') {
        ShowSnackbar.showSnackbar(context, TextApp.weakPassword);
      }
      changeisLoading(false);
    }
    if (userCredential?.user != null) {
      await userCredential?.user?.updateDisplayName(name);
      notifyListeners();
      changeisLoading(false);
      VxToast.show(context, msg: TextApp.registeredSuccessfully);
      providerDispose();
      context.replaceNamed('HomepageScreen');
    }
  }

//---------------end Sign Up------------------
//---------------start Sign in------------------
  
  Future<void> signIn(BuildContext context) async {
    changeisLoading(true);
    if (globalKey?.currentState?.validate() ?? false) {
      globalKey?.currentState?.save();
      try {
        loginMehtod(emailController!.text, passwordController!.text, context);
      } catch (e) {
        print(e.toString());
        changeisLoading(false);
      }
    } else {
      changeisLoading(false);
    }
  }

  Future<void> loginMehtod(
      String email, String password, BuildContext context) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ShowSnackbar.showSnackbar(context, TextApp.invalidEmail);
      } else if (e.code == 'user-not-found') {
        ShowSnackbar.showSnackbar(context, TextApp.errorUserNotFound);
      } else if (e.code == 'wrong-password') {
        ShowSnackbar.showSnackbar(context, TextApp.errorWrongPassword);
      }
      changeisLoading(false);
    }

    if (userCredential?.user != null) {
      VxToast.show(context, msg: TextApp.loggedIn);
      changeisLoading(false);
      providerDispose();
      context.replaceNamed('HomepageScreen');
    }
  }

//------------end sign in -------
//--------- getDisplayName-------
  Future<void> getDisplayName() async {
    displayName = _auth.currentUser?.displayName;
  }

//------------LogOut-------------
  void signoutMethod(BuildContext context) async {
    try {
      _auth.signOut();
      VxToast.show(context, msg: TextApp.loggedOut);
      context.goNamed('LoginScreen');
    } catch (e) {
      print(e.toString());
    }
  }
}
