import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/model/user_model.dart';
import 'package:buzz_buddy/repository/authentication_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';


part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {


    on<OnSignupButtonClickedEvent>((event, emit)async {
      if (kDebugMode) {
        print("loading...............");
      }
      emit(SignUpLoadingSate());

      UserModel finalDatas = UserModel(
                                userName: event.userName,
                                password: event.password,
                                phoneNumber: event.phoneNumber,
                                emailId: event.email,
                              );

     Response? response =  await AuthenticationRepo().sentOtp(finalDatas);
     if(response!=null &&response.statusCode==200){
      return emit(SignUpSuccesState());

     }else if (response !=null){
      
      
      final responseData = jsonDecode(response.body);
       
      return emit(SignUpErrorState(error:responseData["message"]));
     }else{
       return emit(SignUpErrorState(error: "something went wrong"));
     }

    });
   
  }
   
}
