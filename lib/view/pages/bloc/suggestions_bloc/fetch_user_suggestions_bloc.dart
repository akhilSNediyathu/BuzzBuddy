import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/model/user_suggestion_model.dart';
import 'package:buzz_buddy/repository/user_repo.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'fetch_user_suggestions_event.dart';
part 'fetch_user_suggestions_state.dart';

class FetchUserSuggestionsBloc extends Bloc<FetchUserSuggestionsEvent, FetchUserSuggestionsState> {
  FetchUserSuggestionsBloc() : super(FetchUserSuggestionsInitial()) {
    on<OnfetchUserSuggestionEvent>((event, emit) async{
      emit(FetchUserSuggestionsLoadingState());

     
      final Response? result = await UserRepo.fetchSuggessionUser();
   
    if (result!=null && result.statusCode == 200) {
      final responseBody = jsonDecode(result.body);
      final SuggessionModel suggessionModel =
          SuggessionModel.fromJson(responseBody);
      emit(FetchUserSuggestionsSuccessState(suggessionModel: suggessionModel));
    } else if(result!=null &&result.statusCode==500){
      emit(FetchUserSuggestionsErroState(error: 'server not responding'));

    }else {
      emit(FetchUserSuggestionsErroState(error: 'something went wrong'));
    }
    });
  }
}
