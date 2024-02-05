import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/providers/recepie.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/screens/recipes/filteredRecipes.screens.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        TextApp.settings,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
        color: ColorsApp.lightGrey,
        borderRadius: BorderRadius.circular(20),),
                  child: ListTile(
                    leading:  Icon(
                      Icons.language,
                  size: 30,
                   ),
                   title: Text(TextApp.language,style: TextStyle(fontSize: 20)),
                   trailing:Text(TextApp.english,style: TextStyle(fontSize: 20,color: ColorsApp.PKColor),) ,
                  ),
                ),
                
                              ],
            );
          }),
        ),
      ),
    );
  }
}
