import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {@required this.hint,
        @required this.onChange,
        @required this.validate,
        this.keyboardType,
        this.iconSuffix,
        this.obscureText});
  final Function onChange;
  final Function validate;
  final String hint;
  final IconData iconSuffix;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.amber,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: Icon(
          iconSuffix,
          size: 30,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 1.0),
        ),
      ),
      keyboardType: keyboardType,
      onChanged: onChange,
      validator: validate,
    );
  }
}
