import 'package:flutter/material.dart';

Widget customTextColumn({
  required String text1,
  required String text2,
  required TextStyle textStyle,
}) {
  return Column(
    children: [
      Text(text1, style: textStyle),
      Text(text2, style: textStyle),
    ],
  );
}
