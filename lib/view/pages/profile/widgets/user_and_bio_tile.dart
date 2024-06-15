import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

Widget userNameAndBio(String userName,String bio) {
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(userName, style: appBarTitleStyle),
      Text(bio)
    ],
  );
}
