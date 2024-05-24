import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/login_signup_row.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/login/screen_login.dart';

import 'package:flutter/material.dart';

class ScreenRegister extends StatelessWidget {
  ScreenRegister({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: kwhiteColor,
          body: SingleChildScrollView(
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
                          height: media.height * 0.15, child: Image.asset(logo)),
                      kheight,
                      Image.asset(welcomeText),
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
                      customButton(color: kPrimaryColor,
                          media: media, buttonText: 'Register', onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>))
                              print('succes');
                            } else {
                              customSnackbar(context, 'Fill All Fields', red);
                            }

                          })
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
