import 'package:buzz_buddy/view/pages/signup/screen_register.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}


class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    goToLogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logoF 1.png'),
          Image.asset('assets/images/BuzzBuddy.png')
          ],
        ),
      ),
    );
  }
  
  goToLogin(context) async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ScreenResgister()),
    );
  }
}