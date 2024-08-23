import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/bloc/edit_user_profile_bloc/edit_user_profile_bloc.dart';
import 'package:buzz_buddy/view/bloc/logined_user_details/login_user_details_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/app_bars.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/profile/edit_profile/widgets/widgets.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenEditProfile extends StatefulWidget {
  const ScreenEditProfile(
      {super.key, required this.cvImage, required this.prImage});
  final String cvImage;
  final String prImage;

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ValueNotifier<String> profileImageNotifier = ValueNotifier('');
  final ValueNotifier<String> coverImageNotifier = ValueNotifier('');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String profileImageUrl = '';
  String coverImageUrl = '';

  @override
  void initState() {
    super.initState();
    context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar('Edit Profile', true),
      body: BlocConsumer<LoginUserDetailsBloc, LoginUserDetailsState>(
        listener: (context, state) {
          if (state is LoginUserDetailsDataFetchSuccesState) {
            nameController.text = state.userModel.userName;
            bioController.text = state.userModel.bio ?? '';
            profileImageUrl = state.userModel.profilePic;
            coverImageUrl = state.userModel.backGroundImage;
          }
        },
        builder: (context, userDetailsState) {
          return BlocConsumer<EditUserProfileBloc, EditUserProfileState>(
            listener: (context, state) {
              if (state is EditUserProfileSuccesState) {
                customSnackbar(context, 'Profile details updated', green);
                context
                    .read<LoginUserDetailsBloc>()
                    .add(OnLoginedUserDataFetchEvent());
                Navigator.pop(context);
              }
            },
            builder: (context, editProfileState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ProfileImageSection(
                        coverImageNotifier: coverImageNotifier,
                        profileImageNotifier: profileImageNotifier,
                        cvImage: widget.cvImage,
                        prImage: widget.prImage,
                      ),
                      kheight100,
                      EditProfileForm(
                        formKey: _formKey,
                        nameController: nameController,
                        bioController: bioController,
                      ),
                      const SizedBox(height: 50),
                      buildSaveButton(media, userDetailsState, editProfileState),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildSaveButton(
    Size media,
    LoginUserDetailsState userDetailsState,
    EditUserProfileState editProfileState,
  ) {
    if (editProfileState is EditUserProfileLoadingState ||
        userDetailsState is LoginUserDetailsDataFetchLoadingState) {
      return loadingButton(
        media: media,
        onPressed: () {},
        color: kPrimaryColor,
      );
    }

    return customMaterialButton(
      borderRadius: 20,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (userDetailsState is LoginUserDetailsDataFetchSuccesState) {
            context.read<EditUserProfileBloc>().add(
                  OnEditProfileButtonClickedEvent(
                    name: nameController.text,
                    bio: bioController.text,
                    image: profileImageNotifier.value,
                    imageUrl: userDetailsState.userModel.profilePic,
                    bgImage: coverImageNotifier.value,
                    bgImageUrl: userDetailsState.userModel.backGroundImage,
                  ),
                );
          }
        }
      },
      text: 'Save',
      color: kPrimaryColor,
      width: media.width,
      height: media.height * 0.05,
    );
  }
}
