import 'package:buzz_buddy/repository/authentication_repo.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenPasswordResetMainpage extends StatelessWidget {
  ScreenPasswordResetMainpage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
       
       
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
            customButton(
              onPressed: () {
                AuthenticationRepo.verifyOtpPasswordReset('akhilsree1436@gmail.com', '1252');
              },
              buttonText: 'Get OTP',
              color: kPrimaryColor,
              media: media,
            ),
          ],
        ),
      ),
    );
  }
}
