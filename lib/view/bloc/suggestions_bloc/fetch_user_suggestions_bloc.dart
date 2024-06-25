import 'dart:convert';


import 'package:bloc/bloc.dart';

import 'package:buzz_buddy/model/user_suggestion_model/user_suggestion_model.dart';
// import 'package:buzz_buddy/model/user_suggestion_model.dart';
import 'package:buzz_buddy/repository/user_repo.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'fetch_user_suggestions_event.dart';
part 'fetch_user_suggestions_state.dart';

class FetchUserSuggestionsBloc
    extends Bloc<FetchUserSuggestionsEvent, FetchUserSuggestionsState> {
  FetchUserSuggestionsBloc() : super(FetchUserSuggestionsInitial()) {
    on<OnfetchUserSuggestionEvent>((event, emit) async {
      emit(FetchUserSuggestionsLoadingState());

      final Response? result = await UserRepo.fetchSuggessionUser();

      if (result != null && result.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(result.body);

      // log(result.body);

        final UserSuggestionModel userSuggessionModel =
            UserSuggestionModel.fromJson(responseBody);
       // log(result.body);

        emit(FetchUserSuggestionsSuccessState(
            suggessionModel: userSuggessionModel));
      } else if (result != null && result.statusCode == 500) {
        emit(FetchUserSuggestionsErroState(error: 'server not responding'));
      } else {
        emit(FetchUserSuggestionsErroState(error: 'something went wrong'));
      }
    });
  }
}
