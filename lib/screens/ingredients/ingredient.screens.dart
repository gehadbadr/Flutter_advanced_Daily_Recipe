import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/ingredient.providers.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
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

    void init() async {
    Provider.of<IngredientController>(context, listen: false).getIngredients();
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
          appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CustomAppBar(
              actionIcon: Icons.notification_add_outlined,
              onPressAction: () {})),
      body:  Consumer<IngredientController>(
                  builder: (ctx, ingredientController, _) =>
                      ingredientController.ingredientsList == null
                          ? const CircularProgressIndicator()
                          : (ingredientController.ingredientsList?.isEmpty ?? false)
                              ? const Text('No Data Found')
                              : ListView.builder(
                                  itemCount: ingredientController.ingredientsList!.length,
                                  itemBuilder: (ctx, index) => ListTile(
                                        leading: Checkbox(
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
                                      ))),
            
        
        
      
    );
  }

}