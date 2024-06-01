part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {}
final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoadingState extends ForgotPasswordState {}
final class ForgotPasswordErrorState extends ForgotPasswordState {
  final String error;

  ForgotPasswordErrorState({required this.error});
}
final class ForgotPasswordSuccesState extends ForgotPasswordState {}
//opt verification
final class OtpverifiedSuccesState extends ForgotPasswordState {

}
final class OtpverifiedErrorState extends ForgotPasswordState {
  final String error;

  OtpverifiedErrorState({required this.error});
  

}
final class OtpverifiedLoadingState extends ForgotPasswordState {

}
// reset password

final class ResetPasswordSuccesState extends ForgotPasswordState{}
final class ResetPasswordLoadingState extends ForgotPasswordState{}
final class ResetPasswordErrorState extends ForgotPasswordState{
  final String error;

  ResetPasswordErrorState({required this.error});
}



