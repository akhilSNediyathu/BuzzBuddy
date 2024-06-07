import 'package:buzz_buddy/firebase_options.dart';
import 'package:buzz_buddy/utils/themes.dart';
import 'package:buzz_buddy/view/pages/bloc/add_post_bloc/add_post_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';

import 'package:buzz_buddy/view/pages/bloc/forgot_pass_bloc/forgot_password_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/login_bloc/login_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/otp_verification/otp_verification_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:buzz_buddy/view/pages/splash_screen/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => OtpVerificationBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(),
        ),
        BlocProvider(
          create: (context) => AddPostBloc(),
        ),
        BlocProvider(
          create: (context) => FetchMyPostBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightModeTheme,
        
             darkTheme: Themes.darkModeTheme,
             
        home: const ScreenSplash(),
      ),
    );
  }
}
