part of 'login_user_details_bloc.dart';

@immutable
sealed class LoginUserDetailsState {}

final class LoginUserDetailsInitial extends LoginUserDetailsState {}

final class LoginUserDetailsDataFetchSuccesState extends LoginUserDetailsState {
  final LoginUserModel userModel;

  LoginUserDetailsDataFetchSuccesState({required this.userModel});
}

final class LoginUserDetailsDataFetchErrorState
    extends LoginUserDetailsState {}

final class LoginUserDetailsDataFetchLoadingState
    extends LoginUserDetailsState {}
