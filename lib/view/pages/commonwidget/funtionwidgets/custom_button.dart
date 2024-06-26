import 'package:flutter/material.dart';
import 'package:buzz_buddy/utils/constants.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

MaterialButton customButton(
    {required Size media,
    required String buttonText,
    required VoidCallback onPressed,
    required Color color}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: kradius20),
    minWidth: media.width,
    height: media.height * 0.06,
    color: color,
    child: Text(buttonText),
  );
}

MaterialButton loadingButton(
    {required Size media,
    required VoidCallback onPressed,
    required Color color}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: kradius20),
    minWidth: media.width,
    height: media.height * 0.06,
    color: color,
    child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: black,
      size: 40,
    )),
  );
}
