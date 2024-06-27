import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/common_appbar.dart';
import 'package:flutter/material.dart';

class ScreenTermsAndConditions extends StatelessWidget {
  const ScreenTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: 'Terms & Conditions'),
      body: const SingleChildScrollView(
        child: Column(
          children: [Text('BuzzBuddy',style: TextStyle(),)],
        ),
      ),
    );
  }
}
