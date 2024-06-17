import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingAnimationWidget() {
  return Center(
    child:
        LoadingAnimationWidget.fourRotatingDots(color: kPrimaryColor, size: 30),
  );
}

Widget errorStateWidget(String text,TextStyle style) {
  return Center(
    child: Text(text,style: style,),
  );
}
