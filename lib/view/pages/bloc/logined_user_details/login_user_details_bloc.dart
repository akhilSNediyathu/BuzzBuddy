import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/model/logined_user_details_model.dart';
import 'package:buzz_buddy/repository/user_repo.dart';
import 'package:meta/meta.dart';

part 'login_user_details_event.dart';
part 'login_user_details_state.dart';

class LoginUserDetailsBloc
    extends Bloc<LoginUserDetailsEvent, LoginUserDetailsState> {
  LoginUserDetailsBloc() : super(LoginUserDetailsInitial()) {
    on<OnLoginedUserDataFetchEvent>((event, emit) async {
      emit(LoginUserDetailsDataFetchLoadingState());
      final response = await UserRepo.fetchLoggedInUserDetails();
      if (response != null && response.statusCode == 200) {
    
        final responseBody = jsonDecode(response.body);
        final LoginUserModel model = LoginUserModel.fromJson(responseBody);
        return emit(LoginUserDetailsDataFetchSuccesState(userModel: model));
      } else {
        return emit(LoginUserDetailsDataFetchErrorState());
      }
    });
  }
}
