import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/repository/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<OnForgotPassLoginButtonClicked>((event, emit)async {
      emit(ForgotPasswordLoadingState());
      var response =await AuthenticationRepo.resetPassSendOtp(event.email);
      
     if(response!=null && response.statusCode==200){
      var responseBody = jsonDecode(response.body);
     if(responseBody["used"]){
       return emit(ForgotPasswordSuccesState());
     }else{
      return emit(ForgotPasswordErrorState(error:responseBody["message"]));
     }
     }
     
     else{
      return emit(ForgotPasswordErrorState(error: 'something went wrong'));
     }

    });
  }
}
