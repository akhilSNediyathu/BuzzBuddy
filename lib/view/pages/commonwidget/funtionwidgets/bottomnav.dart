import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/main_page/screen_main.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';

MotionTabBar bottomNav(BuildContext contex) {
  return MotionTabBar(
    initialSelectedTab: 'Home',
    useSafeArea: true,
    labels: const ["Home", "Search", "Add", "Chat", "Profile"],
    icons: const [
      Icons.home,
      Icons.search,
      Icons.add,
      Icons.chat,
      Icons.person
    ],
    textStyle:  TextStyle(
      color: Theme.of(contex).brightness==Brightness.light?black:kwhiteColor,
    ),
    tabSize: 55,
    tabBarHeight: 60,
  tabIconColor: Theme.of(contex).brightness==Brightness.light?black:kwhiteColor,
    tabIconSize: 28.0,
    tabIconSelectedSize: 26.0,
    tabSelectedColor: Theme.of(contex).brightness==Brightness.light?kwhiteColor:black,
    tabIconSelectedColor: kPrimaryColor,
    tabBarColor: Theme.of(contex).brightness==Brightness.light?kwhiteColor:black,
    onTabItemSelected: (int index) {
      currentPage.value = index;
    },
  );
}
