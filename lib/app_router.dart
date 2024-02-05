//import 'package:daily_recipe/error_screen.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:daily_recipe/screens/auth/forget_password.screens.dart';
import 'package:daily_recipe/screens/filter/filter.screens.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/screens/ingredients/ingredient.screens.dart';
import 'package:daily_recipe/screens/auth/intro.screens.dart';
import 'package:daily_recipe/screens/auth/login_screen.dart';
import 'package:daily_recipe/screens/profile/profile.screen.dart';
import 'package:daily_recipe/screens/recipes/allRecipes.screens.dart';
import 'package:daily_recipe/screens/recipes/favoriteRecipes.screens.dart';
import 'package:daily_recipe/screens/recipes/viewedRecipes.screens.dart';
import 'package:daily_recipe/screens/auth/signup_screen.dart';
import 'package:daily_recipe/screens/settings/settings.screens.dart';
import 'package:daily_recipe/screens/splash.screens.dart';
import 'package:daily_recipe/models/user.models.dart';

class AppRouter {
    final UserModel profileDetails = UserModel();
     Recipe recipeDetails = Recipe();

   String? recipeId = "1";
  static final router = {
    '/': (context) => const SplashScreen(),
    AppRoutes.introScreen: (context) => const IntroScreen(),
    AppRoutes.loginScreen: (context) => const LoginScreen(),
    AppRoutes.signupScreen: (context) => const SignupScreen(),
    AppRoutes.forgetScreen: (context) => const ForgetPasswordScreen(),
  //  AppRoutes.homepageScreen: (context) => const HomepageScreen(),
    AppRoutes.allRecipesScreen: (context) => const AllRecipesScreen(),
    AppRoutes.filterScreen: (context) => const FilterScreen(),
    AppRoutes.viewedRecipesScreen: (context) => const ViewedRecipesScreen(),
    AppRoutes.favoriteRecipesScreen: (context) => const FavoriteRecipesScreen(),
    AppRoutes.ingredientsScreen: (context) => const IngredientsScreen(),
    AppRoutes.settingsScreen: (context) => const SettingsScreen(),
  //  AppRoutes.profileScreen: (context) => ProfileScreen(profileDetails:profileDetails),
  //  AppRoutes.editprofileScreen: (context) => const EditProfileScreen(),
  /*  AppRoutes.recipeDetailsScreen: (context) => const RecipeDetailsScreen(
          recipeDetails: recipeDetails,
        ),*/
  };
}
