import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? actionIcon;
  final String? title;
  final Function()? onPressLeading;
  final Function()? onPressAction;
  const CustomAppBar(
      {super.key, this.leadingIcon,required this.actionIcon, this.title,this.onPressLeading, required this.onPressAction});

  @override
  Widget build(BuildContext context) {
    if(leadingIcon != null){
    return  AppBar(
        shadowColor: ColorsApp.whiteColor,
        backgroundColor: ColorsApp.whiteColor,
        foregroundColor: ColorsApp.darkFontGrey,
        surfaceTintColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: InkWell(
                onTap: 
                  onPressLeading
                ,
                child:  Icon(
                leadingIcon,
                size: 30,         
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20,top: 5),
            child: IconButton(
              onPressed: onPressAction,
              icon:  Icon(
                actionIcon,
                size: 30,
              ),
            ),
          ),
        ]);
  }else{  return  AppBar(
    leading:   Padding(
            padding: const EdgeInsets.only(right: 20,top: 5),
            child: IconButton(
              onPressed: onPressLeading,
              icon:  Icon(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20,top: 5),
            child: IconButton(
              onPressed: onPressAction,
              icon:  Icon(
                actionIcon,
                size: 30,
              ),
            ),
          ),
        ]);
  }  
  }
}
