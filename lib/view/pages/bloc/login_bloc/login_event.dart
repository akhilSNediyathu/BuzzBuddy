part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}
class OnLoginButtonClickEvent extends LoginEvent{
  final String email;
  final String password;

  OnLoginButtonClickEvent({required this.email, required this.password});

  
}
