import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/lang.providers.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/screens/profile/editProfile.screen.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              leadingIcon: Icons.arrow_back,
              onPressLeading: () async {
                await Provider.of<ProfileController>(context, listen: false)
                    .getUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomepageScreen(
                          profileDetails: Provider.of<ProfileController>(
                                  context,
                                  listen: false)
                              .profileDetails)),
                );
              },
              actionIcon: Icons.notification_add_outlined,
              onPressAction: () {})),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<RecipeController>(
              builder: (context, recipeController, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).settings,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: ColorsApp.lightGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.language,
                      size: 30,
                    ),
                    title: Text(S.of(context).language,
                        style: const TextStyle(fontSize: 20)),
                    trailing: Consumer<LangController>(
                        builder: (context, langController, child) {
                      return DropdownButton(
                        dropdownColor: ColorsApp.whiteColor,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: const [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text('English',
                                style: TextStyle(
                                    fontSize: 20, color: ColorsApp.PKColor)),
                          ),
                          DropdownMenuItem(
                            value: 'ar',
                            child: Text('العربية',
                                style: TextStyle(
                                    fontSize: 20, color: ColorsApp.PKColor)),
                          )
                        ],
                        onChanged: (value) async {
                          langController.setLocale(value!, context);
                        },
                        value: langController.appLocal,
                      );
                    }),
                  ),
                ),
                
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: ColorsApp.lightGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    title: Text(S.of(context).profile,
                        style: const TextStyle(fontSize: 20)),
                    trailing: SizedBox(
                    // padding: !Provider.of<LangController>(context, listen: false).isArabic()? EdgeInsets.symmetric(horizontal:20.0): EdgeInsets.only(left:45.0),
                      child: Text(S.of(context).update,
                                  style: const TextStyle(
                                      fontSize: 20, color: ColorsApp.PKColor)
                                      ).onTap(()async {
                      await  Provider.of<ProfileController>(context, listen: false)
                        .getUser();
                                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                              profileDetails: Provider.of<ProfileController>(
                                      context,
                                      listen: false)
                                  .profileDetails))
                                      );
                                      //  Navigator.pushNamed(context, AppRoutes.editprofileScreen);
                                    }),
                    ),
                ),)
              ],
            );
          }),
        ),
      ),
    );
  }
}
