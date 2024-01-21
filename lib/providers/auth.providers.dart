import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/consts/toastStatus.dart';
import 'package:daily_recipe/reuseable_function/snackbar.function.dart';
import 'package:daily_recipe/reuseable_function/toast.function.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  late GlobalKey<FormState>? globalKey;
  late TextEditingController? nameController;
  late TextEditingController? passwordController;
  late TextEditingController? repasswordController;
  late TextEditingController? emailController;
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

// Future<void> signupMehtod(
//       String email, String password, String name, BuildContext context) async {
//     UserCredential? userCredential;

//     try {
//       userCredential = await auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'invalid-email') {
//         ShowSnackbar.showSnackbar(context, TextApp.invalidEmail);
//       } else if (e.code == 'email-already-in-use') {
//         ShowSnackbar.showSnackbar(context, TextApp.errorRegisteredBefore);
//       } else if (e.code == 'weak-password') {
//         ShowSnackbar.showSnackbar(context, TextApp.weakPassword);
//       }
//       changeisLoading(false);
//     }
//     if (userCredential?.user != null) {
//       await userCredential?.user?.updateDisplayName(name);
//       notifyListeners();
//       changeisLoading(false);
//       VxToast.show(context, msg: TextApp.registeredSuccessfully);
//       providerDispose();
//       Navigator.pushReplacementNamed(context,'HomepageScreen');
//     }
//   }

  Future<void> signupMehtod(
      String email, String password, String name, BuildContext context) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user?.updateDisplayName(name);
        notifyListeners();
        changeisLoading(false);
        if (context.mounted) {
          ShowToastMessage.showToast(context, TextApp.registeredSuccessfully,
              3000, ToastMessageStatus.success);
        }
        providerDispose();
        Navigator.pushReplacementNamed(context, AppRoutes.homepageScreen);
      }
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
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        ShowToastMessage.showToast(
            context, TextApp.loggedIn, 3000, ToastMessageStatus.success);
        changeisLoading(false);
        providerDispose();
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.homepageScreen);
        }
      }
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
  }

//------------end sign in -------
//--------- getDisplayName-------
  Future<void> getDisplayName() async {
    displayName = auth.currentUser?.displayName;
  }

//------------LogOut-------------
  void signoutMethod(BuildContext context) async {
    try {
      auth.signOut();
      ShowToastMessage.showToast(
          context, TextApp.loggedOut, 3000, ToastMessageStatus.success);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.introScreen, (route) => false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // late User _user;
  // bool get isAuthenticated => _user != null;
  // Future<void> initAuth() async {
  //   auth.authStateChanges().listen((User? user) {
  //     _user = user!;
  //     notifyListeners();
  //   });
  // }
}
