import 'package:buzz_buddy/utils/constants.dart';

import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:buzz_buddy/view/pages/main_page/screen_main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? darkSplashImg
                  : darkSplashImg,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  logo,
                  width: media.width * .4,
                )
                    .animate(delay: 300.milliseconds)
                    .fadeIn(duration: 300.milliseconds)
                    .scale(curve: Curves.fastLinearToSlowEaseIn),
                kheight,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> checkUserLogin(context) async {
  final preferences = await SharedPreferences.getInstance();
  final userLoggedIn = preferences.get(authKey);
  debugPrint(userLoggedIn.toString());
  if (userLoggedIn == null || userLoggedIn == false) {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ScreenLogin(),
    ));
  } else {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ScreenMainScreen(),
    ));
  }
}
