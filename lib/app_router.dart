import 'package:daily_recipe/error_screen.dart';
import 'package:daily_recipe/screens/homepage.screens.dart';
import 'package:daily_recipe/screens/intro.screens.dart';
import 'package:daily_recipe/screens/login_screen.dart';
import 'package:daily_recipe/screens/recipes/favoriteRecipes.screens.dart';
import 'package:daily_recipe/screens/recipes/recipeDetails.screens.dart';
import 'package:daily_recipe/screens/recipes/viewedRecipes.screens.dart';
import 'package:daily_recipe/screens/signup_screen.dart';
import 'package:daily_recipe/screens/splash.screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return SplashScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'IntroScreen',
            path: "IntroScreen",
            builder: (BuildContext context, GoRouterState state) {
              return const IntroScreen();
            },
          ),
          GoRoute(
            name: 'LoginScreen',
            path: 'LoginScreen',
            builder: (BuildContext context, GoRouterState state) {
              return LoginScreen();
            },
          ),
          GoRoute(
            name: 'SignupScreen',
            path: 'SignupScreen',
            builder: (BuildContext context, GoRouterState state) {
              return SignupScreen();
            },
          ),
          GoRoute(
            name: 'HomepageScreen',
            path: 'HomepageScreen',
            builder: (BuildContext context, GoRouterState state) {
              return const HomepageScreen();
            },
          ),
          GoRoute(
            name: 'ViewedRecipesScreen',
            path: 'ViewedRecipesScreen',
            builder: (BuildContext context, GoRouterState state) {
              return const ViewedRecipesScreen();
            },
          ),
          GoRoute(
            name: 'FavoriteRecipesScreen',
            path: 'FavoriteRecipesScreen',
            builder: (BuildContext context, GoRouterState state) {
              return const FavoriteRecipesScreen();
            },
          ),
          GoRoute(
            name: 'RecipeDetailsScreen',
            path: 'RecipeDetailsScreen',
            builder: (BuildContext context, GoRouterState state) {
              return RecipeDetailsScreen(recipeId: state.uri.queryParameters['id']);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
              return const ErrorScreen();
    },
  );
}
