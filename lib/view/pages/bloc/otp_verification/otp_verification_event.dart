part of 'otp_verification_bloc.dart';

@immutable
sealed class OtpVerificationEvent {}
class OnOtpVerifyButtonClicked extends OtpVerificationEvent{
  final String otp;

  OnOtpVerifyButtonClicked({required this.otp});

}
