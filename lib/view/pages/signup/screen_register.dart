import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class ScreenResgister extends StatelessWidget {
  const ScreenResgister({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kwhiteColor,
      body:SafeArea(child:  Center(
        child: Column(
          children: [
            SizedBox(
              height: media.height*0.15,
              child: Image.asset('assets/images/logoF 1.png'))
            
          ],
        ),
      )
    ));
  }
}