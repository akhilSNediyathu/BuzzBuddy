import 'package:buzz_buddy/repository/authentication_repo.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/login/screen_login.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:buzz_buddy/view/pages/signup/otp_screen/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'dart:async';

class ScreenOtp extends StatefulWidget {
  final String email;
  const ScreenOtp({super.key, required this.email});

  @override
  _ScreenOtpState createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  late Timer _timer;
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
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
                const Text(
                  'We have sent you an OTP to your email.',
                  style: greyMeduim,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: media.height*0.3,
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
                customMaterialButton(
                  onPressed: ()async {
                    String otp = _controllers.map((controller) => controller.text).join();
                    print('Entered OTP: $otp');
                   var response = await AuthenticationRepo().verifyOtp(widget.email, otp);
                   if(response!=null && response.statusCode==200){
                    Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => ScreenLogin()),
  (Route<dynamic> route) => false,
);
                   }
                   else{
                    _controllers.clear();
                    customSnackbar(context, 'invalid otp', Colors.amber);
                   }
                  },
                  text: 'Verify',
                  color: kPrimaryColor,
                  width: media.width,
                  height: media.height * 0.05,
                ),
                kheight20,
                _isResendVisible
                    ? TextButton(
                        onPressed: () {
                          // Handle resend OTP logic here
                          startTimer(); // Restart the timer
                        },
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(color: kPrimaryColor, fontSize: 16),
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
      ),
    );
  }
}