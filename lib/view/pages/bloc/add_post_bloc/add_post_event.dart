part of 'add_post_bloc.dart';

@immutable
sealed class AddPostEvent {}
final class OnPostButtonClickedEvent extends AddPostEvent{
  final String imagePath;
  final String description;

  OnPostButtonClickedEvent({required this.imagePath, required this.description});
}

