import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/user.models.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/screens/profile/profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  final ZoomDrawerController controller;
  final UserModel profileDetails;
  const DrawerWidget({super.key, required this.controller, required this.profileDetails});
//  const DrawerWidget({super.key, required this.controller});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}
 
class _DrawerWidgetState extends State<DrawerWidget> {
  String name = '';
  String firstLetter = '';
  String imageUrl = '';
  @override
  void initState() {
   init();
    super.initState();
  }

  void init() async {
    
    //     .name!;
    // firstLetter = name[0].toUpperCase();
    // imageUrl = Provider.of<ProfileController>(context, listen: false)
    //     .profileDetails
        // .imageUrl!;

    name =widget.profileDetails.name!;
    firstLetter = name[0].toUpperCase();
    imageUrl = widget.profileDetails.imageUrl!;    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: const Color.fromARGB(255, 102, 102, 102),
      backgroundColor: ColorsApp.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Consumer<ProfileController>(
            //     builder: (context, profileController, child) {
            //          if (widget.profileDetails.docid == null) {
            //           return const CircularProgressIndicator();
            //         } else {
            //   String? name = widget.profileDetails.name;
            //   String? firstLetter = name?[0].toUpperCase();
            //   String? imageUrl = widget.profileDetails.imageUrl;
            //   return header(context, name!, firstLetter!, imageUrl!);}
            // }),
           header(context, name, firstLetter,imageUrl),
            menuItem(context),
          ],
        ),
      ),
    );
  }

  Widget header(
      BuildContext context, String? name, String firstLetter, String? imageUrl) {
    return InkWell(
        onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(profileDetails: widget.profileDetails)),
                      );
        },
        child: Container(
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: imageUrl != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          placeholder: (context, url) => Text(name!),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,width: 80,
                          height: 80,
        ))
                    : CircleAvatar(
                        radius: 40,
                        backgroundColor: ColorsApp.golden,
                        child: Text(firstLetter),
                      ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
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
      padding: const EdgeInsets.all(15),
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
                  Navigator.pushNamed(context, AppRoutes.homepageScreen);
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
                  widget.controller.close?.call();
                  Navigator.pushNamed(context, AppRoutes.favoriteRecipesScreen);
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
                  widget.controller.close?.call();
                  Navigator.pushNamed(context, AppRoutes.viewedRecipesScreen);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.food_bank, color: ColorsApp.borderLine),
                title: const Text(
                  TextApp.ingredients,
                  style: TextStyle(color: ColorsApp.borderLine),
                ),
                onTap: () {
                  widget.controller.close?.call();
                  Navigator.pushNamed(context, AppRoutes.ingredientsScreen);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.settings, color: ColorsApp.borderLine),
                title: const Text(TextApp.settings,
                    style: TextStyle(color: ColorsApp.borderLine)),
                onTap: () {
                  widget.controller.close?.call();
                  Navigator.pushNamed(context, AppRoutes.settingsScreen);
                
                },
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
                  widget.controller.close?.call();
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
