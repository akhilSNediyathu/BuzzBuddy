
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/bloc/forgot_pass_bloc/forgot_password_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/login/forgotpassword/forgotpass_otp_verification/screen_forgot_pass_otp_ver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ScreenPasswordResetMainpage extends StatelessWidget {
  ScreenPasswordResetMainpage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
       
       
        elevation: 0,
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
         if(state is ForgotPasswordSuccesState){
           print('llllllll');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenForgotpassOtpVerificaion(email: _emailController.text,)));
          print('kkkkl');
        
         }else if(state is ForgotPasswordErrorState){
         
          customSnackbar(context, state.error, amber);
         }
        },
        builder: (context, state) {
          return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Forgot Password?',
                    style: coloredBold24
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Don't worry. You can reset it by entering your registered email ID.",
                    style: greyMeduim,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Lottie.asset(
                    'assets/images/change password.json',
                    height: media.height * 0.3,
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      hintText: 'Enter registered email',
                      controller: _emailController,
                      validator: validateEmail,
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      if(state is ForgotPasswordLoadingState){
                        return loadingButton(media: media, onPressed: (){}, color: kPrimaryColor);
                      }
                      return customButton(
                                      onPressed: () {
                                       if (_formKey.currentState?.validate() == true) {
                          context.read<ForgotPasswordBloc>().add(
                                OnForgotPassLoginButtonClicked(
                                  email: _emailController.text,
                                ),
                              );
                        }
                                      },
                                      buttonText: 'Get OTP',
                                      color: kPrimaryColor,
                                      media: media,
                                    );
                    },
                  ),
                ],
              ),
            );
        },
      ),
    );
  }
}
