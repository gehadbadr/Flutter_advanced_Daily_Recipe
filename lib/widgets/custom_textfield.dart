import 'package:flutter/material.dart';
import 'package:daily_recipe/consts/consts.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String title;
  final TextEditingController? controller;
  final Function(String?)? onClick;
  final IconData icon;
  final bool isPass;
  bool? passwordIcon;
  Function(void)? togglePassword;
  Function(String?)? switchPasswordIcon;
  CustomTextField(
      {super.key,
      required this.title,
      required this.hint,
      required this.icon,
      required this.isPass,
      this.controller,
      this.onClick,
      this.passwordIcon,
    });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorMessage(String str) {
    if(widget.hint == S.of(context).nameHint){
        return S.of(context).nameRequired;
    }else if(widget.hint == S.of(context).emailHint){
        return S.of(context).emailRequired;
    }else if(widget.hint == S.of(context).passwordHint){
        return S.of(context).passwordRequired;
    }else if(widget.hint == S.of(context).repasswordHint){
        return S.of(context).repasswordRequired;
    }else if(widget.hint == S.of(context).oldPasswordHint){
        return S.of(context).oldPasswordRequired;
    }else if(widget.hint == S.of(context).newPasswordHint){
        return S.of(context).newPasswordRequired;
    }
    // switch (widget.hint) {
    //   case TextApp.nameHint:
    //     return S.of(context).nameRequired;
    //   case S.of(context).emailHint:
    //     return S.of(context).emailRequired;
    //   case TextApp.passwordHint:
    //     return S.of(context).passwordRequired;
    //   case TextApp.repasswordHint:
    //     return S.of(context).repasswordRequired;
    //   case TextApp.oldPasswordHint:
    //     return S.of(context).oldPasswordRequired;
    //   case TextApp.newPasswordHint:
    //     return S.of(context).newPasswordRequired;
    // }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        widget.title,
        style: const TextStyle(
            color: ColorsApp.PKColor,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return errorMessage(widget.hint);
          }
          // if (title == S.of(context).email) {
          //   return EmailValidator.validate(value)
          //       ? null
          //       :S.of(context).invalidEmail;
          // }
          if(widget.title == S.of(context).name && value.length > 20) {
             return S.of(context).invalidName;
          }
              return null;

        },
        onSaved: widget.onClick,
        cursorColor: ColorsApp.whiteColor,
        style: const TextStyle(color: ColorsApp.whiteColor),
        obscureText: widget.isPass == false ? false : widget.passwordIcon!,
        controller: widget.controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w600, color: ColorsApp.fontGrey),
            hintText: widget.hint,
            isDense: true,
            //fillColor: lightGrey,
            prefixIcon: Icon(
              widget.icon,
              color: ColorsApp.PKColor,
            ),
            suffixIcon: widget.isPass == true
                ? InkWell(
                    onTap: () {
                      widget.passwordIcon = !widget.passwordIcon!;
                      setState(() {});
                    },
                    child: widget.passwordIcon!
                        ? const Icon(
                            Icons.visibility_off,
                            color: ColorsApp.PKColor,
                          )
                        : const Icon(Icons.visibility))
                : null,
            //border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorsApp.borderLine))),
      ),
      const SizedBox(
        height: 5,
      ),
    ]);
  }
}
