part of 'add_post_bloc.dart';

@immutable
sealed class AddPostEvent {}
final class OnPostButtonClickedEvent extends AddPostEvent{}
final class OnImageSelectionToPostEvent extends AddPostEvent{}
