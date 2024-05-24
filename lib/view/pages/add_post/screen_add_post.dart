import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/add_post/widgets/add_post_text_fields.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:flutter/material.dart';

class ScreenAddPost extends StatelessWidget {
   ScreenAddPost({super.key});
  final textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text('Start Post', style: appBarTitleStyle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
          children: [
            Container(
              color: grey,
            width: media.width,
            height: media.height*0.4,
            
              
              child: Image.asset(imagePicker),
            ),
            kheight,
            PostTextFormField(controller: textcontroller, hintText: 'write a caption...', keyboard: TextInputType.emailAddress,validator: validateUsername,),
            kheight50,
            customMaterialButton(onPressed: (){

            }, text: 'Post', color: kPrimaryColor, width: media.width, height: media.height*0.06)
          ],
          
          ),
        ),
      )
    );
  }
}