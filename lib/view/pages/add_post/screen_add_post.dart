// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/add_post/widgets/add_post_text_fields.dart';
import 'package:buzz_buddy/view/pages/bloc/add_post_bloc/add_post_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

final ValueNotifier<String> pickImage = ValueNotifier('');

class ScreenAddPost extends StatelessWidget {
  ScreenAddPost({super.key});

  final List<AssetEntity> selectedAssetList = [];
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  late XFile? file;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text('Start Post', style: appBarTitleStyle),
      ),
      body: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) {
          if (state is AddPostSuccesState) {
            customSnackbar(context, 'Post added successfully', green);
            pickImage.value = '';
            textController.clear();
          } else if (state is AddPostErrorState) {
            customSnackbar(context, state.error, amber);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: pickImage,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () async {
                            file = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );
                            if (file != null) {
                              print(file!.path);
                              pickImage.value = file!.path;
                            }
                          },
                          child: Container(
                            color: grey,
                            width: media.width,
                            height: media.height * 0.4,
                            child: pickImage.value == ''
                                ? Image.asset(imagePicker)
                                : Image.file(File(pickImage.value),
                                    fit: BoxFit.cover),
                          ),
                        );
                      },
                    ),
                    kheight,
                    PostTextFormField(
                      controller: textController,
                      hintText: 'Write a caption...',
                      keyboard: TextInputType.text,
                      validator: validatePostdesctiption,
                    ),
                    kheight50,
                    BlocBuilder<AddPostBloc, AddPostState>(
                      builder: (context, state) {
                        if (state is AddPostLoadingstate) {
                          return loadingButton(
                            media: media,
                            onPressed: () {},
                            color: kPrimaryColor,
                          );
                        }
                        return customMaterialButton(
                          onPressed: () async{
                            if (_formKey.currentState!.validate()) {
                              if (pickImage.value != '' &&
                                  textController.text.isNotEmpty) {
                                context.read<AddPostBloc>().add(
                                      OnPostButtonClickedEvent(
                                        imagePath: pickImage.value,
                                        description: textController.text,
                                      ),
                                    );
                                 context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
                              } else {
                                customSnackbar(
                                    context, 'select an image', amber);
                              }
                            }
                          },
                          text: 'Post',
                          color: kPrimaryColor,
                          width: media.width,
                          height: media.height * 0.06,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
