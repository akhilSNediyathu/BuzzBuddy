import 'package:buzz_buddy/model/user_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/bloc/otp_verification/otp_verification_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:buzz_buddy/view/pages/signup/otp_screen/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';
import 'dart:async';

class ScreenOtp extends StatefulWidget {
  final UserModel user;
  final String email;
  const ScreenOtp({super.key, required this.email, required this.user});

  @override
  State<ScreenOtp> createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  late Timer _timer;
  Timer? _debounceTimer;
  int _start = 60;
  bool _isResendVisible = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _debounceTimer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _isResendVisible = false;
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendVisible = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void debounceResendOtp(SignUpBloc signUpBloc) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      signUpBloc.add(OnSignupButtonClickedEvent(
          userName: widget.user.userName,
          password: widget.user.password,
          phoneNumber: widget.user.phoneNumber,
          email: widget.user.emailId));
      startTimer(); // Restart the timer
    });
  }

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
    final signUpBloc = context.read<SignUpBloc>();
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
        listener: (context, state) {
          if (state is OtpVerificationSuccesState) {
            customSnackbar(context, ' otp verfication succen', Colors.green);
            for (var controller in _controllers) {
              controller.clear();
            }
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ScreenLogin()),
              (Route<dynamic> route) => false,
            );
          } else if (state is OtpVerificationErrrorState) {
            customSnackbar(context, 'Invalid OTP', Colors.amber);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter the OTP',
                      style: coloredBold24,
                    ),
                    kheight,
                    Text(
                      'We have sent you an OTP to \n ${widget.email}.',
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
                    BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
                      builder: (context, state) {
                        if (state is OtpVerificationLoadingState) {
                          return loadingButton(
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
                              context.read<OtpVerificationBloc>().add(
                                  OnOtpVerifyButtonClicked(
                                      otp: otp, email: widget.email));

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
                    ),
                    kheight20,
                    _isResendVisible
                        ? TextButton(
                            onPressed: () {
                              debounceResendOtp(signUpBloc);
                            },
                            child: const Text(
                              'Resend OTP',
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                            ),
                          )
                        : Text(
                            'Resend OTP in $_start seconds',
                            style: const TextStyle(color: grey, fontSize: 16),
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
