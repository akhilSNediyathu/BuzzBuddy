part of 'like_unlike_post_bloc.dart';

@immutable
sealed class LikeUnlikePostEvent {}
class LikePostButtonClickEvent extends LikeUnlikePostEvent {
  final String postId;

  LikePostButtonClickEvent({required this.postId});
}

class UnlikePostButtonClickEvent extends LikeUnlikePostEvent {
  final String postId;

  UnlikePostButtonClickEvent({required this.postId});
}
