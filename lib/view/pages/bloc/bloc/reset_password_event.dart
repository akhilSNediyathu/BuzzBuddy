part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordEvent {}
class OnVerifyButtonClickedEvent extends ResetPasswordEvent{
  final String otp;
  final String email;

  OnVerifyButtonClickedEvent({required this.otp, required this.email});

}
class OnResetPasswordButtonClickedEvent extends ResetPasswordEvent{
  final String email;
  final String password;

  OnResetPasswordButtonClickedEvent({required this.email, required this.password});


}
