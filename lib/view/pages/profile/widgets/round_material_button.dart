import 'package:flutter/material.dart';

Widget customMaterialButton({
  required VoidCallback onPressed,
  required String text,
   required Color color,
  required double width,
  required double height,
  double borderRadius = 20.0,
  TextStyle textStyle = const TextStyle(color: Colors.black),
}) {
  return MaterialButton(
    onPressed: onPressed,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    minWidth: width,
    height: height,
    child: Text(
      text,
      style: textStyle,
    ),
  );
}
