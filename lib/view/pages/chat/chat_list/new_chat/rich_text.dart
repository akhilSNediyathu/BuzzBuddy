
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/home/suggestions_page/screen_users_suggestion.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Richtext extends StatelessWidget {
  const Richtext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        const TextSpan(
            text: 'Go to  ',
            style: TextStyle(
                color: black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 15)),
        TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigatePushAnimaterbottomtotop(
                    context, const ScreenUsersSuggestion());
              },
            text: 'Suggessions?',
            style: const TextStyle(
                color: blueAccent,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 15))
      ]),
    );
  }
  
  void navigatePushAnimaterbottomtotop(BuildContext context, suggessionScreen) {}
}
