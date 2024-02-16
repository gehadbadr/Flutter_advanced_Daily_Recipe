import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/ingredient.providers.dart';
import 'package:daily_recipe/providers/lang.providers.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/loadingCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
   @override
  void initState() {
    init();
    super.initState();
  }

    void init()  {
    Provider.of<IngredientController>(context, listen: false).getIngredients();
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
        backgroundColor: ColorsApp.whiteColor,

          appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              leadingIcon: Icons.arrow_back,
              onPressLeading: ()async {
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
              actionIcon: Icons.language,
              onPressAction: () {})),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<IngredientController>(
                    builder: (ctx, ingredientController, _) =>
                        ingredientController.ingredientsList == null
                            ?  Align(
                                  alignment: Provider.of<LangController>(context, listen: false).isArabic()?Alignment.topRight:Alignment.topLeft,
                                  child: SizedBox(
                                    width: 200,
                                    child: ListView.builder(
                                        itemCount: ListsApp.ingredientsList.length,
                                        itemBuilder: (ctx, index) => const LoadingListPage(
                                            viewType: 6,
                                          )
                                           ),
                                  ),
                                )
                            : (ingredientController.ingredientsList?.isEmpty ?? false)
                                ? const Text('No Data Found')
                                :
                                ListView.builder(
                                    itemCount: ingredientController.ingredientsList!.length,
                                    itemBuilder: (ctx, index) => ListTile(
                                          leading: Checkbox(
                                          //   tristate : true,
                                              value: ingredientController
                                                  .ingredientsList![index].users_ids
                                                  ?.contains(FirebaseAuth
                                                      .instance.currentUser?.uid),
                                              onChanged: (value) {
                                                ingredientController.addIngredientToUser(
                                                    ingredientController
                                                        .ingredientsList![index].docId!,
                                                    value ?? false,context);
                                              }),
                                          title: Text(ingredientController
                                                  .ingredientsList![index].name ??
                                              'No Name'),
                                        ))
                                        ),
      ),
            
        
        
      
    );
  }

}