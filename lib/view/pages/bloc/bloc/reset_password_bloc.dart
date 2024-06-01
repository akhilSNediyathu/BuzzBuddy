import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/repository/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
     on<OnVerifyButtonClickedEvent>((event, emit)async {
      emit(OtpverifiedLoadingState());
      var response = await AuthenticationRepo.verifyOtpPasswordReset(event.email,event.otp);
      if(response!=null && response.statusCode==200){
      var responseBody = jsonDecode(response.body);
     if(responseBody["used"]){
       return emit(OtpverifiedSuccesState());
     }else{
      return emit(OtpverifiedErrorState(error:responseBody["message"]));
     }
     }
     
     else{
      return emit(OtpverifiedErrorState(error: 'something went wrong'));
     }
      
    },);
      on<OnResetPasswordButtonClickedEvent>((event, emit) async{
       emit(ResetPasswordSuccesState());
       var response = await AuthenticationRepo.updatePassword(event.email, event.password);
       if(response!=null && response.statusCode==200){
              return emit(ResetPasswordSuccesState());
       }else if(response!=null){
          var finalResponse = jsonDecode(response.body);
          return emit(ResetPasswordErrorState(error:finalResponse["message"]));

       }else{
        return emit(ResetPasswordErrorState(error: 'Something went wrong'));
       }
    },);
  }
}
