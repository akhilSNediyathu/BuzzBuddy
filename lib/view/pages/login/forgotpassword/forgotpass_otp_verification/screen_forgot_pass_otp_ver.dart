
import 'package:flutter/material.dart';

class ScreenForgotpassOtpVerificaion extends StatelessWidget {
   ScreenForgotpassOtpVerificaion({super.key});
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
    bool validateOtp() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty || controller.text.length != 1 || !RegExp(r'^[0-9]$').hasMatch(controller.text)) {
        return false;
      }
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('hoo'),),
    );
  }
}