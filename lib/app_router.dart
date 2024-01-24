//import 'package:daily_recipe/error_screen.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/screens/ingredients/ingredient.screens.dart';
import 'package:daily_recipe/screens/intro.screens.dart';
import 'package:daily_recipe/screens/login_screen.dart';
import 'package:daily_recipe/screens/recipes/favoriteRecipes.screens.dart';
import 'package:daily_recipe/screens/recipes/recipeDetails.screens.dart';
import 'package:daily_recipe/screens/recipes/viewedRecipes.screens.dart';
import 'package:daily_recipe/screens/signup_screen.dart';
import 'package:daily_recipe/screens/splash.screens.dart';


class AppRouter {
  static final router = {
    '/': (context) =>const SplashScreen(),
    AppRoutes.introScreen: (context) => const IntroScreen(),
    AppRoutes.loginScreen: (context) => const LoginScreen(),
    AppRoutes.signupScreen: (context) => const SignupScreen(),
    AppRoutes.homepageScreen: (context) => const HomepageScreen(),
    AppRoutes.viewedRecipesScreen: (context) => const ViewedRecipesScreen(),
    AppRoutes.favoriteRecipesScreen: (context) => const FavoriteRecipesScreen(),
    AppRoutes.ingredientsScreen: (context) => const IngredientsScreen()

  };
}
