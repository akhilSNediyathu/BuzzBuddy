part of 'fetch_user_suggestions_bloc.dart';

@immutable
sealed class FetchUserSuggestionsEvent {}
final class OnfetchUserSuggestionEvent extends FetchUserSuggestionsEvent{}
