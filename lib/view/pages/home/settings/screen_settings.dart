import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Settings'),
      ),
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(height: 500,),
           customButton(media: media, buttonText: 'Log out', onPressed: (){}, color: Color.fromARGB(255, 232, 225, 225))
        
          ],
        ),
      )
      
      ),
    );
  }
}