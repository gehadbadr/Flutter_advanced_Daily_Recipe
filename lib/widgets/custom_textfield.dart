import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String title;
  final TextEditingController? controller;
  final Function(String?)? onClick;
  final IconData icon;
  final bool isPass;
  CustomTextField(
      {super.key,
      required this.title,
      required this.hint,
      required this.icon,
      required this.isPass,
      this.controller,
      this.onClick});
  //var modelHubcontroller = Provider.of<ModelHud>;
  void mail() {
    const String email = 'fredrik.eilertsen@gail.com';
    final bool isValid = EmailValidator.validate(email);
    print('Email is valid? ' + (isValid ? 'yes' : 'no'));
  }

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
  }

  @override
  Widget build(BuildContext context) {
  final authController = Provider.of<AuthController>(context, listen: false);

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height:10 ,
        ),
        Text(title ,style: TextStyle(color:PKColor,fontSize: 18,fontFamily: semibold ),),
        SizedBox(
          height:5 ,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return errorMessage(hint);
            }
            if (title == email) {
              return EmailValidator.validate(value)
                  ? null
                  :invalidEmail;
            }
            if(title == password && value.length < 6) {
               return weakPassword;                      
            }
          },
          onSaved: onClick,
          cursorColor:borderLine,
          style: TextStyle(color: borderLine ),
          obscureText: isPass == false?false
                       :title == password ?authController.isTrue:authController.isConfirmPassword,
          controller: controller,
          decoration: InputDecoration(
              hintStyle: TextStyle(fontFamily: semibold, color: fontGrey),
              hintText: hint,
              //isDense: true,
              //fillColor: lightGrey,
              prefixIcon: Icon(
                icon,
                color: PKColor,
              ),
              suffixIcon:isPass== true ?
              title == password ?  InkWell(
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
                  OutlineInputBorder(borderSide: BorderSide(color: borderLine))),
        ),
        SizedBox(
          height:5 ,
        ),
      ]);
  }
}
