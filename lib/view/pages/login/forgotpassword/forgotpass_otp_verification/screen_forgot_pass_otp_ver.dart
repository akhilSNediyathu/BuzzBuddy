import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';

import 'package:buzz_buddy/view/pages/bloc/forgot_pass_bloc/forgot_password_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:buzz_buddy/view/pages/signup/otp_screen/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ScreenForgotpassOtpVerificaion extends StatelessWidget {
  final String email;

  ScreenForgotpassOtpVerificaion({super.key, required this.email});
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController _newPassWordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validateOtp() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty ||
          controller.text.length != 1 ||
          !RegExp(r'^[0-9]$').hasMatch(controller.text)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccesState) {
          customSnackbar(context, 't', green);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return ScreenLogin();
            }),
            (Route<dynamic> route) => false,
          );
        } else if (state is OtpverifiedErrorState) {
          customSnackbar(context, state.error, amber);
        } else if (state is ResetPasswordErrorState) {
          customSnackbar(context, state.error, amber);
        }
      },
      builder: (context, state) {
        return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            if (state is OtpverifiedSuccesState) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Reset password',
                    style: coloredBold24,
                  ),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: media.height,
                      width: media.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: media.height * 0.15,
                              child: Image.asset(logo)),
                          kheight20,
                          SizedBox(
                            height: media.height * 0.4,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextField(
                                    hintText: 'Enter new password',
                                    controller: _newPassWordController,
                                    validator: validatePassword,
                                  ),
                                  kheight,
                                  CustomTextField(
                                    hintText: 'Re-enter new password',
                                    controller: _confirmPasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                      if (value !=
                                          _newPassWordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),
                                  kheight50,
                                  BlocBuilder<ForgotPasswordBloc,
                                      ForgotPasswordState>(
                                    builder: (context, state) {
                                      if (state is ResetPasswordLoadingState) {
                                        loadingButton(
                                            media: media,
                                            onPressed: () {},
                                            color: kDefaultIconLightColor);
                                      }
                                      return customButton(
                                        media: media,
                                        buttonText: 'Save',
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<ForgotPasswordBloc>().add(
                                                OnResetPasswordButtonClickedEvent(
                                                    email: email,
                                                    password:
                                                        _confirmPasswordController
                                                            .text));
                                          } else {
                                            customSnackbar(context,
                                                'Please fix the errors', red);
                                          }
                                        },
                                        color: kPrimaryColor,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter the OTP',
                        style: coloredBold24,
                      ),
                      kheight,
                      const Text(
                        'We have sent you an OTP to your registred email.',
                        style: greyMeduim,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: media.height * 0.3,
                        child: LottieBuilder.asset('assets/images/otp.json'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(4, (index) {
                          return textBoxWidget(
                            context: context,
                            controller: _controllers[index],
                          );
                        }),
                      ),
                      kheight50,
                      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        builder: (context, state) {
                          if (state is OtpverifiedLoadingState) {
                            loadingButton(
                                media: media,
                                onPressed: () {},
                                color: kPrimaryColor);
                          }
                          return customMaterialButton(
                            onPressed: () async {
                              if (validateOtp()) {
                                String otp = _controllers
                                    .map((controller) => controller.text)
                                    .join();
                                debugPrint('Entered OTP: $otp');

                                context.read<ForgotPasswordBloc>().add(
                                    OnVerifyButtonClickedEvent(
                                        email: email, otp: otp));

                                for (var controller in _controllers) {
                                  controller.clear();
                                }
                              } else {
                                customSnackbar(
                                    context,
                                    'Please enter a valid 4-digit OTP',
                                    Colors.red);
                              }
                            },
                            text: 'Verify',
                            color: kPrimaryColor,
                            width: media.width,
                            height: media.height * 0.05,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
