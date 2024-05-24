import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/main_page/screen_main.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';

MotionTabBar bottomNav() {
    return MotionTabBar(
        initialSelectedTab: 'Home',
        useSafeArea: true,
        labels: const ["Home", "Search", "Add", "Chat", "Profile"],
        icons: const [Icons.home, Icons.search, Icons.add, Icons.chat, Icons.person],
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        tabSize: 55,
        tabBarHeight: 60,
        tabIconColor: Colors.black,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: kwhiteColor,
        tabIconSelectedColor: kPrimaryColor,
        tabBarColor: kwhiteColor,
        onTabItemSelected: (int index) {
          currentPage.value = index;
        },
      );
  }