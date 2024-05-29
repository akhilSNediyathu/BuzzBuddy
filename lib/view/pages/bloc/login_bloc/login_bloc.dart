import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/repository/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLoginButtonClickEvent>((event, emit) async{
      emit(LoginLoadingState());
      final response =  await AuthenticationRepo.userLogin(event.email, event.password);
      if(response !=null && response.statusCode==200){
        return emit(LoginSuccesState());
      }else if(response!=null){
        final responseData = jsonDecode(response.body);
        return emit(LoginErrorState(error: responseData["message"]));

      }else{
        return emit(LoginErrorState(error: 'something went wrong'));
      }

      

      
    });
  }
}
