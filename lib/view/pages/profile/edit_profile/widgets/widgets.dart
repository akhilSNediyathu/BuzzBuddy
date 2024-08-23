import 'dart:io';

import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.bioController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Edit name',
            controller: nameController,
            validator: validateUsername,
          ),
          kheight20,
          CustomTextField(
            minlines: 3,
            maxlines: 5,
            hintText: 'Bio',
            controller: bioController,
            validator: validateBio,
          ),
        ],
      ),
    );
  }
}


class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({
    super.key,
    required this.coverImageNotifier,
    required this.profileImageNotifier,
    required this.cvImage,
    required this.prImage,
  });

  final ValueNotifier<String> coverImageNotifier;
  final ValueNotifier<String> profileImageNotifier;
  final String cvImage;
  final String prImage;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return ValueListenableBuilder<String>(
      valueListenable: coverImageNotifier,
      builder: (context, coverImagePath, child) {
        return Container(
          width: media.width,
          height: media.height * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: coverImagePath.isNotEmpty
                  ? FileImage(File(coverImagePath))
                  : CachedNetworkImageProvider(cvImage) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -85,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    pickImage(profileImageNotifier);
                  },
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: kwhiteColor,
                    child: CircleAvatar(
                      radius: 85,
                      backgroundImage: profileImageNotifier.value.isNotEmpty
                          ? FileImage(File(profileImageNotifier.value))
                          : CachedNetworkImageProvider(prImage) as ImageProvider,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: GestureDetector(
                  onTap: () {
                    pickImage(coverImageNotifier);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.withOpacity(0.7),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
