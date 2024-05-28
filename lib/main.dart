import 'package:buzz_buddy/view/pages/bloc/login_bloc/login_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/otp_verification/otp_verification_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:buzz_buddy/view/pages/splash_screen/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Ensure this import for BlocProvider

void main() {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const ScreenSplash(),
      ),
    );
  }
}
