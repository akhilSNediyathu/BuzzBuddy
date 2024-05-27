import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text( 'settings'),
      ),
      body: Center(child: 
      IconButton(onPressed: ()async{
        await clearUserSession();
      Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) {
    return ScreenLogin();
  }),
  (Route<dynamic> route) => false,  // This will remove all previous routes
);

      }, icon: Icon(Icons.logout)),),
    );
  }
}