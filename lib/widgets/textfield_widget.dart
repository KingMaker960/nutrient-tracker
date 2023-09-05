import 'package:flutter/material.dart';
import 'package:manipal/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final bool obscureText;
  final TextInputType textInputType;
  // final Function onChanged;

  // ignore: use_key_in_widget_constructors
  const TextFieldWidget({
    required this.hintText,
    required this.prefixIconData,
    required this.obscureText,
    required this.textInputType,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.white,
        fontFamily: "WorkSans",
        fontSize: 15.0,
      ),
      cursorColor: Colors.white,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: Icon(
            prefixIconData,
            size: 18.0,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Color_grayBlue,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.white)),
          labelStyle: const TextStyle(
              color: Colors.white, fontFamily: "WorkSans", fontSize: 15.0),
          focusColor: Colors.white),
    );
  }
}
