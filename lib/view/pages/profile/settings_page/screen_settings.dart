// ignore_for_file: use_build_context_synchronously

import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/showdialogue.dart';
import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text( 'settings'),
      ),
      body: Center(child: 
      IconButton(onPressed: (){
       showConfirmationDialog(context: context, title: 'Log out!', content: 'Are you sure..?', confirmButtonText:  "confirm", cancelButtonText: "cancel", onConfirm: ()async{
         await clearUserSession();
      Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) {
    return ScreenLogin();
  }),
  (Route<dynamic> route) => false,  // This will remove all previous routes
);

       });

      }, icon: const Icon(Icons.logout)),),
    );
  }
}