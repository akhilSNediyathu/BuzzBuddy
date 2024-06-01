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




