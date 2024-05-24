import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/login_signup_row.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/main_page/screen_main.dart';
import 'package:buzz_buddy/view/pages/signup/screen_register.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
   ScreenLogin({super.key});
   final TextEditingController _usernameController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
            height: media.height,
            width: media.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: media.height * 0.15, child: Image.asset(logo)),
                  kheight50,
                  const CustomTextField(hintText: 'username',validator: validateUsername,),
                  kheight,
                  const CustomTextField2(hintText: 'password'
                  ,validator: validatePassword,
                  
                  ),
                  kheight,
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       TextButton(onPressed: (){}, child: const Text('Forgot password?',style: TextStyle(color: kPrimaryColor))),
                     ],
                   ),
                  
                  customButton(media: media,color: kPrimaryColor, buttonText: 'LogIn', onPressed: () {
                    if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>ScreenMainScreen()));
                            } else {
                              customSnackbar(context, 'Fill All Fields', red);
                            }

                  }),
                  kheight,
                   const Text('or'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: media.height*0.03,
                        child: Image.asset(googleLogo)),
                       
                      Flexible(child: TextButton(onPressed: (){

                      }, child: const Text('Sign In With Google?',style: TextStyle(color: kPrimaryColor))))
                    ],
                  ),loginAndSignUpRow(
                      context: context,
                      preText: 'New User? Join Us Today! ',
                      buttonText: 'Register here',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenRegister()));
                      }),
                  kheight50,
                ],
              ),
            ),
                    ),
                  ),
          )),
    );
  }
}
