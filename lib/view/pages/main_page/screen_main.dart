import 'package:buzz_buddy/view/pages/add_post/screen_add_post.dart';
import 'package:buzz_buddy/view/pages/chat/chat_list/chat_list.dart';

import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/bottomnav.dart';
import 'package:buzz_buddy/view/pages/home/screen_home.dart';
import 'package:buzz_buddy/view/pages/profile/screen_profile.dart';
import 'package:buzz_buddy/view/pages/explore/screen_search.dart';

import 'package:flutter/material.dart';

final ValueNotifier<int> currentPage = ValueNotifier(0);

class ScreenMainScreen extends StatelessWidget {
  ScreenMainScreen({super.key});

  final List<Widget> pages = [
    const ScreenHome(),
    const ScreenSearch(),
    ScreenAddPost(),
    const FindChatPersonScreen(),
    const ScreenProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => IndexedStack(
          index: value,
          children: pages,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => bottomNav(context),
      ),
    );
  }
}
