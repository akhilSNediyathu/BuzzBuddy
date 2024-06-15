import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/bloc/edit_user_profile_bloc/edit_user_profile_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/logined_user_details/login_user_details_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScreenEditProfile extends StatefulWidget {
  const ScreenEditProfile({super.key});

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final ValueNotifier<String> profileImageNotifier = ValueNotifier('');
  final ValueNotifier<String> coverImageNotifier = ValueNotifier('');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
    super.initState();
  }

  Future<void> pickImage(ValueNotifier<String> imageNotifier) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageNotifier.value = pickedFile.path;
    }
  }

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
      ),
      body: BlocConsumer<EditUserProfileBloc, EditUserProfileState>(
        listener: (context, state) {
          if (state is EditUserProfileSuccesState) {
            customSnackbar(context, 'profile details updated', green);
            context
                .read<LoginUserDetailsBloc>()
                .add(OnLoginedUserDataFetchEvent());
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ValueListenableBuilder<String>(
                    valueListenable: coverImageNotifier,
                    builder: (context, coverImagePath, child) {
                      return Container(
                        width: media.width,
                        height: media.height * 0.25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: coverImagePath.isNotEmpty
                                ? FileImage(File(coverImagePath))
                                : NetworkImage(mainImages[0]) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              bottom: -85,
                              left: 10,
                              child: ValueListenableBuilder<String>(
                                valueListenable: profileImageNotifier,
                                builder: (context, profileImagePath, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      pickImage(profileImageNotifier);
                                    },
                                    child: Container(
                                      height: 180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        color: kwhiteColor,
                                        border: Border.all(
                                            width: 5, color: kwhiteColor),
                                        image: DecorationImage(
                                          image: profileImagePath.isNotEmpty
                                              ? FileImage(
                                                  File(profileImagePath))
                                              : NetworkImage(profileImages[0])
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            right: 20,
                                            bottom: 10,
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.7),
                                              child: const Icon(Icons.edit,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
                                  child: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  kheight100,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'Edit name',
                          controller: nameController,
                          validator: validateUsername,
                        ),
                        kheight,
                        CustomTextField(
                          minlines: 3,
                          maxlines: 5,
                          hintText: 'Bio',
                          controller: bioController,
                          validator: validateBio,
                        ),
                        kheight50,
                        BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
                          builder: (context, state) {
                            if (state is EditUserProfileLoadingState) {
                              return loadingButton(
                                  media: media, onPressed: () {}, color: green);
                            }
                            return customMaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                              //     context
                              //         .read<EditUserProfileBloc>()
                              //         .add(OnEditProfileButtonClickedEvent());
                                }
                              },
                              text: 'Save',
                              color: kPrimaryColor,
                              width: media.width,
                              height: media.height * 0.05,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
