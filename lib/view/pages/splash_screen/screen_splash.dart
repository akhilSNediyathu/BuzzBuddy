import 'package:buzz_buddy/utils/constants.dart';

import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:buzz_buddy/view/pages/main_page/screen_main.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: kwhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              width: media.width * 0.3,
            ),
            kheight,
            Image.asset(buzzBuddyText)
          ],
        ),
      ),
    );
  }


}

Future<void> checkUserLogin(context) async {
  final preferences = await SharedPreferences.getInstance();
  final userLoggedIn = preferences.get(authKey);
  debugPrint(userLoggedIn.toString());
  if (userLoggedIn == null || userLoggedIn == false) {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ScreenLogin(),
    ));
  } else {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ScreenMainScreen(),
    ));
  }
}
