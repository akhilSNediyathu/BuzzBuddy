part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccesState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}

final class LoginLoadingState extends LoginState {}

final class GoogleAuthLoadingstate extends LoginState {}
