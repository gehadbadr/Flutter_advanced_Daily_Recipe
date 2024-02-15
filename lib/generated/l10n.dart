// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `gApp`
  String get appname {
    return Intl.message(
      'gApp',
      name: 'appname',
      desc: '',
      args: [],
    );
  }

  /// `Cooking Done The Easy Way`
  String get slogen {
    return Intl.message(
      'Cooking Done The Easy Way',
      name: 'slogen',
      desc: '',
      args: [],
    );
  }

  /// `Version 1.0.0`
  String get appversion {
    return Intl.message(
      'Version 1.0.0',
      name: 'appversion',
      desc: '',
      args: [],
    );
  }

  /// `@Gehad Devs`
  String get credits {
    return Intl.message(
      '@Gehad Devs',
      name: 'credits',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameHint {
    return Intl.message(
      'Name',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `admin@admin.com`
  String get emailHint {
    return Intl.message(
      'admin@admin.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordHint {
    return Intl.message(
      'Password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get repassword {
    return Intl.message(
      'Confirm password',
      name: 'repassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get repasswordHint {
    return Intl.message(
      'Confirm Password',
      name: 'repasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPass {
    return Intl.message(
      'Forget Password',
      name: 'forgetPass',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don"t have an account ? `
  String get creatNewAccount {
    return Intl.message(
      'Don"t have an account ? ',
      name: 'creatNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Log in with`
  String get loginWith {
    return Intl.message(
      'Log in with',
      name: 'loginWith',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termAndCond {
    return Intl.message(
      'Terms and Conditions',
      name: 'termAndCond',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account ? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `you register successfully `
  String get registeredSuccessfully {
    return Intl.message(
      'you register successfully ',
      name: 'registeredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is not correct`
  String get errorRepassword {
    return Intl.message(
      'Confirm password is not correct',
      name: 'errorRepassword',
      desc: '',
      args: [],
    );
  }

  /// `You have to agree`
  String get errorAgree {
    return Intl.message(
      'You have to agree',
      name: 'errorAgree',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter more than 6 digit .`
  String get weakPassword {
    return Intl.message(
      'Please Enter more than 6 digit .',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Name shouldn"t be more than 20 letter .`
  String get invalidName {
    return Intl.message(
      'Name shouldn"t be more than 20 letter .',
      name: 'invalidName',
      desc: '',
      args: [],
    );
  }

  /// `you Logged successfully `
  String get loggedIn {
    return Intl.message(
      'you Logged successfully ',
      name: 'loggedIn',
      desc: '',
      args: [],
    );
  }

  /// `No Email is registered`
  String get errorNullloggedIn {
    return Intl.message(
      'No Email is registered',
      name: 'errorNullloggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Email or Password `
  String get errorloggedIn {
    return Intl.message(
      'Wrong Email or Password ',
      name: 'errorloggedIn',
      desc: '',
      args: [],
    );
  }

  /// `This email is registered before.`
  String get errorRegisteredBefore {
    return Intl.message(
      'This email is registered before.',
      name: 'errorRegisteredBefore',
      desc: '',
      args: [],
    );
  }

  /// `This email is not found.`
  String get errorUserNotFound {
    return Intl.message(
      'This email is not found.',
      name: 'errorUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Password .`
  String get errorWrongPassword {
    return Intl.message(
      'Wrong Password .',
      name: 'errorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `This email Account was disabled .`
  String get errorUserDisabled {
    return Intl.message(
      'This email Account was disabled .',
      name: 'errorUserDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Email or Password.`
  String get errorInvalidCredential {
    return Intl.message(
      'Wrong Email or Password.',
      name: 'errorInvalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `Logged out successfully `
  String get loggedOut {
    return Intl.message(
      'Logged out successfully ',
      name: 'loggedOut',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameRequired {
    return Intl.message(
      'Name is required',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `RePassword is required`
  String get repasswordRequired {
    return Intl.message(
      'RePassword is required',
      name: 'repasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Old Password is required`
  String get oldPasswordRequired {
    return Intl.message(
      'Old Password is required',
      name: 'oldPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `New password is required`
  String get newPasswordRequired {
    return Intl.message(
      'New password is required',
      name: 'newPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `New Password have been sent to email`
  String get resetMsg {
    return Intl.message(
      'New Password have been sent to email',
      name: 'resetMsg',
      desc: '',
      args: [],
    );
  }

  /// `Search for recipe...`
  String get searchAnyThing {
    return Intl.message(
      'Search for recipe...',
      name: 'searchAnyThing',
      desc: '',
      args: [],
    );
  }

  /// `Bonjour`
  String get bonjour {
    return Intl.message(
      'Bonjour',
      name: 'bonjour',
      desc: '',
      args: [],
    );
  }

  /// `What would you like to cook today?`
  String get whatToCook {
    return Intl.message(
      'What would you like to cook today?',
      name: 'whatToCook',
      desc: '',
      args: [],
    );
  }

  /// `Today's Fresh Recipes`
  String get todayFreshRecipe {
    return Intl.message(
      'Today\'s Fresh Recipes',
      name: 'todayFreshRecipe',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Recomended`
  String get recomended {
    return Intl.message(
      'Recomended',
      name: 'recomended',
      desc: '',
      args: [],
    );
  }

  /// `Added to favorite list`
  String get addFavorite {
    return Intl.message(
      'Added to favorite list',
      name: 'addFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Removed from favorite list`
  String get removeFavorite {
    return Intl.message(
      'Removed from favorite list',
      name: 'removeFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Meals`
  String get meals {
    return Intl.message(
      'Meals',
      name: 'meals',
      desc: '',
      args: [],
    );
  }

  /// `breakfast`
  String get breakfast {
    return Intl.message(
      'breakfast',
      name: 'breakfast',
      desc: '',
      args: [],
    );
  }

  /// `lunch`
  String get lunch {
    return Intl.message(
      'lunch',
      name: 'lunch',
      desc: '',
      args: [],
    );
  }

  /// `dinner`
  String get dinner {
    return Intl.message(
      'dinner',
      name: 'dinner',
      desc: '',
      args: [],
    );
  }

  /// `Serving`
  String get servingFilter {
    return Intl.message(
      'Serving',
      name: 'servingFilter',
      desc: '',
      args: [],
    );
  }

  /// `Preparation Time`
  String get prepTime {
    return Intl.message(
      'Preparation Time',
      name: 'prepTime',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorite {
    return Intl.message(
      'Favorites',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Recently Viewed`
  String get recentlyViewed {
    return Intl.message(
      'Recently Viewed',
      name: 'recentlyViewed',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about {
    return Intl.message(
      'About us',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Search uesing keywords...`
  String get searchAnyKey {
    return Intl.message(
      'Search uesing keywords...',
      name: 'searchAnyKey',
      desc: '',
      args: [],
    );
  }

  /// `Removed from recently viewed  list`
  String get removeViewedrecipe {
    return Intl.message(
      'Removed from recently viewed  list',
      name: 'removeViewedrecipe',
      desc: '',
      args: [],
    );
  }

  /// `Recipes`
  String get recipes {
    return Intl.message(
      'Recipes',
      name: 'recipes',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get results {
    return Intl.message(
      'Results',
      name: 'results',
      desc: '',
      args: [],
    );
  }

  /// `serving`
  String get serving {
    return Intl.message(
      'serving',
      name: 'serving',
      desc: '',
      args: [],
    );
  }

  /// `Calories`
  String get calories {
    return Intl.message(
      'Calories',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `mins`
  String get mins {
    return Intl.message(
      'mins',
      name: 'mins',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `Directions`
  String get directions {
    return Intl.message(
      'Directions',
      name: 'directions',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient is added successfully`
  String get addIngredient {
    return Intl.message(
      'Ingredient is added successfully',
      name: 'addIngredient',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient is removed successfully`
  String get removeIngredient {
    return Intl.message(
      'Ingredient is removed successfully',
      name: 'removeIngredient',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Image profile is updated successfully.`
  String get imgUpdate {
    return Intl.message(
      'Image profile is updated successfully.',
      name: 'imgUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get oldPassword {
    return Intl.message(
      'Old password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPasswordHint {
    return Intl.message(
      'Old Password',
      name: 'oldPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordHint {
    return Intl.message(
      'New Password',
      name: 'newPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Wrong old password .`
  String get errorOldPassword {
    return Intl.message(
      'Wrong old password .',
      name: 'errorOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `profile is updated successfully.`
  String get saveData {
    return Intl.message(
      'profile is updated successfully.',
      name: 'saveData',
      desc: '',
      args: [],
    );
  }

  /// `view profile`
  String get viewProfile {
    return Intl.message(
      'view profile',
      name: 'viewProfile',
      desc: '',
      args: [],
    );
  }

  /// `Your profile`
  String get profile {
    return Intl.message(
      'Your profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found`
  String get noDataFound {
    return Intl.message(
      'No Data Found',
      name: 'noDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
