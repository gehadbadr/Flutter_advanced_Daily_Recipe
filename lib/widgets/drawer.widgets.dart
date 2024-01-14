import 'package:daily_recipe/consts/colors.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
    getName();
  }

  String getName() {
    final authController = Provider.of<AuthController>(context, listen: false);
    String? name = authController.prefsFile.getString('name');
    return name!;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsApp.lightGrey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<AuthController>(builder: (context, authController, child) {
              String? name = authController.prefsFile.getString('name');
              return header(context, name!);
            }),
            menuItem(context),
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context, String name) {
    return InkWell(
        onTap: () {
          context.goNamed('HomepageScreen/');
        },
        child: Container(
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: Row(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
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
                  context.goNamed('HomepageScreen');
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
                  context.goNamed('FavoriteRecipesScreen');
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
                  context.goNamed('ViewedRecipesScreen');
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
                  final authController =
                      Provider.of<AuthController>(context, listen: false);
                  authController.logOut();
                  VxToast.show(context, msg: TextApp.loggedOut);
                  context.goNamed('LoginScreen');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
