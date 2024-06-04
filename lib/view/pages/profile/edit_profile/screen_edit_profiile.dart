import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:flutter/material.dart';

class ScreenEditProfiile extends StatelessWidget {
  const ScreenEditProfiile({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: appBarTitleStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: media.width,
                height: media.height * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(mainImages[0]), fit: BoxFit.cover)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -85,
                      left: 10,
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          color: kwhiteColor,
                          border: Border.all(width: 5, color: kwhiteColor),
                          image: DecorationImage(
                            image: NetworkImage(
                              profileImages[0],
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 20,
                              bottom: 10,
                              child: CircleAvatar(
                                  backgroundColor: grey,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit))),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: CircleAvatar(
                          backgroundColor: grey,
                          child: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.edit))),
                    ),
                  ],
                ),
              ),
              kheight100,
              CustomTextField(
                hintText: 'edit name',
                controller: TextEditingController(),
              ),
              kheight,
              CustomTextField(
                hintText: 'bio',
                controller: TextEditingController(),
              ),
              kheight50,
              customMaterialButton(
                  onPressed: () {},
                  text: 'Save',
                  color: kPrimaryColor,
                  width: media.width,
                  height: media.height * 0.05)
            ],
          ),
        ),
      ),
    );
  }
}
