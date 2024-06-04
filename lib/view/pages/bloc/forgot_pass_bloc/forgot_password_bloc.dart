import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/repository/authentication_repo.dart';
import 'package:flutter/foundation.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<OnForgotPassLoginButtonClicked>((event, emit) async {
      emit(ForgotPasswordLoadingState());
      var response = await AuthenticationRepo.resetPassSendOtp(event.email);
      if (kDebugMode) {
        print('kkkkkk');
      }

      if (response != null && response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody["status"] == 200) {
          return emit(ForgotPasswordSuccesState());
        } else {
          return emit(ForgotPasswordErrorState(error: responseBody["message"]));
        }
      } else {
        return emit(ForgotPasswordErrorState(error: 'something went wrong'));
      }
    });
    on<OnVerifyButtonClickedEvent>(
      (event, emit) async {
        emit(OtpverifiedLoadingState());
        var response = await AuthenticationRepo.verifyOtpPasswordReset(
            event.email, event.otp);
        if (response != null && response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (responseBody["status"]) {
            return emit(OtpverifiedSuccesState());
          } else {
            if (kDebugMode) {
              print(responseBody);
            }
            return emit(OtpverifiedErrorState(error: 'invalid OTP'));
          }
        } else {
          return emit(OtpverifiedErrorState(error: 'something went wrong'));
        }
      },
    );
    on<OnResetPasswordButtonClickedEvent>(
      (event, emit) async {
        emit(ResetPasswordSuccesState());
        var response = await AuthenticationRepo.updatePassword(
            event.email, event.password);
        if (response != null && response.statusCode == 200) {
          return emit(ResetPasswordSuccesState());
        } else if (response != null) {
          var finalResponse = jsonDecode(response.body);
          return emit(ResetPasswordErrorState(error: finalResponse["message"]));
        } else {
          return emit(ResetPasswordErrorState(error: 'Something went wrong'));
        }
      },
    );
  }
}
