import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/consts/toastStatus.dart';
import 'package:daily_recipe/models/user.models.dart';
import 'package:daily_recipe/reuseable_function/snackbar.function.dart';
import 'package:daily_recipe/reuseable_function/toast.function.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:overlay_kit/overlay_kit.dart';

class AuthController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  late GlobalKey<FormState>? globalKey;
  late TextEditingController? nameController;
  late TextEditingController? passwordController;
  late TextEditingController? repasswordController;
  late TextEditingController? emailController;
  late bool _isPassword;
  late bool _isConfirmPassword;
  bool get isPassword => _isPassword;
  bool get isConfirmPassword => _isConfirmPassword;
  UserModel profileDetails = UserModel();

  void providerInit() {
    globalKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    repasswordController = TextEditingController();
    _isPassword = true;
    _isConfirmPassword = true;
  }

  void providerDispose() {
    emailController = null;
    passwordController = null;
    globalKey = null;
    nameController = null;
    _isPassword = true;
    _isConfirmPassword = true;
  }

//---------------start Sign Up------------------
  Future<void> signUp(BuildContext context) async {
    OverlayLoadingProgress.start();
    if (passwordController?.text == repasswordController?.text) {
      if (globalKey?.currentState?.validate() ?? false) {
        globalKey?.currentState?.save();
        try {
          signupMehtod(emailController!.text, passwordController!.text,
              nameController!.text, context);
        } catch (e) {
          print(e.toString());
          OverlayLoadingProgress.stop();
        }
      } else {
        OverlayLoadingProgress.stop();
      }
    } else {
      OverlayLoadingProgress.stop();
      ShowSnackbar.showSnackbar(context, TextApp.errorRepassword);
    }
  }

  Future<void> signupMehtod(
      String email, String password, String name, BuildContext context) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user?.updateDisplayName(name);
        storeUserData(name, email, password);
        await getUser();

        OverlayLoadingProgress.stop();
        if (context.mounted) {
          ShowToastMessage.showToast(context, TextApp.registeredSuccessfully,
              3000, ToastMessageStatus.success);
                        Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomepageScreen(
                            profileDetails: profileDetails)),
                  );
        }
        providerDispose();
      //  Navigator.pushReplacementNamed(context, AppRoutes.homepageScreen);
        notifyListeners();

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ShowSnackbar.showSnackbar(context, TextApp.invalidEmail);
      } else if (e.code == 'email-already-in-use') {
        ShowSnackbar.showSnackbar(context, TextApp.errorRegisteredBefore);
      } else if (e.code == 'weak-password') {
        ShowSnackbar.showSnackbar(context, TextApp.weakPassword);
      } else if (e.code == "user-disabled") {
        ShowSnackbar.showSnackbar(context, TextApp.errorUserDisabled);
      } else if (e.code == "invalid-credential") {
        ShowSnackbar.showSnackbar(context, TextApp.errorInvalidCredential);
      }
      OverlayLoadingProgress.stop();
    }
  }

  storeUserData(String name, String email, String password) async {
    try {
      DocumentReference store = FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid);
      store.set({
        'name': name,
        'password': password,
        'email': email,
        'imageUrl': '',
        'id': auth.currentUser!.uid
      });
    } catch (e) {
      print(e.toString());
    }
  }

//---------------end Sign Up------------------
//---------------start Sign in------------------

  Future<void> signIn(BuildContext context) async {
    OverlayLoadingProgress.start();
    if (globalKey?.currentState?.validate() ?? false) {
      globalKey?.currentState?.save();
      try {
        loginMehtod(emailController!.text, passwordController!.text, context);
      } catch (e) {
        print(e.toString());
        OverlayLoadingProgress.stop();
      }
    } else {
      OverlayLoadingProgress.stop();
    }
  }

  Future<void> loginMehtod(
      String email, String password, BuildContext context) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        await getUser();
        ShowToastMessage.showToast(
            context, TextApp.loggedIn, 3000, ToastMessageStatus.success);
        OverlayLoadingProgress.stop();
        providerDispose();
        if (context.mounted) {
                        //    Navigator.pushNamed(context, AppRoutes.settingsScreen);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomepageScreen(
                            profileDetails: profileDetails)),
                  );
      //  Navigator.pushReplacementNamed(context, AppRoutes.homepageScreen);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ShowSnackbar.showSnackbar(context, TextApp.invalidEmail);
      } else if (e.code == 'user-not-found') {
        ShowSnackbar.showSnackbar(context, TextApp.errorUserNotFound);
      } else if (e.code == 'wrong-password') {
        ShowSnackbar.showSnackbar(context, TextApp.errorWrongPassword);
      } else if (e.code == "user-disabled") {
        ShowSnackbar.showSnackbar(context, TextApp.errorUserDisabled);
      } else if (e.code == "invalid-credential") {
        ShowSnackbar.showSnackbar(context, TextApp.errorInvalidCredential);
      }
      OverlayLoadingProgress.stop();
    }
  }

//------------end sign in -------

  Future<void> resetPassword(BuildContext context) async {
    OverlayLoadingProgress.start();
    if (globalKey?.currentState?.validate() ?? false) {
      globalKey?.currentState?.save();
      var user = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailController!.text)
          .get();
      if (user.docs.isNotEmpty) {
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: emailController!.text.trim());
          ShowToastMessage.showToast(
              context, TextApp.resetMsg, 3000, ToastMessageStatus.success);
          OverlayLoadingProgress.stop();
          if (context.mounted) {
            Navigator.pushNamed(context, AppRoutes.loginScreen);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-email') {
            ShowSnackbar.showSnackbar(context, TextApp.invalidEmail);
          } else if (e.code == 'user-not-found') {
            ShowSnackbar.showSnackbar(context, TextApp.errorUserNotFound);
          } else if (e.code == "user-disabled") {
            ShowSnackbar.showSnackbar(context, TextApp.errorUserDisabled);
          } else if (e.code == "invalid-credential") {
            ShowSnackbar.showSnackbar(context, TextApp.errorInvalidCredential);
          }
          OverlayLoadingProgress.stop();
        }
      } else {
        OverlayLoadingProgress.stop();
        ShowSnackbar.showSnackbar(context, TextApp.errorUserNotFound);
      }
    } else {
      OverlayLoadingProgress.stop();
    }
  }

//------------LogOut-------------
  void signoutMethod(BuildContext context) async {
    try {
      OverlayLoadingProgress.start();
      await Future.delayed(const Duration(seconds: 1));
      auth.signOut();
      ShowToastMessage.showToast(
          context, TextApp.loggedOut, 3000, ToastMessageStatus.success);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.introScreen, (route) => false);
      }
    } catch (e) {
      print(e.toString());
      OverlayLoadingProgress.stop();
    }
    OverlayLoadingProgress.stop();
  }

  Future<void> getUser() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (result.data() != null) {
        profileDetails = UserModel.fromJson(result.data()!, result.id);

      } else {
        return print('errorrrrrrrrrrrrrrrrrrrrrr');
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
