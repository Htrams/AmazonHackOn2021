import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormTextField2 extends StatelessWidget {

  final TextInputType keyboardType;
  final Color iconColor;
  final String? hintText;
  final Color fillColor;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function? onSubmitted;
  final Function onChanged;

  FormTextField2({
    this.keyboardType = TextInputType.text,
    this.iconColor = Colors.black,
    this.hintText,
    this.fillColor = Colors.white,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.onSubmitted,
    required this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        onSubmitted: onSubmitted == null ? null : (String value) {
          onSubmitted!(value);
        },
        onChanged: (String value) {
          onChanged(value);
        },
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: iconColor,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            filled: true,
            fillColor: fillColor,
            hintText: hintText
        ),
        style: TextStyle(
            fontSize: 18.0
        ),
      ),
    );
  }
}
