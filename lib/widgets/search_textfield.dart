import 'package:flutter/material.dart';
import 'package:daily_recipe/consts/consts.dart';

class SearchTextField extends StatefulWidget {
  final Function(String?)? onChanged;
  const SearchTextField({
    super.key,
    this.onChanged,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: ColorsApp.borderLine,
        onChanged: widget.onChanged,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: ColorsApp.borderLine,
            ),
            filled: true,
            fillColor: ColorsApp.lightGrey,
            hintText: TextApp.searchAnyThing,
            hintStyle: TextStyle(color: ColorsApp.borderLine)));
  }
}
