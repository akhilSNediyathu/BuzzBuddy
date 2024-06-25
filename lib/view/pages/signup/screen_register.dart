import 'package:buzz_buddy/model/user_model.dart';

import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/login_signup_row.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:buzz_buddy/view/pages/signup/otp_screen/screen_otp.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenRegister extends StatelessWidget {
  ScreenRegister({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          // backgroundColor: kwhiteColor,
          body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccesState) {
            customSnackbar(context, 'success', green);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => ScreenOtp(
                      email: _emailController.text,
                      user: UserModel(
                          userName: _usernameController.text,
                          password: _passwordController.text,
                          phoneNumber: _phoneController.text,
                          emailId: _emailController.text),
                    )));
          } else if (state is SignUpErrorState) {
            customSnackbar(context, state.error, red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: media.height,
              width: media.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: media.height * 0.15,
                          child: Image.asset(logo)),
                      kheight,
                      Image.asset(
                        welcomeText,
                        width: media.width * 0.5,
                      ),
                      kheight50,
                      CustomTextField(
                        controller: _usernameController,
                        hintText: 'Username',
                        validator: validateUsername,
                      ),
                      kheight15,
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        validator: validateEmail,
                      ),
                      kheight15,
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        hintText: 'Phone No',
                        validator: validateMobileNumber,
                      ),
                      kheight15,
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        validator: validatePassword,
                      ),
                      kheight15,
                      CustomTextField(
                        hintText: 'Confirm Password',
                        controller: _confirmPasswordController,
                      ),
                      kheight,
                      loginAndSignUpRow(
                          context: context,
                          preText: 'Already have an account?',
                          buttonText: 'LogIn Now',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenLogin()));
                          }),
                      kheight50,
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          if (state is SignUpLoadingSate) {
                            return loadingButton(
                                media: media,
                                onPressed: () {},
                                color: kPrimaryColor);
                          }
                          return customButton(
                              color: kPrimaryColor,
                              media: media,
                              buttonText: 'Register',
                              onPressed: () async {
                                if (_passwordController.text ==
                                    _confirmPasswordController.text) {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignUpBloc>().add(
                                        OnSignupButtonClickedEvent(
                                            userName: _usernameController.text,
                                            password: _passwordController.text,
                                            phoneNumber: _phoneController.text,
                                            email: _emailController.text));
                                  } else {
                                    customSnackbar(
                                        context, 'Fill All Fields', red);
                                  }
                                  // else{
                                  //  customSnackbar(context, 'something went wrong', red);
                                  // }
                                } else {
                                  customSnackbar(
                                      context, 'Password miss match', red);
                                }
                              });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
