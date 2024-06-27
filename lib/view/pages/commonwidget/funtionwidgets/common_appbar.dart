import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppbar({required String title, TextStyle style= appBarTitleStyle,bool backEnabe = true}) {
  return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: backEnabe,
      title: Text(title,style: appBarTitleStyle,),
  );
}
