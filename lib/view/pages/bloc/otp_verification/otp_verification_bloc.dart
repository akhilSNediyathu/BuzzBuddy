import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/repository/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc() : super(OtpVerificationInitial()) {
    on<OnOtpVerifyButtonClicked>((event, emit) async {
      emit(OtpVerificationLoadingState());
      var response = await AuthenticationRepo.verifyOtp(event.email, event.otp);
      if (response != null && response.statusCode == 200) {
        return emit(OtpVerificationSuccesState());
      } else if (response != null) {
        final responseData = jsonDecode(response.body);

        return emit(OtpVerificationErrrorState(error: responseData["message"]));
      } else {
        return emit(OtpVerificationErrrorState(error: "something went wrong"));
      }
    });
  }
}
