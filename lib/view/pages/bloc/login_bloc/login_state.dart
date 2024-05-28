part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccesState extends LoginState {}

final class LoginInitialErrorState extends LoginState {}

final class LoginInitialLoading extends LoginState {}
