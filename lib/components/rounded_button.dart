import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {

  final Color color;
  final Function onPressed;
  final String text;
  final Color textColor;
  final double elevation;
  final double opacity;
  final double fontSize;
  final double borderRadius;

  RoundedButton({
    this.color = Colors.white,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.black,
    this.elevation = 5.0,
    this.opacity = 1.0,
    this.fontSize = 17,
    this.borderRadius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    // print('rebuilding child');
    return Padding(
      padding: EdgeInsets.only(
          bottom: 8.0,
          top: 8.0
      ),
      child: Material(
        elevation: elevation,
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(borderRadius),
        child: MaterialButton(
          onPressed: (){
            onPressed();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
                color: textColor.withOpacity(opacity),
                fontSize: fontSize
            ),
          ),
        ),
      ),
    );
  }
}