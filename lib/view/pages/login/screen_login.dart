
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/utils/validations.dart';
import 'package:buzz_buddy/view/pages/bloc/login_bloc/login_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/classwidget/textfield.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/custom_button.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/login_signup_row.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/login/forgotpassword/screen_password_reset_mainpage.dart';
import 'package:buzz_buddy/view/pages/main_page/screen_main.dart';
import 'package:buzz_buddy/view/pages/signup/screen_register.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
         if(state is LoginSuccesState){
          customSnackbar(context, 'welcome back', green);
                                 Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ScreenMainScreen();
                    }),
                    (Route<dynamic> route) => false,
                  );
         } else if (state is LoginErrorState){
           customSnackbar(context, state.error, red);
         }
        },
        builder: (context, state) {
          return SafeArea(
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
                         CustomTextField(hintText: 'username',validator: validateUsername,controller:_usernameController,),
                        kheight,
                         CustomTextField2(hintText: 'password'
                        ,validator: validatePassword,
                        controller: _passwordController,
                        
                        ),
                        kheight,
                         Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenPasswordResetMainpage(),));
                             }, child: const Text('Forgot password?',style: TextStyle(color: kPrimaryColor))),
                           ],
                         ),
                        
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if(state is LoginLoadingState){
                              return loadingButton(media: media, onPressed: (){}, color: kPrimaryColor);
                            }
                            return customButton(media: media,color: kPrimaryColor, buttonText: 'LogIn', onPressed: () async{
                                                  if (_formKey.currentState!.validate()) {
                                                             context.read<LoginBloc>().add(OnLoginButtonClickEvent(email: _usernameController.text, password: _passwordController.text)) ;
                                                  
                                                          } else {
                                                            customSnackbar(context, 'Fill All Fields', red);
                                                          }
                              
                                                });
                          },
                        ),
                        kheight,
                         const Text('or'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: media.height*0.03,
                              child: Image.asset(googleLogo)),
                             
                            Flexible(child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if(state is GoogleAuthLoadingstate){
                                  return const CircularProgressIndicator();
                                }
                                return TextButton(onPressed: ()async{
                                         context.read<LoginBloc>().add(OnGoogleSignInButtonClickedEvent()) ;             
                                  
                                                        }, child: const Text('Sign In With Google?',style: TextStyle(color: kPrimaryColor)));
                              },
                            ))
                          ],
                        ),loginAndSignUpRow(
                            context: context,
                            preText: 'New User? Join Us Today! ',
                            buttonText: 'Register here',
                            onPressed: () async{
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenRegister(),));
                           
                            }),
                        kheight50,
                      ],
                    ),
                  ),
                          ),
                        ),
                ));
        },
      ),
    );
  }

}
