// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:buzz_buddy/model/my_post_model/my_post_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/add_post/widgets/add_post_text_fields.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ScreenUpdateUserPost extends StatelessWidget {
  final MyPostModel model;
  ScreenUpdateUserPost({super.key, required this.model}) {
    textController.text = model.description.toString();
  }

  final ValueNotifier<String> pickNewImage = ValueNotifier('');
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  late XFile? file;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit Post', style: appBarTitleStyle),
        ),
        body: BlocConsumer<FetchMyPostBloc, FetchMyPostState>(
          listener: (context, state) {
            if (state is EditUserPostSuccesState) {
              customSnackbar(context, 'Post edited successfully', green);
              Navigator.pop(context);
            } else if (state is EditUserPosterrorState) {
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
                        valueListenable: pickNewImage,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              file = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                              if (file != null) {
                                pickNewImage.value = file!.path;
                              }
                            },
                            child: Container(
                              color: grey,
                              width: media.width,
                              height: media.height * 0.4,
                              child: pickNewImage.value == ''
                                  ? CachedNetworkImage(
                                      imageUrl: model.image.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return LoadingAnimationWidget
                                            .fourRotatingDots(
                                                color: grey, size: 30);
                                      },
                                    )
                                  : Image.file(File(pickNewImage.value),
                                      fit: BoxFit.cover),
                            ),
                          );
                        },
                      ),
                      kheight20,
                      PostTextFormField(
                        controller: textController,
                        hintText: 'Write a caption...',
                        keyboard: TextInputType.text,
                        validator:
                            validatePostdesctiption, // Use the new validation function
                      ),
                      kheight50,
                      BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
                        builder: (context, state) {
                          if (state is EditUserPostLoadingState ||
                              state is FetchMyPostLoadingState) {
                            return loadingButton(
                                media: media,
                                onPressed: () {},
                                color: kPrimaryColor);
                          }
                          return customMaterialButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<FetchMyPostBloc>().add(
                                        OnEditPostButtonClicked(
                                          image: pickNewImage.value,
                                          description: textController.text,
                                          imageUrl: model.image.toString(),
                                          postId: model.id.toString(),
                                        ),
                                      );
                                }
                              },
                              text: 'Save',
                              color: kPrimaryColor,
                              width: media.width,
                              height: media.height * 0.06);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
