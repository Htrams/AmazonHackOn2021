import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  final String title;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? textSize;

  MyAppBar({
    required this.title,
    this.textColor,
    this.textStyle,
    this.textSize,
});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: textStyle ?? TextStyle(
          color: textColor??Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: textSize ?? 30.0,
        ),
      ),
      centerTitle: true,
      toolbarHeight: 80.0,
      iconTheme: IconThemeData(
        color: Colors.blueGrey
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
