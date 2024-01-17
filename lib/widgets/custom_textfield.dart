import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipe/consts/consts.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String title;
  final TextEditingController? controller;
  final Function(String?)? onClick;
  final IconData icon;
  final bool isPass;
  const CustomTextField(
      {super.key,
      required this.title,
      required this.hint,
      required this.icon,
      required this.isPass,
      this.controller,
      this.onClick});
  

  String? errorMessage(String str) {
    switch (hint) {
      case 'Name':
        return 'Name is required';
      case 'admin@admin.com':
        return 'Email is required';
      case 'Password':
        return 'Password is required';
      case 'RePassword':
        return 'RePassword is required ';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
  final authController = Provider.of<AuthController>(context, listen: false);

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height:10 ,
        ),
        Text(title ,style: const TextStyle(color:ColorsApp.PKColor,fontSize: 18,fontWeight: FontWeight.w600),),
        const SizedBox(
          height:5 ,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return errorMessage(hint);
            }
            // if (title == TextApp.email) {
            //   return EmailValidator.validate(value)
            //       ? null
            //       :TextApp.invalidEmail;
            // }
            // if(title == TextApp.password && value.length < 6) {
            //    return TextApp.weakPassword;                      
            // }
          },
          onSaved: onClick,
          cursorColor:ColorsApp.whiteColor,
          style: const TextStyle(color: ColorsApp.whiteColor ),
          obscureText: isPass == false?false
                       :title == TextApp.password ?authController.isTrue:authController.isConfirmPassword,
          controller: controller,
          decoration: InputDecoration(
              hintStyle: const TextStyle(fontWeight: FontWeight.w600, color: ColorsApp.fontGrey),
              hintText: hint,
              isDense: true,
              //fillColor: lightGrey,
              prefixIcon: Icon(
                icon,
                color: ColorsApp.PKColor,
              ),
              suffixIcon:isPass== true ?
              title == TextApp.password ?  InkWell(
                onTap: () {
                authController.togglePassword();
                },
                child: authController.switchConfirmPasswordIcon
              ): InkWell(
                onTap: () {
                authController.toggleConfirmPassword();
                },
                child: authController.switchPasswordIcon,
              
              ):null ,
              //border: InputBorder.none,
              focusedBorder:
                  const OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.borderLine))),
        ),
        const SizedBox(
          height:5 ,
        ),
      ]);
  }
}
