import 'package:daily_recipe/consts/consts.dart';
//import 'package:daily_recipe/providers/lang.providers.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? actionIcon;
  final String? title;
  final Function()? onPressLeading;
  final Function()? onPressAction;
  const CustomAppBar(
      {super.key,
      this.leadingIcon,
      required this.actionIcon,
      this.title,
      this.onPressLeading,
       this.onPressAction});

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(right: 20, top: 5),
          child: IconButton(
            onPressed: onPressLeading,
            icon: Icon(
              leadingIcon,
              size: 30,
            ),
          ),
        ),
        shadowColor: ColorsApp.whiteColor,
        backgroundColor: ColorsApp.whiteColor,
        foregroundColor: ColorsApp.darkFontGrey,
        surfaceTintColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      /*  actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 8, left: 8),
            child: Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(
                  width: 15,
                ),
                Consumer<LangController>(
                    builder: (context, langController, child) {
                  return DropdownButton(
                    dropdownColor: ColorsApp.whiteColor,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: const [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text('العربية'),
                      )
                    ],
                    onChanged: (value) async {
                    
                      langController.setLocale(value!, context);
//  await Future.delayed(const Duration(seconds: 2), () {});
//                   Navigator.pushNamed(context, AppRoutes.splash);
                    } ,
                    value: langController.appLocal,
                  );
                }),
              ],
            ),
          ),
        ]*/);
  }
}
