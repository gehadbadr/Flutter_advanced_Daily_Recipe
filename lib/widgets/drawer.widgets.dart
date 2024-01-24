import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/screens/recipes/favoriteRecipes.screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  final ZoomDrawerController? controller;

   const DrawerWidget({super.key,required this.controller});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<AuthController>(builder: (context, authController, child) {
            authController.getDisplayName();
            String? name = authController.displayName;
            return header(context, name!);
          }),
          menuItem(context),
        ],
      ),
    );
  }

  Widget header(BuildContext context, String name) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context,AppRoutes.homepageScreen);
        },
        child: Container(
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child:
           Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorsApp.golden,
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style:
                            const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "view profile",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.borderLine),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget menuItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.home, color: ColorsApp.PKColor),
                title: const Text(TextApp.home,
                    style: TextStyle(color: ColorsApp.PKColor)),
                onTap: () {
                  //  context.goNamed( 'HomepageScreen/');
                  Navigator.pushNamed(context,AppRoutes.homepageScreen);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.favorite_border_outlined,
                    color: ColorsApp.borderLine),
                title: const Text(
                  TextApp.favorite,
                  style: TextStyle(color: ColorsApp.borderLine),
                ),
                onTap: () {
                  widget.controller!.close?.call();
                  Navigator.pushNamed(context,AppRoutes.favoriteRecipesScreen);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.play_arrow_outlined,
                    color: ColorsApp.borderLine),
                title: const Text(
                  TextApp.recentlyViewed,
                  style: TextStyle(color: ColorsApp.borderLine),
                ),
                onTap: () {
                  widget.controller!.close?.call();
                  Navigator.pushNamed(context,AppRoutes.viewedRecipesScreen);
                },
              ),
                ListTile(
                leading: const Icon(Icons.play_arrow_outlined,
                    color: ColorsApp.borderLine),
                title: const Text(
                  TextApp.ingredients,
                  style: TextStyle(color: ColorsApp.borderLine),
                ),
                onTap: () {
                  widget.controller!.close?.call();
                  Navigator.pushNamed(context,AppRoutes.viewedRecipesScreen);
                },
              ),
                  ListTile(
                leading: const Icon(Icons.food_bank,
                    color: ColorsApp.borderLine),
                title: const Text(
                  TextApp.ingredients,
                  style: TextStyle(color: ColorsApp.borderLine),
                ),
                onTap: () {
                  widget.controller!.close?.call();
                  Navigator.pushNamed(context,AppRoutes.ingredientsScreen);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.settings, color: ColorsApp.borderLine),
                title: const Text(TextApp.settings,
                    style: TextStyle(color: ColorsApp.borderLine)),
                onTap: () {},
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading:
                    const Icon(Icons.contact_mail, color: ColorsApp.borderLine),
                title: const Text(TextApp.about,
                    style: TextStyle(color: ColorsApp.borderLine)),
                onTap: () {},
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.help, color: ColorsApp.borderLine),
                title: const Text(TextApp.help,
                    style: TextStyle(color: ColorsApp.borderLine)),
                onTap: () {},
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined,
                    color: ColorsApp.borderLine),
                title: const Text(TextApp.logout,
                    style: TextStyle(color: ColorsApp.borderLine)),
                onTap: () async {
                  widget.controller!.close?.call();
                  final authController =
                      Provider.of<AuthController>(context, listen: false);
                  authController.signoutMethod(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
