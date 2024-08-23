 import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(
      String title, bool autoLeading
  ) {
    return AppBar(
      title:  Text(
        title,
        style: appBarTitleStyle,
      ),
      centerTitle: true,
      automaticallyImplyLeading: autoLeading,
    );
  }