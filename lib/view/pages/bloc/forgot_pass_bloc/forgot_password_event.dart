part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}
class OnForgotPassLoginButtonClicked extends ForgotPasswordEvent{
  final String email;

  OnForgotPassLoginButtonClicked({required this.email});

}
class OnVerifyButtonClickedEvent extends ForgotPasswordEvent{
  final String otp;
  final String email;

  OnVerifyButtonClickedEvent({required this.otp, required this.email});

}
class OnResetPasswordButtonClickedEvent extends ForgotPasswordEvent{
  final String email;
  final String password;

  OnResetPasswordButtonClickedEvent({required this.email, required this.password});


}