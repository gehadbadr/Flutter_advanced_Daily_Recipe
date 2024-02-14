
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/lang.providers.dart';

import 'package:daily_recipe/widgets/applogo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            const Positioned.fill(
              //
              child:
                  Image(image: AssetImage(ImagesPath.imgBg), fit: BoxFit.fill),
            ),
            SingleChildScrollView(
                child: SizedBox(
              height: context.screenHeight,
              width: context.screenWidth,
              child: Column(
                children: [
                  SizedBox(
                    height: context.screenHeight / 2.5,
                  ),
                  const AppLogoWidget(),
                  const SizedBox(height: 10,),
                  const Text('Select Language',style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: ColorsApp.PKColor),),
                  const SizedBox(height: 10,),
                    Consumer<LangController>(builder: (context, langController, child) {
            return DropdownButton(
              dropdownColor:Colors.black38,
            //  underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down),
              items: const [
                DropdownMenuItem(
                  value:'en',
                  child: Text('English',style:TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: ColorsApp.whiteColor)),
                ),
                DropdownMenuItem(
                  value: 'ar',
                  child: Text('العربية',style:TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: ColorsApp.whiteColor)),
                )
              ],
              onChanged: (value) {  
                 langController.setLocale(value!,context);
                Navigator.pushReplacementNamed(context, AppRoutes.introScreen);

              } ,
              value: 'en',
            );
          }),

                ],
              ),
            )),
          ],
        ));
  }
}
