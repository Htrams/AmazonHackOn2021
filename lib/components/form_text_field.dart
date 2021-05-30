import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {

  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final Function onChanged;

  FormTextField({
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      cursorColor: Colors.green,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.grey
          )
      ),
      style: TextStyle(
        fontSize: 20.0,
      ),
      textAlign: TextAlign.start,
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}