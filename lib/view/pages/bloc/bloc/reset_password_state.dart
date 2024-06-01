part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}
final class OtpverifiedSuccesState extends ResetPasswordState {

}
final class OtpverifiedErrorState extends ResetPasswordState {
  final String error;

  OtpverifiedErrorState({required this.error});
  

}
final class OtpverifiedLoadingState extends ResetPasswordState {

}
// reset password

final class ResetPasswordSuccesState extends ResetPasswordState{}
final class ResetPasswordLoadingState extends ResetPasswordState{}
final class ResetPasswordErrorState extends ResetPasswordState{
  final String error;

  ResetPasswordErrorState({required this.error});
}
