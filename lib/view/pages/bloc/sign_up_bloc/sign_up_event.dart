part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}
class OnSignupButtonClickedEvent extends SignUpEvent{
 final String userName;
 final String password;
 final String phoneNumber; 
 final String email;

  OnSignupButtonClickedEvent({required this.userName, required this.password, required this.phoneNumber, required this.email});


}
