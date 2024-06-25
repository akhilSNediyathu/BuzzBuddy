part of 'fetch_user_suggestions_bloc.dart';

@immutable
sealed class FetchUserSuggestionsState {}

final class FetchUserSuggestionsInitial extends FetchUserSuggestionsState {}

final class FetchUserSuggestionsSuccessState extends FetchUserSuggestionsState {
  final UserSuggestionModel suggessionModel;

  FetchUserSuggestionsSuccessState({required this.suggessionModel});
}

final class FetchUserSuggestionsErroState extends FetchUserSuggestionsState {
  final String error;

  FetchUserSuggestionsErroState({required this.error});
}

final class FetchUserSuggestionsLoadingState
    extends FetchUserSuggestionsState {}
